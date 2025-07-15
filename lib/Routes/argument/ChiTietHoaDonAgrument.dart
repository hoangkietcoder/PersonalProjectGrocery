

import 'package:personalprojectgrocery/ObjectBox/model/ModelProductLocal.dart';
import 'package:personalprojectgrocery/Repository/Bill/bill_repository.dart';

import '../../HomePageFrame/HoaDon/HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';

class ChiTietHoaDonArgument {

  ChiTietHoaDonArgument(this.idBill, this.billRepository);

final String idBill;
final BillRepository billRepository;
}