import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/hata_exception.dart';
import 'package:krestakipapp/models/user.dart';
import 'package:krestakipapp/signin/register_page.dart';
import 'package:provider/provider.dart';

class ResearchStudent extends StatefulWidget {
  @override
  _ResearchStudentState createState() => _ResearchStudentState();
}

class _ResearchStudentState extends State<ResearchStudent> {
  late String _ogrNo, _kresAdi, _kresCode;
  bool checkResult = false;
  final _ogrIDformKey = GlobalKey<FormState>();
  final _kresCodeFormKey = GlobalKey<FormState>();

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
        body: checkResult == false
            ? kresCodeColumnWidget(context, _userModel)
            : ogrIDColumnWidget(context, _userModel));
  }

  Widget ogrIDColumnWidget(BuildContext context, UserModel _userModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Öğrenci Numarası Giriniz.",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Form(
          key: _ogrIDformKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kresAdiTextForm(kresAdi: _kresAdi),
                SizedBox(
                  height: kdefaultPadding,
                ),
                ogrIDTextForm(context),
                SizedBox(
                  height: kdefaultPadding,
                ),
                SocialLoginButton(
                  btnText: 'Sorgula',
                  btnColor: Theme.of(context).primaryColor,
                  onPressed: () => _queryogrID(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget kresCodeColumnWidget(BuildContext context, UserModel _userModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Kreş Kodunu Giriniz.",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Form(
          key: _kresCodeFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kresCodeTextForm(context),
                SizedBox(
                  height: kdefaultPadding,
                ),
                SocialLoginButton(
                    btnText: "Sorgula",
                    btnColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _querykresCode(context);
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget ogrIDTextForm(BuildContext context) {
    return TextFormField(
      initialValue: "123456",
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          hintText: 'Öğrenci No...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.school_rounded),
          )),
      onSaved: (String? gelenNo) {
        _ogrNo = gelenNo!;
      },
      validator: (String? ogrNo) {
        if (ogrNo!.length < 1)
          return 'Öğrenci numaranız olmadan kayıt olunamaz!';
      },
    );
  }

  Widget kresCodeTextForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TextFormField(
        autofocus: true,
        decoration: const InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            labelText: 'Kreş Kodu',
            suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Icon(Icons.school_outlined),
            )),
        onSaved: (String? kresCode) {
          _kresCode = kresCode!;
        },
      ),
    );
  }

  Widget kresAdiTextForm({String? kresAdi}) {
    return TextFormField(
      initialValue: kresAdi,
      readOnly: kresAdi != null ? true : false,
      decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Kreş Adı',
          hintText: 'Kreş Adı giriniz...',
          suffixIcon: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.school_outlined),
          )),
      onSaved: (String? kresAdi) {
        _kresAdi = kresAdi!;
      },
    );
  }

  _querykresCode(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_kresCodeFormKey.currentState!.validate()) {
      _kresCodeFormKey.currentState!.save();
      try {
        _kresAdi = await _userModel.queryKresList(_kresCode);

        if (_kresAdi.isNotEmpty) {
          checkResult = true;
          setState(() {});
        } else {
          Get.snackbar('HATA!', ' Kreş Kodunuz yanlış veya eksik.  ',
              snackPosition: SnackPosition.TOP);
        }
      } catch (e) {
        Get.snackbar('Hata', 'HATA: ' + Hatalar.goster(e.toString()),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Hata', 'HATA: Lütfen Kreş Kodu Giriniz. ',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  _queryogrID(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_ogrIDformKey.currentState!.validate()) {
      _ogrIDformKey.currentState!.save();
      try {
        bool sonuc = await _userModel.ogrNoControl(_kresCode, _kresAdi, _ogrNo);

        if (sonuc == true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterPage(_ogrNo)));
        } else {
          Get.snackbar('HATA',
              'HATA: Geçerli öğrenci şifresi olmadan kayıt olamazsınız. Yönetici ile irtibata geçiniz.  ',
              snackPosition: SnackPosition.TOP);
        }
      } catch (e) {
        Get.snackbar('Hata', 'HATA: ' + Hatalar.goster(e.toString()),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('HATA',
          'Lütfen öğrenci numarası giriniz bilmiyorsanız yöneticiniz ile irtibata geçiniz.  ',
          snackPosition: SnackPosition.TOP);
    }
  }
}
