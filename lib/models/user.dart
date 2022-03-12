import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? userID;
  String? email;
  String? username;
  String? phone;
  String? kresAdi;
  String? kresCode;
  bool? isAdmin;
  String? position;
  DateTime? createdAt;
  String? token;
  Map<String, dynamic>? studentMap;
  MyUser({required this.userID, required this.email, this.isAdmin});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'username': username,
      'phone': phone,
      'kresAdi': kresAdi,
      'kresCode': kresCode,
      'isAdmin': isAdmin ?? false,
      'position': position,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'token': token,
      'myStudent': studentMap,
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        username = map['username'],
        phone = map['phone'],
        kresAdi = map['kresAdi'],
        kresCode = map['kresCode'],
        isAdmin = map['isAdmin'],
        position = map['position'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        token = map['token'],
        studentMap = map['myStudent'];

  @override
  String toString() {
    return 'MyUser {userID: $userID, email: $email, username: $username, phone: $phone, kresAdi: $kresAdi, kresCode: $kresCode, isAdmin: $isAdmin, position: $position, createdAt: $createdAt, studentMap: $studentMap}';
  }
}
