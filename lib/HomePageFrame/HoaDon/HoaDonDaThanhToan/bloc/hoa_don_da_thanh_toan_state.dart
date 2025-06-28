part of 'hoa_don_da_thanh_toan_bloc.dart';


final class HoaDonDaThanhToanState extends Equatable {
  const HoaDonDaThanhToanState({
    this.statusThanhToan = StatusSubmit.unknown,
    this.statusInitial = StatusInitial.initial,
    this.msg = "",
    this.lsBillDaThanhToan = const []
  });

  final StatusSubmit statusThanhToan;
  final StatusInitial statusInitial;
  final String msg;
  final List<ModelChuathanhtoan> lsBillDaThanhToan;

  HoaDonDaThanhToanState copyWith({
    StatusSubmit? statusThanhToan,
    StatusInitial? statusInitial,
    String? msg,
    List<ModelChuathanhtoan>? lsBillDaThanhToan, required statusBill
  }) {
    return HoaDonDaThanhToanState(
        statusThanhToan: statusThanhToan ?? this.statusThanhToan,
        statusInitial: statusInitial ?? this.statusInitial,
        msg: msg ?? this.msg,
        lsBillDaThanhToan: lsBillDaThanhToan ?? this.lsBillDaThanhToan
    );
  }

  @override
  List<Object> get props => [
    statusThanhToan,
    statusInitial,
    msg,
    lsBillDaThanhToan,
  ];
}

