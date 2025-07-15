part of 'chi_tiet_hoa_don_bloc.dart';

sealed class ChiTietHoaDonEvent extends Equatable {
  const ChiTietHoaDonEvent();
}


class FetchChiTietHoaDonEvent extends ChiTietHoaDonEvent {
  final String idBill;

  FetchChiTietHoaDonEvent(this.idBill);

  @override
  List<Object?> get props => [idBill];
}