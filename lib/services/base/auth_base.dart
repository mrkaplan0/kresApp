import 'package:firebase_auth/firebase_auth.dart';
import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/user.dart';

abstract class AuthBase {
  Future<MyUser?> currentUser();
  Future<MyUser?> signingWithPhone(UserCredential userCredential);
  Future<MyUser?> signingWithEmailAndPassword(String email, String sifre);
  Future<MyUser?> createUserEmailAndPassword(String email, String sifre);
  Future<bool> signOut();
  Future<List<Map<String, dynamic>>> getKresList();

  Future<String> queryKresList(String kresAdi);
  Future<bool> queryOgrID(String kresCode, String kresAdi, String ogrID);
  Future<List<String>> getCriteria();
  Future<List<Map<String, dynamic>>> getRatings(String ogrID);
  Future<List<Photo>> getPhotoToMainGallery();
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID);
  Future<List<Map<String, dynamic>>> getAnnouncements();
}
