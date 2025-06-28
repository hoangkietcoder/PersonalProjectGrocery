//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sumi_printer/Models/GetUserFromFireBase/GetUserFromFireBase.dart';
//
// class getUserFromFireBase_Repository{
//
//   // khởi tạo firebase database
//   final CollectionReference _userCollection = FirebaseFirestore.instance.collection('User');
//
//   Future<List<GetUserAccount>> fetchUsers() async {
//     try {
//       QuerySnapshot snapshot = await _userCollection.get();
//       return snapshot.docs.map((doc) {
//         return GetUserAccount.fromJson(doc.id, doc.data() as Map<String, dynamic>);
//       }).toList();
//     } catch (e) {
//       throw Exception('Lỗi khi lấy dữ liệu từ Firebase: $e');
//     }
//   }
// }