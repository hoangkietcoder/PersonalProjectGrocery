import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/DanhMuc/danhmuc_data.dart';

class DanhMucRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> fetchDanhMucData(Function(List<DanhMucData>) onSuccess, Function(String) onError) async {
    try {
      // QuerySnapshot snapshot = await _db.collection('Category').get() => truy vấn tất cả các tài liệu (documents)
      // từ bộ sưu tập Category trong Firestore và lưu trữ chúng vào biến snapshot
      QuerySnapshot snapshot = await _db.collection('Category').get();


      // Tạo một danh sách (danhMucList) các đối tượng DanhMucData. Mỗi tài liệu trong snapshot được chuyển đổi
      // thành một đối tượng DanhMucData bằng cách gọi phương thức fromDocumentSnapshot(doc).
      // map được sử dụng để chuyển đổi từng tài liệu (doc) thành DanhMucData, và toList() chuyển đổi kết quả thành danh sách.
      List<DanhMucData> danhMucList = snapshot.docs.map((doc) {
        return DanhMucData.fromDocumentSnapshot(doc);
      }).toList();
      onSuccess(danhMucList); // Trả về danh sách thành công
    } catch (e) {
      onError('Failed to fetch data: $e'); // Xử lý lỗi
    }
  }
}
