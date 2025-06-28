



import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Models/Product/create_product.dart';
import '../../../Models/Product/detail_product.dart';
import '../../../Models/Product/getData_ProductFromFirebase.dart';



 // phương thức thêm dữ liệu lên firebase bằng đối tượng
class ProductRepository {

  // khởi tạo firebase database
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  // xài stream dùng để realtime để lấy dữ liệu từ firebase ( cho chức năng tạo sản phẩm )
  Stream<List<getDataProduct>> get createProduct {
    return _db.collection("Product").snapshots().map((product) {
      return product.docs.map((e) {
        return getDataProduct.fromJson(e.data(), e.id);
      }).toList();
    });
  }

  // xài Future dùng để realtime để lấy dữ liệu từ firebase ( cho chức năng tìm kiếm )
  Future<List<getDataProduct>> searchItemsByName(String name) async {
    final query = await _db.collection('Product').
    where("nameProduct", isGreaterThanOrEqualTo: name).where("nameProduct", isLessThanOrEqualTo: "$name\uf7ff").get();
    return query.docs.map((e) {
      return getDataProduct.fromJson(e.data(), e.id);
    }).toList();
  }

  // phương thức xử lí chi tiết sản phẩm
  Future<DetailProduct> getProductById(String id) async {
    DocumentSnapshot doc = await _db.collection("Product").doc(id).get();
    log("djwadawdawd${doc.data()}");
    return DetailProduct.fromJson(doc.data() as Map<String, dynamic>).copyWith(
      // lấy id
        id: doc.id
    );
  }


    // phương thức tạo sản phẩm ( lấy các trường dữ liệu convert thành đối tượng ) up lên firebase
    Future<void> createProductToFirebase({required CreateProduct createProduct}) {
      return _db.collection("Product").doc().set(createProduct.toJsonCreateProduct());
    }


  // phương thức xóa 1 sản phẩm
  Future<void> deleteProductById(String id) async {
    return await _db.collection('Product').doc(id).delete();
  }

}