
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/GioHang/giohang.dart';

// class GiohangRepository{
//
//   // khởi tạo firebase database
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//
//   // phương thức xử lí chi tiết sản phẩm
//   Future<GioHang> getProductById(String id) async {
//     DocumentSnapshot doc = await _db.collection("Product").doc(id).get();
//     log("djwadawdawd${doc.data()}");
//     return GioHang.fromJson(doc.data() as Map<String, dynamic>).copyWith(
//       // lấy id
//         id: doc.id
//     );
//   }
// }