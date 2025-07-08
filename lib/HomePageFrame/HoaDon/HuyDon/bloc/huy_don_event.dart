part of 'huy_don_bloc.dart';

sealed class HuyDonEvent extends Equatable {
  const HuyDonEvent();

  @override
  List<Object?> get props => [];
}


// cho chức năng search hóa đơn đã hủy
final class SearchBillDaHuyEventChange extends HuyDonEvent {
  const SearchBillDaHuyEventChange(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

// lấy dữ liệu về
final class HuyDonSubscriptionRequested extends HuyDonEvent {
  const HuyDonSubscriptionRequested();
}



final class SubmitHoaDonDaHuy extends HuyDonEvent{
  const SubmitHoaDonDaHuy(this.modelChuathanhtoan);
  final ModelChuathanhtoan modelChuathanhtoan;

  @override
  List<Object?> get props => [modelChuathanhtoan];
}