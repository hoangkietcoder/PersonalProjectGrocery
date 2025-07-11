

import 'package:personalprojectgrocery/ObjectBox/model/ModelProductLocal.dart';

class ChiTietHoaDonArgument {

  ChiTietHoaDonArgument({required this.cartProducts, required this.toTalPrice});
  final List<ModelProductLocal> cartProducts;
  final int toTalPrice;
}