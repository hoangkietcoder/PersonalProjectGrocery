import 'package:personalprojectgrocery/Repository/DanhMuc/sua/SuaRepository.dart';

final class DetailDanhMucArgument {

  const DetailDanhMucArgument(this.suaRepository, this.typeProduct);

  final SuaRepository suaRepository;
  final String typeProduct;

}