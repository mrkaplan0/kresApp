import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/hata_exception.dart';
import 'package:krestakipapp/signin/2_register_page.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';

class QuerySchool extends StatefulWidget {
  @override
  _QuerySchoolState createState() => _QuerySchoolState();
}

class _QuerySchoolState extends State<QuerySchool> {
  late String _kresAdi, _kresCode;

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
        body: kresCodeColumnWidget(context, _userModel));
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

  _querykresCode(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (myController.text.isNotEmpty) {
      try {
        _kresCode = myController.text.split(' ').first;
        _kresAdi = await _userModel.queryKresList(_kresCode);

        if (_kresAdi.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterPage(_kresCode, _kresAdi)));
        } else {
          Get.snackbar('HATA!', ' Okul Adı yanlış veya eksik.  ',
              snackPosition: SnackPosition.TOP);
        }
      } catch (e) {
        Get.snackbar('Hata', 'HATA: ' + Hatalar.goster(e.toString()),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Hata', 'HATA: Lütfen Okul Adı Giriniz. ',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /*_queryogrID(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_ogrIDformKey.currentState!.validate()) {
      _ogrIDformKey.currentState!.save();
      try {
        */ /* if (sonuc == true) {

        } else {
          Get.snackbar('HATA',
              'HATA: Geçerli öğrenci şifresi olmadan kayıt olamazsınız. Yönetici ile irtibata geçiniz.  ',
              snackPosition: SnackPosition.TOP);
        }*/ /*
      } catch (e) {
        Get.snackbar('Hata', 'HATA: ' + Hatalar.goster(e.toString()),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('HATA',
          'Lütfen öğrenci numarası giriniz bilmiyorsanız yöneticiniz ile irtibata geçiniz.  ',
          snackPosition: SnackPosition.TOP);
    }
  }*/
}
