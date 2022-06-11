import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/hata_exception.dart';
import 'package:krestakipapp/signin/register_page.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';

class ResearchStudent extends StatefulWidget {
  @override
  _ResearchStudentState createState() => _ResearchStudentState();
}

class _ResearchStudentState extends State<ResearchStudent> {
  late String _ogrID, _kresAdi, _kresCode;
  bool checkResult = false;
  final _ogrIDformKey = GlobalKey<FormState>();
  final _kresCodeFormKey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();
  List kresList = [];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    _userModel.getKresList().then((value) {
      for (int i = 0; i < value.length; i++) {
        kresList.add(
            "${value[i]['kresCode'].toString().toLowerCase()} - ${value[i]['kresAdi'].toString()}");
      }
    });

    super.initState();
  }

  Future<List> fetchSimpleData() async {
    return kresList;
  }

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
    return SingleChildScrollView(
        child: Column(
      children: [
        Align(
          child: Text(
            " 2/4",
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
          "Öğrenci Numarası Giriniz.",
          style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
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
                  btnText: 'İlerle',
                  btnColor: Theme.of(context).primaryColor,
                  onPressed: () => _queryogrID(context),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget kresCodeColumnWidget(BuildContext context, UserModel _userModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            child: Text(
              " 1/4",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Okulunuzu bulun.",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldSearch(
                  label: 'Okul Adı',
                  controller: myController,
                  future: () {
                    return fetchSimpleData();
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                SocialLoginButton(
                    btnText: "İlerle",
                    btnColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _querykresCode(context);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ogrIDTextForm(BuildContext context) {
    return TextFormField(
      initialValue: "1",
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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

  Widget kresAdiTextForm({String? kresAdi}) {
    return TextFormField(
      initialValue: kresAdi,
      readOnly: kresAdi != null ? true : false,
      decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Okul Adı',
          hintText: 'Okul Adı giriniz...',
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

    if (myController.text.isNotEmpty) {
      try {
        _kresCode = myController.text.split(' ').first;
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
        bool sonuc = await _userModel.queryOgrID(_kresCode, _kresAdi, _ogrID);

        if (sonuc == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisterPage(_kresCode, _kresAdi, _ogrID)));
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
