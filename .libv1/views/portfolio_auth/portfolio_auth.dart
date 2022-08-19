import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../lib_de/view_models/user.dart';

class PortfolioAuth extends StatefulWidget {
  const PortfolioAuth({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PortfolioAuthState();
}

class PortfolioAuthState extends State<PortfolioAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var loginController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Вход в портфолио",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Введите свой логин',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Это поле не может быть пустым';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    controller: loginController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Введите свой пароль',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Это поле не может быть пустым';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passwordController,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (await context.read<UserViewModel>().authorize(
                            loginController.text, passwordController.text)) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text("Зайти"))
              ],
            ),
          )),
    );
  }
}
