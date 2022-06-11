import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/hata_exception.dart';
import 'package:krestakipapp/models/user.dart';
import 'package:krestakipapp/signin/deneme.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final String kresCode;
  final String kresAdi;
  final String ogrNo;

  RegisterPage(this.kresCode, this.kresAdi, this.ogrNo);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _email, _sifre, _phone;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Align(
              child: Text(
                " 3/4",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Text(
              "Telefon no giriniz.",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20,
            ),
            _userModel.state == ViewState.idle
                ? SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            veliTelefonTextForm(context),
                            SizedBox(
                              height: kdefaultPadding,
                            ),
                            SocialLoginButton(
                              btnText: "Kaydol",
                              btnColor: Theme.of(context).primaryColor,
                              onPressed: () => _formSubmit(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ));
  }

  Widget veliTelefonTextForm(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      initialValue: '+4917642971154',
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Cep Telefonu',
          hintText: 'Cep no giriniz...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      onSaved: (String? tel) {
        _phone = tel!;
      },
      validator: (String? tel) {
        if (tel!.length < 1) return 'Veli telefonu boş geçilemez!';
      },
    );
  }

  _formSubmit(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirebasePhoneAuthProvider(
                  child: VerifyPhoneNumberScreen(phoneNumber: _phone)),
              fullscreenDialog: true));
    }
  }
}
