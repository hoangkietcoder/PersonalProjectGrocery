

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Models/Register/register_user.dart';

class RegisterRepository{



  // khởi tạo firebase database
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  // tạo bộ sự tập tên là users xong rồi ( đưa dữ liệu đã convert sang object đưa vào users )
  Future<void> signUpWithFireBase({required RegisterUser registerUser}) {
    // đăng kí với uid này do Firebase tạo ra - > sẽ dùng UID để làm trang cập nhật thông tin được lấy từ UID này
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("Không tìm thấy UID người dùng");
    return _db.collection("User").doc(uid).set(registerUser.toJsonUserProfile());
  }
}