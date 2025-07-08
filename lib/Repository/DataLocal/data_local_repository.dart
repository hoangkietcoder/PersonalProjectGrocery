


import '../../ObjectBox/ObjectBox.dart';
import '../../ObjectBox/model/ModelProductLocal.dart';
import '../../objectbox.g.dart';

class DataLocalRepository {
  DataLocalRepository({required ObjectBoxService objectBoxService}) : _objectBoxService = objectBoxService;
    final ObjectBoxService _objectBoxService;

  // 1 Lưu nhiều sản phẩm
  Future<void> saveProducts(List<ModelProductLocal> products) async {
    final box = _objectBoxService.productBox;
    box.putMany(products);
  }

  // Lưu 1 sản phẩm
  Future<void> saveProduct(ModelProductLocal product) async {
    final box = _objectBoxService.productBox;
    box.put(product);
    print(" Đã lưu sản phẩm: ${product.nameProduct}");
  }



  // lấy tất cả sản phẩm dưới local lên và refesh lại trang ( dùng stream )
  Stream<List<ModelProductLocal>> getAllProducts()  {
    final box = _objectBoxService.productBox;
    final products = box.query(); //
    return products.watch(
        // theo dõi stream,  map((e) => e.find() : trả về danh sách mỗi khi cập nhật
        triggerImmediately: true).map((e) => e.find());;
  }

  Future<void> deleteAllProductsLocal() async {
    final box = _objectBoxService.productBox;
    await box.removeAll();
  }

  // ✅ Lấy theo ID (nếu cần)
  ModelProductLocal? getProductById(int id) {
    final box = _objectBoxService.productBox;
    return box.get(id);

  }

  // ✅ Xoá theo ID
  Future<void> deleteProduct(int id) async {
    final box = _objectBoxService.productBox;
    box.remove(id);
  }





  // ✅ Cập nhật sản phẩm
  Future<void> updateProduct(ModelProductLocal product) async {
    final box = _objectBoxService.productBox;
    if (product.id != 0) {
      box.put(product); // put sẽ update nếu id tồn tại
    }
  }

  // xử lí khi bị trùng dữ liệu có sẵn thì chỉ việc tăng số lượng lên 1
  Future<void> addOrIncreaseProduct(ModelProductLocal product) async {
    final box = _objectBoxService.productBox;
    // Tìm sản phẩm đã tồn tại theo fireBaseId
    final query = box.query(ModelProductLocal_.fireBaseId.equals(product.fireBaseId)).build();
    final existing = query.findFirst();
    query.close();


    if(existing != null){
      // Cộng dồn số lượng
      final oldQty = int.tryParse(existing.quantityProduct) ?? 0;
      final newQty = oldQty + 1;
      final updatedProduct = existing.copyWith(
        quantityProduct: newQty.toString(),
      );
      await saveProduct(updatedProduct); // ✅ dùng lại hàm đã có
      print('✅ Đã tăng số lượng lên $newQty');
    } else {
      // Nếu chưa có, thêm mới với quantity = 1
      final newProduct = product.copyWith(quantityProduct: '1');
      await saveProduct(newProduct); // ✅ dùng lại hàm đã có
      print('🆕 Đã thêm sản phẩm mới vào giỏ hàng');
    }

  }
}