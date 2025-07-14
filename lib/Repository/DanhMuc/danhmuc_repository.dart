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


      // Chuyển về List<DanhMucData>
      final all = snapshot.docs
          .map((doc) => DanhMucData.fromDocumentSnapshot(doc))
          .toList(); //
      // ✅ Lọc trùng theo idType (hoặc category)
      final map = <int, DanhMucData>{};
      for (final item in all) {
        if (item.idType != 0) {
          map[item.idType] = item; // Ghi đè nếu trùng idType và ban đầu gán id = 0 gây lỗi 2 sản phẩm nên phải check luôn
        }
      }

      final danhMucKhongTrung = map.values.toList();
      // Trả về danh sách đã lọc trùng
      onSuccess(danhMucKhongTrung);

      // ✅ In log để kiểm tra kết quả
      log("✅ Danh sách danh mục sau khi lọc trùng (theo idType):");
      for (var dm in danhMucKhongTrung) {
        log("- ${dm.category} | idType: ${dm.idType} | id: ${dm.id}");
      }


      // Tạo một danh sách (danhMucList) các đối tượng DanhMucData. Mỗi tài liệu trong snapshot được chuyển đổi
      // thành một đối tượng DanhMucData bằng cách gọi phương thức fromDocumentSnapshot(doc).
      // map được sử dụng để chuyển đổi từng tài liệu (doc) thành DanhMucData, và toList() chuyển đổi kết quả thành danh sách.
      List<DanhMucData> danhMucList = snapshot.docs.map((doc) {
        return DanhMucData.fromDocumentSnapshot(doc);
      }).toList();
      // onSuccess(danhMucList); // Trả về danh sách thành công
    } catch (e) {
      onError('Failed to fetch data: $e'); // Xử lý lỗi
    }
  }



}
