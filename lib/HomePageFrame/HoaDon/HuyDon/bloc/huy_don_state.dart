part of 'huy_don_bloc.dart';


enum StatusBillDaHuy { initial,loading, failure ,successful} // trạng thái lấy danh sách
enum StatusBillSearch {initial,loading, failure ,successful} // trạng thái search hóa đơn
 class HuyDonState extends Equatable {
  const HuyDonState({
    this.error = "",
    this.lsBillDaHuy = const [],
    this.statusBillDaHuy = StatusBillDaHuy.initial,
    this.statusBillSearch = StatusBillSearch.initial,


 });

  final String error;
  final List<ModelChuathanhtoan> lsBillDaHuy;
  final StatusBillDaHuy statusBillDaHuy;
  final StatusBillSearch statusBillSearch;


  HuyDonState copyWith ({
    String? error,
    List<ModelChuathanhtoan>? lsBillDaHuy,
    StatusBillDaHuy? statusBillDaHuy,
    StatusBillSearch? statusBillSearch,


 })
    {
        return HuyDonState(
           error: error ?? this.error,
           lsBillDaHuy: lsBillDaHuy ?? this.lsBillDaHuy,
           statusBillDaHuy: statusBillDaHuy ?? this.statusBillDaHuy,
           statusBillSearch: statusBillSearch ?? this.statusBillSearch,
        );
    }


  @override
  List<Object?> get props => [error,lsBillDaHuy,statusBillDaHuy,statusBillSearch];
}

