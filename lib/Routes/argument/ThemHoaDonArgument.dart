


import '../../Repository/Bill/bill_repository.dart';

final class ThemHoaDonArgument {
  ThemHoaDonArgument(this.billRepository, {required this.date});



  // truyền  date qua
  final String date;

  final BillRepository billRepository;

}