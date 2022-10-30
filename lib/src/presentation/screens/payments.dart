import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(FluentIcons.arrow_left_16_filled),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleText: "Платежи",
        ),
        body: Builder(
          builder: (context) {
            var value = context.watch<PaymentSnapshot>();
            switch (value.data.status) {
              case ResponseStatus.error:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [Text(value.data.error.toString())],
                );
              case ResponseStatus.loading:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: const [CircularProgressIndicator()],
                );
              default:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    for (var p in value.data.content!) ...[
                      PaymentWidget(
                        name: p.name,
                        dateOfReceiptFormation: p.dateOfReceiptFormation,
                        dateOfServiceEnding: p.dateOfServiceEnding,
                        dateOfServiceStarting: p.dateOfServiceStarting,
                        url: p.url,
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ]
                  ],
                );
            }
          },
        ));
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget(
      {super.key,
      required this.name,
      required this.url,
      required this.dateOfReceiptFormation,
      required this.dateOfServiceEnding,
      required this.dateOfServiceStarting});
  final String name;
  final String url;
  final DateTime dateOfReceiptFormation;
  final DateTime dateOfServiceStarting;
  final DateTime dateOfServiceEnding;

  String getDateString(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: const Color(0xff486581),
          child: InkWell(
            onTap: (() async {
              await launchUrlString(url, mode: LaunchMode.externalApplication);
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 275,
                        child: Text(
                          "$name c ${getDateString(dateOfServiceStarting)} по ${getDateString(dateOfServiceEnding)}",
                          style: const TextStyle(
                            color: Color(0xffbcccdc),
                            fontSize: 13,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff334e68),
                        ),
                        child: Text(
                          getDateString(dateOfReceiptFormation),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Rubik",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    FluentIcons.qr_code_28_regular,
                    size: 45,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
