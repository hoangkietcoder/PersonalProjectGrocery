
import '../../Repository/Firebase_Database/Product/product_repository.dart';

final class ChiTietSanPhamArgument {
  ChiTietSanPhamArgument({
    required this.productID,
    // required this.deleteProductID,
    required this.productRepository
  });
  final String productID;
  // final String deleteProductID;
  final ProductRepository productRepository;
}