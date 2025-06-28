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


final class SubmitHoaDonDaThanhToan extends HoaDonDaThanhToanEvent{
  const SubmitHoaDonDaThanhToan(this.modelChuathanhtoan);
  final ModelChuathanhtoan modelChuathanhtoan;

  @override
  List<Object?> get props => [modelChuathanhtoan];
}


// cho chức năng search hóa đơn đã thanh toán
final class SearchBillDaThanhToanEventChange extends HoaDonDaThanhToanEvent {
  const SearchBillDaThanhToanEventChange(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}