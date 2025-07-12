
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Models/DanhMuc/getDataFirebase/ModelDanhMucFireBase.dart';

class SuaRepository {


  final FirebaseFirestore _db = FirebaseFirestore.instance;



  Future<List<ModelDanhMucFireBase>> getDataDanhMucSua({ required int typeProduct, required String userId,}) async {

    try{

      print("🔍 Đang truy vấn với:");
      print("👉 typeProduct: $typeProduct (${typeProduct.runtimeType})");
      print("👉 userId: $userId (${userId.runtimeType})");


      final snapshot = await _db
          .collection('Product')
          .where('typeProduct', isEqualTo: typeProduct)
          .where('userId', isEqualTo: userId)
          .get();



        return snapshot.docs.map((doc) => ModelDanhMucFireBase.fromJson(doc.data(), doc.id)).toList();
    }catch (e) {
      throw Exception('Lỗi khi lấy sản phẩm: $e');
    }
  }


  Future<List<ModelDanhMucFireBase>> searchProductByName(String name, int type) async {
    final query = await _db.collection('Product')
          // .where("userId", isEqualTo: id)
          .where("typeProduct",isEqualTo: type)
          .where("nameProduct", isGreaterThanOrEqualTo: name)
          .where("nameProduct", isLessThanOrEqualTo: "$name\uf7ff").get();
    return query.docs.map((e) {
      return ModelDanhMucFireBase.fromJson(e.data(), e.id);
    }).toList();
  }


}