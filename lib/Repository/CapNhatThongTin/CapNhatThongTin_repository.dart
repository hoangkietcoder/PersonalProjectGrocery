


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../HomePageFrame/ThongTin/CapNhapThongTin/model/Model_CapNhatThongTin.dart';

class CapnhatthongtinRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lấy UID một cách an toàn
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  // xử lí load dữ liệu lấy từ firebase
  Future<ModelCapnhatthongtin?> fetchUser() async {
    final uid = currentUid;
    final doc = await _firestore.collection("User").doc(uid).get();
    print("Dữ liệu từ Firestore: ${doc.data()}");
    return ModelCapnhatthongtin.fromJson(doc.data() as Map<String, dynamic>)
        .copyWith(
      // lấy id
        id: doc.id
    );
  }


  // xử lí khi người dùng muốn cập nhật lại thông tin của mình
  Future<void> updateUser(ModelCapnhatthongtin model) async {
    final uid = currentUid;
    await _firestore.collection("User").doc(uid).update(model.toJson());
  }
}


