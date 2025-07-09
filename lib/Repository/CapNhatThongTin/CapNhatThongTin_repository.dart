


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../HomePageFrame/ThongTin/CapNhapThongTin/model/Model_CapNhatThongTin.dart';

class CapnhatthongtinRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Lấy UID một cách an toàn
  String? get currentUid => FirebaseAuth.instance.currentUser?.uid;

  // xử lí load dữ liệu lấy từ firebase
  Future<ModelCapnhatthongtin?> fetchUser() async {
    final uid = currentUid;
    final doc = await _db.collection("User").doc(uid).get();
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
    await _db.collection("User").doc(uid).update(model.toJson());
  }

  // ✅ Upload ảnh lên Firebase Storage → trả về download URL
  Future<String> uploadProductImage(File imageFile, String InfoId) async {
    try {
      final imageRef = _storage.ref().child("information_images/$InfoId.jpg");

      // Upload ảnh
      await imageRef.putFile(imageFile);

      // ✅ Lấy URL đúng từ imageRef
      final downloadUrl = await imageRef.getDownloadURL();

      print("✅ Upload thành công. URL: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      print("❌ Lỗi upload ảnh: $e");
      throw Exception('Ảnh đưa lên thất bại: $e');
    }
  }

  // ✅ Cập nhật trường img_url trong Firestore
  Future<void> saveImageUrlToFirestore({
    required String productId,
    required String imageUrl,
  }) async {
    try {
      await _db.collection('User').doc(productId).update({
        'url_info': imageUrl,
      });
      print("✅ Đã lưu img_url vào Firestore.");
    } catch (e) {
      print("❌ Lỗi lưu URL vào Firestore: $e");
      throw Exception('Lỗi lưu URL vào Firestore: $e');
    }
  }
}


