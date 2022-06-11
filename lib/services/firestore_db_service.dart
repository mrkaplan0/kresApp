import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:krestakipapp/models/teacher.dart';
import 'package:krestakipapp/models/user.dart';
import 'package:krestakipapp/services/base/database_base.dart';
import 'package:flutter/material.dart';

class FirestoreDBService implements DBBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(MyUser users) async {
    await _firestore
        .collection("Users")
        .doc(users.userID)
        .set(users.toMap())
        .then((value) => print("User Kaydedildi."))
        .catchError((error) => print("Kullanıcı kayıt hatası: $error"));

    DocumentSnapshot _okunanUser =
        await _firestore.doc('Users/${users.userID}').get();

    Map<String, dynamic> map = _okunanUser.data() as Map<String, dynamic>;
    MyUser _okunanUserNesnesi = MyUser.fromMap(map);

    print("Okunan user nesnesi" + _okunanUserNesnesi.toString());

    return true;
  }

  @override
  Future<MyUser> readUser(String userId) async {
    DocumentSnapshot _okunanUser =
        await _firestore.collection('Users').doc(userId).get();
    Map<String, dynamic> map = _okunanUser.data() as Map<String, dynamic>;
    MyUser _okunanUserNesnesi = MyUser.fromMap(map);

    print("Okunan user nesnesi" + map.toString());
    return _okunanUserNesnesi;
  }

  @override
  Future<List<Map<String, dynamic>>> getKresList() async {
    QuerySnapshot kresler =
        await _firestore.collection("KreslerChecking").get();

    List<Map<String, dynamic>> list = [];

    for (DocumentSnapshot kres in kresler.docs) {
      Map<String, dynamic> map = kres.data()! as Map<String, dynamic>;
      list.add(map);
    }
    debugPrint(list.toString());
    return list;
  }

  @override
  Future<String> queryKresList(String kresCode) async {
    QuerySnapshot checkKresCode = await _firestore
        .collection("KreslerChecking")
        .where('kresCode', isEqualTo: kresCode)
        .get();

    if (checkKresCode.docs.isNotEmpty) {
      debugPrint(checkKresCode.docs.first.data().toString());
      Map<String, dynamic> map =
          checkKresCode.docs.first.data() as Map<String, dynamic>;
      return map['kresAdi'].toString();
    } else {
      return '';
    }
  }

  @override
  Future<Student> getStudent(String ogrNo) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('Student').doc(ogrNo).get();

    Student student =
        Student.fromMap(docSnapshot.data()! as Map<String, dynamic>);

    print(student);

    return student;
  }

  @override
  Stream<List<Teacher>> getTeachers() {
    var snapShot = _firestore.collection('Teacher').snapshots();

    return snapShot.map((ogrList) => ogrList.docs
        .map((teacher) => Teacher.fromMap(teacher.data()))
        .toList());
  }

  @override
  Future<bool> queryOgrID(String kresCode, String kresAdi, String ogrID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("KreslerChecking")
        .doc(kresCode + '_' + kresAdi)
        .collection("Students")
        .get();

    List<int> list = [];

    for (DocumentSnapshot ogrID in querySnapshot.docs) {
      Map<String, dynamic> map = ogrID.data()! as Map<String, dynamic>;
      list.add(int.parse(map['ogrID']));
    }
    var r = list.contains(int.parse(ogrID));
    return r;
  }

  @override
  Future<List<String>> getCriteria() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("Criteria").doc("Criteria").get();

    List<String> kriterList = [];
    Map<String, dynamic> map = documentSnapshot.data()! as Map<String, dynamic>;
    map.values.forEach((element) {
      kriterList.add(element.toString());
    });
    return kriterList;
  }

  @override
  Future<List<Map<String, dynamic>>> getRatings(String ogrID) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Student')
        .doc(ogrID)
        .collection("Ratings")
        .get();
    List<Map<String, dynamic>> list = [];

    for (DocumentSnapshot rating in querySnapshot.docs) {
      list.add(rating.data()! as Map<String, dynamic>);
    }

    return list;
  }

  @override
  Future<bool> savePhotoToMainGallery(Photo myPhoto) async {
    await _firestore
        .collection('Main')
        .doc('Gallery')
        .set({myPhoto.time: myPhoto.toMap()}, SetOptions(merge: true));

    if (myPhoto.ogrID != null) {
      await _firestore
          .collection("Student")
          .doc(myPhoto.ogrID)
          .collection("Gallery")
          .doc(myPhoto.ogrID)
          .set({myPhoto.time: myPhoto.toMap()}, SetOptions(merge: true));
    }
    return true;
  }

  @override
  Future<List<Photo>> getPhotoToMainGallery() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('Main').doc('Gallery').get();

    List<Photo> photoList = [];
    Map<String, dynamic> map = documentSnapshot.data()! as Map<String, dynamic>;

    for (Map<String, dynamic> map in map.values) {
      photoList.add(Photo.fromMap(map));
    }
    print(photoList);
    return photoList;
  }

  @override
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Student")
        .doc(ogrID)
        .collection('Gallery')
        .doc(ogrID)
        .get();

    List<Photo> photoList = [];
    Map<String, dynamic> map = documentSnapshot.data()! as Map<String, dynamic>;

    for (Map<String, dynamic> map in map.values) {
      photoList.add(Photo.fromMap(map));
    }

    return photoList;
  }

  @override
  Future<bool> savePhotoToSpecialGallery(Photo myPhoto) async {
    await _firestore
        .collection("Student")
        .doc(myPhoto.ogrID)
        .collection("Gallery")
        .doc(myPhoto.ogrID)
        .set({myPhoto.time: myPhoto.toMap()}, SetOptions(merge: true));

    return true;
  }

  @override
  Future<bool> addAnnouncement(Map<String, dynamic> map) async {
    await _firestore
        .collection("Announcement")
        .doc("Announcement")
        .set({map['Duyuru Başlığı']: map}, SetOptions(merge: true));

    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getAnnouncements() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("Announcement").doc("Announcement").get();
    List<Map<String, dynamic>> duyuruList = [];
    Map<String, dynamic> maps =
        documentSnapshot.data()! as Map<String, dynamic>;

    for (Map<String, dynamic> map in maps.values) {
      duyuruList.add(map);
    }
    return duyuruList;
  }
}
