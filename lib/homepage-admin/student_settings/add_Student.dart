import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/social_button.dart';
import 'package:krestakipapp/constants.dart';
import 'package:intl/intl.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:provider/provider.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

enum CinsiyetSecimi { Erkek, Kiz }

class _AddStudentState extends State<AddStudent> {
  String? _ogrAdiSoyadi,
      _dogumTarihi,
      _sinifi,
      _cinsiyet,
      _veliAdiSoyadi,
      _veliTelefonNo,
      _ogrID;

  bool _checkBoxValue = false;
  String _buttonText = "Kaydet";
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;

  CinsiyetSecimi _cinsiyetSecimi = CinsiyetSecimi.Erkek;
  int val = -1;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Öğrenci Ekle',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: kdefaultPadding,
                ),
                CheckboxListTile(
                  onChanged: (value) => _onChange(value),
                  value: _checkBoxValue,
                  title: Text("Öğrenci noyu manuel ekleyeceğim."),
                ),
                if (_checkBoxValue == true) ...[ogrIDTextForm(context)],
                if (_checkBoxValue == false) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "      Aksi durumda öğrenci numarası otomatik olarak verilmektedir.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                SizedBox(
                  height: 10,
                ),
                adiSoyadiTextForm(context),
                SizedBox(
                  height: kdefaultPadding,
                ),
                dogumtarihiFormField(context),
                SizedBox(
                  height: kdefaultPadding,
                ),
                RadioListTile<CinsiyetSecimi>(
                  value: CinsiyetSecimi.Erkek,
                  groupValue: _cinsiyetSecimi,
                  onChanged: (CinsiyetSecimi? value) {
                    setState(() {
                      _cinsiyetSecimi = value!;
                    });
                  },
                  title: Text("Erkek"),
                ),
                RadioListTile<CinsiyetSecimi>(
                  value: CinsiyetSecimi.Kiz,
                  groupValue: _cinsiyetSecimi,
                  onChanged: (CinsiyetSecimi? value) {
                    setState(() {
                      _cinsiyetSecimi = value!;
                    });
                  },
                  title: Text("Kız"),
                ),
                SizedBox(
                  height: kdefaultPadding,
                ),
                veliAdiSoyadiTextForm(context),
                SizedBox(height: kdefaultPadding),
                veliTelefonNoTextForm(context),
                SizedBox(height: kdefaultPadding),
                SocialLoginButton(
                    btnText: _buttonText,
                    btnColor: Theme.of(context).primaryColor,
                    onPressed: () => saveStudent(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget adiSoyadiTextForm(BuildContext context) {
    return TextFormField(
      initialValue: 'Ömer Kaplan',
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Öğrenci Adı',
          hintText: 'Ad Soyad giriniz...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      onSaved: (String? ogrAdi) {
        _ogrAdiSoyadi = ogrAdi!;
      },
      validator: (String? ogrAdi) {
        if (ogrAdi!.length < 1) return 'Öğrenci adı boş geçilemez!';
      },
    );
  }

  Widget ogrIDTextForm(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Öğrenci No',
          hintText: 'Öğrenci No giriniz...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.format_list_numbered_rounded),
          )),
      onSaved: (String? ogrID) {
        _ogrID = ogrID!;
      },
      validator: (String? ogrAdi) {
        if (ogrAdi!.length < 1) return 'Öğrenci No boş geçilemez!';
      },
    );
  }

  Widget veliAdiSoyadiTextForm(BuildContext context) {
    return TextFormField(
      initialValue: 'Ömer Kaplan',
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Veli Adı',
          hintText: 'Ad Soyad giriniz...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      onSaved: (String? veliAdi) {
        _veliAdiSoyadi = veliAdi!;
      },
      validator: (String? ogrAdi) {
        if (ogrAdi!.length < 1) return 'Veli adı boş geçilemez!';
      },
    );
  }

  Widget veliTelefonNoTextForm(BuildContext context) {
    return TextFormField(
      initialValue: '3203942830',
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Veli Telefonu',
          hintText: 'Telefon No giriniz...',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.person),
          )),
      onSaved: (String? velitel) {
        _veliTelefonNo = velitel!;
      },
      validator: (String? _veliTelefonNo) {
        if (_veliTelefonNo!.length < 1) return 'Veli telefonu boş geçilemez!';
      },
    );
  }

  Widget dogumtarihiFormField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      //initialValue: _dogumTarihi,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          labelText: 'Doğum Tarihi',
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.date_range_rounded),
          )),
      onTap: () async {
        DateTime time = DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());

        DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now());
        var dt = DateTime(picked!.year, picked.month, picked.day);
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String _formattedTime = formatter.format(dt);

        if (picked != null && picked != time) {
          _dateController.text = _formattedTime; // add this line.
          setState(() {
            _dogumTarihi = _formattedTime;
            time = picked;
          });
        }
      },
      onSaved: (String? dogumTarihi) {
        _dogumTarihi = dogumTarihi!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Doğum tarihi boş olamaz!';
        }
        return null;
      },
    );
  }

  saveStudent(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_checkBoxValue == false) {
        int newID = Random().nextInt(9999);
        _ogrID = newID.toString();
      }

      if (_cinsiyetSecimi == CinsiyetSecimi.Erkek)
        _cinsiyet = 'Erkek';
      else
        _cinsiyet = 'Kız';
      Student newStu = Student(
          ogrID: _ogrID!,
          adiSoyadi: _ogrAdiSoyadi!,
          dogumTarihi: _dogumTarihi,
          cinsiyet: _cinsiyet,
          veliAdiSoyadi: _veliAdiSoyadi,
          sinifi: _sinifi);
      bool sonuc = await _userModel.saveStudent(newStu);

      if (sonuc == true) {
      } else {
        Get.snackbar('Hata', 'Öğrenci kaydedilirken hata oluştu.',
            colorText: Colors.red, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  _onChange(bool? value) {
    setState(() {
      _checkBoxValue = value!;
    });
  }
}
