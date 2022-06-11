import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/user.dart';
import 'package:krestakipapp/services/base/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<MyUser?> currentUser() async {
    try {
      User? user = _auth.currentUser;

      return _usersFromFirebase(user!);
    } catch (e) {
      debugPrint("Hata CurrentUser $e");
      return null;
    }
  }

  MyUser _usersFromFirebase(User user) {
    return MyUser(userID: user.uid, phone: user.phoneNumber);
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint("Hata SignOut $e");
      return false;
    }
  }

  MyUser? myUser;
  @override
  Future<MyUser?> signingWithPhone(UserCredential userCredential) async {
    try {
      return _usersFromFirebase(userCredential.user!);
    } catch (e) {
      debugPrint("Hata phone auth $e");
      return null;
    }
  }

  @override
  Future<MyUser> signingWithEmailAndPassword(String email, String sifre) async {
    UserCredential sonuc =
        await _auth.signInWithEmailAndPassword(email: email, password: sifre);

    return _usersFromFirebase(sonuc.user!);
  }

  @override
  Future<MyUser> createUserEmailAndPassword(String email, String sifre) async {
    UserCredential sonuc = await _auth.createUserWithEmailAndPassword(
        email: email, password: sifre);
    return _usersFromFirebase(sonuc.user!);
  }

  @override
  Future<List<String>> getCriteria() {
    // TODO: implement getCriteria
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getRatings(String ogrID) {
    // TODO: implement getRatings
    throw UnimplementedError();
  }

  @override
  Future<List<Photo>> getPhotoToMainGallery() {
    // TODO: implement getPhotoToMainGallery
    throw UnimplementedError();
  }

  @override
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID) {
    // TODO: implement getPhotoToSpecialGallery
    throw UnimplementedError();
  }

  @override
  @override
  Future<List<Map<String, dynamic>>> getAnnouncements() {
    // TODO: implement getAnnouncements
    throw UnimplementedError();
  }

  @override
  Future<String> queryKresList(String kresCode) {
    // TODO: implement queryKresList
    throw UnimplementedError();
  }

  @override
  Future<bool> queryOgrID(String kresCode, String kresAdi, String ogrID) {
    // TODO: implement ogrNoControl
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getKresList() {
    // TODO: implement getKresList
    throw UnimplementedError();
  }
}
