import 'package:flutter/material.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';

class ErrorLoginPage extends StatelessWidget {
  const ErrorLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Kayıt aşamasında verdiğiniz bilgiler uyuşmadı."),
              SizedBox(height: kdefaultPadding / 2),
              Text("Okul yönetimi ile irtibata geçiniz."),
              SizedBox(height: kdefaultPadding),
              SocialLoginButton(
                btnText: "Geri Dön",
                btnColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.pushNamed(context, '/LandingPage'),
              ),
            ],
          ),
        ));
  }
}
