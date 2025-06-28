import '../../Models/Product/getData_ProductFromFirebase.dart';
import '../../Repository/Firebase_Database/Product/product_repository.dart';

final class ThemSanPhamArgument {
  ThemSanPhamArgument({
    required this.productRepository,
  });
  // truyền repo
  final ProductRepository productRepository;
}
