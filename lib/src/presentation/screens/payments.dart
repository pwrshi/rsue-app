import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(FluentIcons.arrow_left_16_filled),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Платежи",
              style: TextStyle(fontFamily: "Rubik_glitch"),
            )),
        body: FutureBuilder(
          future: Provider.of<PortfolioRepository>(context).getPayments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  for (var p in snapshot.data!.data!) ...[
                    PaymentWidget(
                      name: p.name,
                      dateOfReceiptFormation: p.dateOfReceiptFormation,
                      dateOfServiceEnding: p.dateOfServiceEnding,
                      dateOfServiceStarting: p.dateOfServiceStarting,
                      url: p.url,
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ]
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
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
      child: Container(
        width: 343,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff486581),
        ),
        padding: const EdgeInsets.all(10),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
    );
  }
}
