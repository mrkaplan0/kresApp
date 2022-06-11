import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krestakipapp/locator.dart';
import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:krestakipapp/models/user.dart';
import 'package:krestakipapp/services/FirebaseAuthServices.dart';
import 'package:krestakipapp/services/base/auth_base.dart';
import 'package:krestakipapp/services/firestore_db_service.dart';
import 'package:krestakipapp/services/storage_service.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  var appMode = AppMode.RELEASE;

  @override
  Future<MyUser?> currentUser() async {
    var _user = await _firebaseAuthService.currentUser();
    if (_user != null)
      return await _firestoreDBService.readUser(_user.userID!);
    else
      return null;
  }

  @override
  Future<MyUser?> signingWithPhone(UserCredential userCredential) async {
    MyUser? _user = await _firebaseAuthService.signingWithPhone(userCredential);
    _user!.position = 'visitor';

    bool _sonuc = await _firestoreDBService.saveUser(_user);
    if (_sonuc) {
      return await _firestoreDBService.readUser(_user.userID!);
    } else {
      debugPrint("sıkıntı burada");
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  @override
  Future<MyUser> signingWithEmailAndPassword(String email, String sifre) async {
    MyUser _user =
        await _firebaseAuthService.signingWithEmailAndPassword(email, sifre);
    return await _firestoreDBService.readUser(_user.userID!);
  }

  @override
  Future<MyUser?> createUserEmailAndPassword(String email, String sifre) async {
    MyUser _user =
        await _firebaseAuthService.createUserEmailAndPassword(email, sifre);

    //TODO: buraya şifreye göre position güncellemesi eklenecek gerçi telefon girişine
    Student stu = await _firestoreDBService.getStudent(sifre);
    _user.studentMap = stu.toMap();
    bool _sonuc = await _firestoreDBService.saveUser(_user);
    if (_sonuc) {
      return await _firestoreDBService.readUser(_user.userID!);
    } else
      return null;
  }

  @override
  Future<String> queryKresList(String kresAdi) async {
    return await _firestoreDBService.queryKresList(kresAdi);
  }

  @override
  Future<bool> queryOgrID(String kresCode, String kresAdi, String ogrID) async {
    return await _firestoreDBService.queryOgrID(kresCode, kresAdi, ogrID);
  }

  @override
  Future<List<String>> getCriteria() async {
    return await _firestoreDBService.getCriteria();
  }

  @override
  Future<List<Map<String, dynamic>>> getRatings(String ogrID) async {
    return await _firestoreDBService.getRatings(ogrID);
  }

  @override
  Future<List<Photo>> getPhotoToMainGallery() async {
    return await _firestoreDBService.getPhotoToMainGallery();
  }

  @override
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID) async {
    return await _firestoreDBService.getPhotoToSpecialGallery(ogrID);
  }

  @override
  Future<List<Map<String, dynamic>>> getAnnouncements() async {
    return await _firestoreDBService.getAnnouncements();
  }

  @override
  Future<List<Map<String, dynamic>>> getKresList() async {
    return await _firestoreDBService.getKresList();
  }
}
