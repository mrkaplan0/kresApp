import 'package:krestakipapp/models/photo.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:krestakipapp/models/teacher.dart';
import 'package:krestakipapp/models/user.dart';

abstract class DBBase {
  Future<bool> saveUser(MyUser users);
  Future<MyUser> readUser(String userId);
  Future<String> queryKresList(String kresCode);
  Future<bool> ogrNoControl(String kresCode, String kresAdi, String ogrNo);

  Future<Student> getStudent(String ogrNo);

  Stream<List<Teacher>> getTeachers();

  Future<List<String>> getCriteria();

  Future<List<Map<String, dynamic>>> getRatings(String ogrID);

  Future<List<Photo>> getPhotoToMainGallery();
  Future<List<Photo>> getPhotoToSpecialGallery(String ogrID);

  Future<List<Map<String, dynamic>>> getAnnouncements();
}
