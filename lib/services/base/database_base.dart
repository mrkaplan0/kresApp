import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:krestakipapp/models/teacher.dart';
import 'package:krestakipapp/models/user.dart';

abstract class DBBase {
  Future<bool> saveUser(MyUser users);
  Future<MyUser> readUser(String userId);
  Future<List<Map<String, dynamic>>> getKresList();
  Future<String> queryKresList(String kresCode);
  Future<bool> queryOgrID(String kresCode, String kresAdi, String ogrID);

  Future<Student> getStudent(String ogrNo);

  Stream<List<Teacher>> getTeachers();

  Future<List<String>> getCriteria();

  Future<List<Map<String, dynamic>>> getRatings(String ogrID);

  Future<List<Photo>> getPhotoToMainGallery();
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID);

  Future<List<Map<String, dynamic>>> getAnnouncements();
}
