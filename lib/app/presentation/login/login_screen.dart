import 'package:flutter_presensi/app/presentation/home/home_screen.dart';
import 'package:flutter_presensi/app/presentation/login/login_notifier.dart';
import 'package:flutter_presensi/core/helper/global_helper.dart';
import 'package:flutter_presensi/core/widget/app_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends AppWidget<LoginNotifier, void, void> {
  LoginScreen({super.key});

  @override
  void checkVariableAfterUi(BuildContext context) {
    if (notifier.isLoged) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
  }

  //'Disinfolahtaau Presensi'

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'DEMO BY ARISE',
                  style: GlobalHelper.getTextStyle(context,
                          appTextStyle: AppTextStyle.DISPLAY_MEDIUM)
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: notifier.emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text('Email'),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: notifier.passwordController,
              obscureText: !notifier.isShowPassword,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  label: const Text('Password'),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon((notifier.isShowPassword)
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: _showHidePassword,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () => _onPressLogin(context),
                    child: const Text("Login"))),const SizedBox(height: 400,)
          ],
        ),
      ),
    );
  }

  _showHidePassword() {
    notifier.isShowPassword = !notifier.isShowPassword;
  }

  _onPressLogin(BuildContext context) {
    notifier.login();
  }
}
