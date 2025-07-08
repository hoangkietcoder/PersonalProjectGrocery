part of 'hoa_don_da_thanh_toan_bloc.dart';

enum StatusBillSearchDaThanhToan {initial,loading, failure ,successful} // trạng thái search hóa đơn

enum StatusSubmitDeleteBillDaThanhToan {initial, failure, successful} // trạng thái khi bấm nút xóa ở trang đã thanh toán

final class HoaDonDaThanhToanState extends Equatable {
  const HoaDonDaThanhToanState({
    this.statusThanhToan = StatusSubmit.unknown,
    this.statusInitial = StatusInitial.initial,
    this.msg = "",
    this.lsBillDaThanhToan = const [],
    this.statusSubmitDeleteBillDaThanhToan = StatusSubmitDeleteBillDaThanhToan.initial,
    this.statusBillSearchDaThanhToan = StatusBillSearchDaThanhToan.initial,
  });

  final StatusSubmit statusThanhToan;
  final StatusInitial statusInitial;
  final String msg;
  final List<ModelChuathanhtoan> lsBillDaThanhToan;
  final StatusSubmitDeleteBillDaThanhToan statusSubmitDeleteBillDaThanhToan;
  final StatusBillSearchDaThanhToan statusBillSearchDaThanhToan;
  HoaDonDaThanhToanState copyWith({
    StatusSubmit? statusThanhToan,
    StatusInitial? statusInitial,
    String? msg,
    List<ModelChuathanhtoan>? lsBillDaThanhToan,
    required statusBill,
    StatusSubmitDeleteBillDaThanhToan? statusSubmitDeleteBillDaThanhToan,
    StatusBillSearchDaThanhToan? statusBillSearchDaThanhToan,

  }) {
    return HoaDonDaThanhToanState(
        statusThanhToan: statusThanhToan ?? this.statusThanhToan,
        statusInitial: statusInitial ?? this.statusInitial,
        msg: msg ?? this.msg,
        lsBillDaThanhToan: lsBillDaThanhToan ?? this.lsBillDaThanhToan,
        statusSubmitDeleteBillDaThanhToan: statusSubmitDeleteBillDaThanhToan ?? this.statusSubmitDeleteBillDaThanhToan,
        statusBillSearchDaThanhToan: statusBillSearchDaThanhToan ?? this.statusBillSearchDaThanhToan,
    );
  }

  @override
  List<Object> get props => [
    statusThanhToan,
    statusInitial,
    msg,
    lsBillDaThanhToan,
    statusSubmitDeleteBillDaThanhToan,
    statusBillSearchDaThanhToan
  ];
}

