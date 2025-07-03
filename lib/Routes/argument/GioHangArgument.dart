

import 'package:personalprojectgrocery/Repository/DataLocal/data_local_repository.dart';

import '../../Models/Product/getData_ProductFromFirebase.dart';

final class GioHangArgument {

  const GioHangArgument({this.product = getDataProduct.empty});


  // truyền dữ liệu qua
  final getDataProduct product;

}