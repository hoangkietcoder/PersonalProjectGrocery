




import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../HomePageFrame/ThongTin/CapNhapThongTin/model/Model_CapNhatThongTin.dart';
import '../../HomePageFrame/ThongTin/model_ThongTIn/Model_ThongTin.dart';


// repo trang thông tin
class ThongtinRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy UID một cách an toàn
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  // xử lí load dữ liệu lấy từ firebase
  Future<ModelThongtin?> fetchUserInfo() async {
    final uid = currentUid;
    final doc = await _db.collection("User").doc(uid).get();
    print("Dữ liệu từ Firestore: ${doc.data()}");
    return ModelThongtin.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(
      // lấy id
        id: doc.id
    );
  }





}


