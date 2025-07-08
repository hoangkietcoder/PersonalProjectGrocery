part of 'hoa_don_da_thanh_toan_bloc.dart';

sealed class HoaDonDaThanhToanEvent extends Equatable {
  const HoaDonDaThanhToanEvent();

  @override
  List<Object?> get props => [];
}

 // lấy dữ liệu về
final class HoaDonDaThanhToanSubscriptionRequested extends HoaDonDaThanhToanEvent {
  const HoaDonDaThanhToanSubscriptionRequested();
}

//
// final class SubmitHoaDonDaThanhToan extends HoaDonDaThanhToanEvent{
//   const SubmitHoaDonDaThanhToan(this.modelChuathanhtoan);
//   final ModelChuathanhtoan modelChuathanhtoan;
//
//   @override
//   List<Object?> get props => [modelChuathanhtoan];
// }


// xử lí cho chức năng search hóa đơn đã thanh toán
final class SearchBillDaThanhToanEventChange extends HoaDonDaThanhToanEvent {
  const SearchBillDaThanhToanEventChange(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

// cho cái nút xóa ở trang đã thanh toán
class DeleteBillChange extends HoaDonDaThanhToanEvent{
  const DeleteBillChange();
}


// xử lí nút xóa ở trang đã thanh toán
class DeleteBillDaThanhToan extends HoaDonDaThanhToanEvent {
  final String billId;
  const DeleteBillDaThanhToan(this.billId);

  @override
  List<Object?> get props => [billId];
}

// vì xóa hóa đơn thứ 2 không hiển thị thông báo nên phải thêm sự kiện này
final class resetStatusDeleteNotification extends HoaDonDaThanhToanEvent {
  const resetStatusDeleteNotification();
}