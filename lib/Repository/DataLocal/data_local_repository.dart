


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
    return products.watch(triggerImmediately: true).map((e) => e.find());;
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



  Future<void> deleteAllProductsLocal() async {
    final box = _objectBoxService.productBox;
    await box.removeAll();
  }

  // ✅ Cập nhật sản phẩm
  Future<void> updateProduct(ModelProductLocal product) async {
    final box = _objectBoxService.productBox;
    if (product.id != 0) {
      box.put(product); // put sẽ update nếu id tồn tại
    }
  }
}