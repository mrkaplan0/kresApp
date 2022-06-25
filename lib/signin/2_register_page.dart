import 'dart:ui';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/signin/3_phone_authentication.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final String kresCode;
  final String kresAdi;

  RegisterPage(this.kresCode, this.kresAdi);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _phone, _ogrID;
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
        body: SingleChildScrollView(
          child: Column(
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
                "Telefon ve Öğrenci No \n giriniz.",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
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
                              SizedBox(height: kdefaultPadding),
                              ogrIDTextForm(context),
                              SizedBox(height: kdefaultPadding),
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
          ),
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

  Widget ogrIDTextForm(BuildContext context) {
    return TextFormField(
      initialValue: "1",
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Ögrenci No',
          hintText: 'Öğrenci No...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.school_rounded),
          )),
      onSaved: (String? gelenNo) {
        _ogrID = gelenNo!;
      },
      validator: (String? ogrNo) {
        if (ogrNo!.length < 1)
          return 'Öğrenci numaranız olmadan kayıt olunamaz!';
      },
    );
  }

  _formSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirebasePhoneAuthProvider(
                  child: VerifyPhoneNumberScreen(
                      phoneNumber: _phone,
                      kresCode: widget.kresCode,
                      kresAdi: widget.kresAdi,
                      ogrID: _ogrID)),
              fullscreenDialog: true));
    }
  }
}
