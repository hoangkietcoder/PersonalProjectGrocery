

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../HomePageFrame/HoaDon/HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';
import '../../Models/Bill/create_bill.dart';

class BillRepository {

  // khởi tạo firebase
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _collection = "Bill";

  // phương thức tạo bill ( lấy các trường dữ liệu convert thành đối tượng ) up lên firebase
  Future<void> createBillToFirebase({required CreateBill createBill}) {
    return _db.collection(_collection).doc().set(createBill.toJsonCreateProduct());
  }


  // xài stream dùng để realtime để lấy dữ liệu từ firebase ( cho chức năng tạo hóa đơn )
  Stream<List<ModelChuathanhtoan>> get createBill {
    return _db
        .collection(_collection)
        .where("status", isEqualTo: "0") // lọc status = 1
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        log("asdadsadasdsadsa ${doc.data()}");
        return ModelChuathanhtoan.fromJson(doc.data()).copyWith(
            idBill: doc.id,
        );
      }).toList();
    });
  }




  // xài Future dùng để realtime để lấy dữ liệu từ firebase ( cho chức năng tìm kiếm )
  Future<List<ModelChuathanhtoan>> searchBillChuaThanhToanByName(String name) async {
    final query = await _db.collection(_collection)
        .where("status", isEqualTo: "0") // chỉ lấy hóa đơn chưa thanh toán
        .where("nameBill", isGreaterThanOrEqualTo: name).where("nameBill", isLessThanOrEqualTo: "$name\uf7ff").get();
    return query.docs.map((e) {
      return ModelChuathanhtoan.fromJson(e.data()).copyWith(
          idBill: e.id
      );
    }).toList();
  }

  // xài Future dùng để realtime để lấy dữ liệu từ firebase ( cho chức năng tìm kiếm )
  Future<List<ModelChuathanhtoan>> searchBillDaThanhToanByName(String name) async {
    final query = await _db.collection(_collection)
        .where("status", isEqualTo: "1") // chỉ lấy hóa đơn chưa thanh toán
        .where("nameBill", isGreaterThanOrEqualTo: name).where("nameBill", isLessThanOrEqualTo: "$name\uf7ff").get();
    return query.docs.map((e) {
      return ModelChuathanhtoan.fromJson(e.data()).copyWith(
          idBill: e.id
      );
    }).toList();
  }


  // xử lí khi người dùng bấm nút thanh toán sẽ chuyển trang đồng thời thay đổi status lên thành 1 ( sau đó so sánh để phân biệt bill )
  Future<void> updateBillDaThanhToan({ required String doc}) async {
        final updateBill = _db.collection(_collection);

        try {
          await updateBill.doc(doc).update({'status': "1", //
          });
        }on SocketException catch (_) {
          throw('Không có kết nối mạng');
        } catch (e) {
          throw('Lỗi cập nhật hóa đơn: $e');
        }
    }

    // dùng stream để lấy danh sách về
  Stream<List<ModelChuathanhtoan>> get billDaThanhToan {
    return _db
        .collection(_collection)
        .where("status", isEqualTo: "1") // lọc status = 1
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ModelChuathanhtoan.fromJson(doc.data()).copyWith(
            idBill: doc.id
        );
      }).toList();
    });
  }



  //
  // xử lí khi người dùng bấm nút xóa bên trang đã thanh toán sẽ chuyển trang hủy đơn đồng thời thay đổi status lên thành 2 ( sau đó so sánh để phân biệt bill )
  Future<void> deleteBillDaThanhToan({ required String doc}) async {
    final updateBill = _db.collection(_collection);
    try {
      await updateBill.doc(doc).update({'status': "2", //
      });
    }on SocketException catch (_) {
      throw('Không có kết nối mạng');
    } catch (e) {
      throw('Lỗi cập nhật hóa đơn: $e');
    }
  }

  Stream<List<ModelChuathanhtoan>> get getBillHuyDon {
    return _db
        .collection(_collection)
        .where("status", isEqualTo: "2") // lọc status = 1
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ModelChuathanhtoan.fromJson(doc.data()).copyWith(
            idBill: doc.id
        );
      }).toList();
    });
  }










  // xóa 1 bill chưa thanh toán
  Future<void> deleteBillById(String id) async {
    try {
      await _db.collection("Bill").doc(id).delete();
      print("🔥 Xóa thành công document: $id");
    } catch (e) {
      print("❌ Lỗi khi xóa document: $e");
      rethrow;
    }

  }
}