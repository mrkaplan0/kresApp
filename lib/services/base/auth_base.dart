import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/user.dart';

abstract class AuthBase {
  Future<MyUser?> currentUser();
  Future<MyUser?> signingWithEmailAndPassword(String email, String sifre);
  Future<MyUser?> createUserEmailAndPassword(String email, String sifre);
  Future<bool> signOut();

  Future<String> queryKresList(String kresCode);
  Future<bool> ogrNoControl(String kresCode, String kresAdi, String ogrNo);
  Future<List<String>> getCriteria();
  Future<List<Map<String, dynamic>>> getRatings(String ogrID);
  Future<List<Photo>> getPhotoToMainGallery();
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID);
  Future<List<Map<String, dynamic>>> getAnnouncements();
}
