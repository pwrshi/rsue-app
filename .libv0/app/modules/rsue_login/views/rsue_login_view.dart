import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rsue_portfolio_api/rsue_portfolio_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/rsue_login_controller.dart';

class RsueLoginView extends GetView<RsueLoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Вход в систему'),
          elevation: 0,
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
                      controller: controller.loginController),
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
                      controller: controller.passwordController,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var data = await whoami(
                              username: controller.loginController.text,
                              password: controller.passwordController.text);
                          if (data == null) {
                            Get.snackbar(
                                "Некорректные данные", "попробуйте ещё раз");
                          } else {
                            var sp = await SharedPreferences.getInstance();
                            sp.setString("rsue_portfolio_login",
                                controller.loginController.text);
                            sp.setString("rsue_portfolio_password",
                                controller.passwordController.text);
                            Get.snackbar("Успешно", "Радуйтесь!");
                            Get.close(1);
                          }
                        }
                      },
                      child: Text("Зайти"))
                ],
              ),
            )));
  }
}
