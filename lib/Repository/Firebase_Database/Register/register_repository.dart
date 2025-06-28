

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Models/Register/register_user.dart';

class RegisterRepository{



  // khởi tạo firebase database
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  // tạo bộ sự tập tên là users xong rồi ( đưa dữ liệu đã convert sang object đưa vào users )
  Future<void> signUpWithFireBase({required RegisterUser registerUser}) {
    return _db.collection("User").doc().set(registerUser.toJsonUserProfile());
  }
}