

import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import 'model/ModelProductLocal.dart';

class ObjectBoxService{

  late final Box<ModelProductLocal> productBox;

  // khởi tạo
   Future<void> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: dir.path);
    productBox = Box<ModelProductLocal>(store);
  }

  // // lưu 1 sản phẩm
  // void addProductLocal(ModelProductLocal product) {
  //   productBox.put(product);
  //   print('✅ Đã lưu vào local: ${product}');
  // }
  //
  // // xóa sản phẩm dưới local dưới id
  // void deleteProductLocal(ModelProductLocal product) {
  //   productBox.remove(product.id);
  //   print('✅ Đã xóa product: ${product}');
  // }
  //
  // // lấy danh sách sản phẩm
  // List<ModelProductLocal> getAllProductsLocal() {
  //   final products = productBox.getAll();
  //   print('📦 Danh sách sản phẩm local: $products');
  //   return products;
  // }



  // xóa sản phẩm dưới local dưới id
  void deleteAllProductLocal(ModelProductLocal product) {
    productBox.removeAll();
    print('✅ Đã xóa tất cả sản phẩm: ${product}');
  }




}