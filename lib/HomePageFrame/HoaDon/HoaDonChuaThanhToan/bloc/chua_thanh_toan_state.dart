part of 'chua_thanh_toan_bloc.dart';

enum StatusChuaThanhToan { initial, failure, successful }
enum DeleteStatusBill { initial,loading, failure ,successful} // trạng thái xóa bill
enum StatusSubmitThanhToan {initial, failure, successful} // trạng thái khi bấm submit thanh toán
enum StatusBillType {none , delete , submitPay } // phân loại cho bloc listner cái nào là xóa cái nào là thanh toán
class ChuaThanhToanState extends Equatable {
  const ChuaThanhToanState({
        this.lstBillChuaThanhToan = const [],
        this.statusBill = StatusChuaThanhToan.initial,
        this.error = "",
        this.modelChuathanhtoan = ModelChuathanhtoan.empty,
        this.deleteStatusBill = DeleteStatusBill.initial,
        this.statusBillType = StatusBillType.none,
        this.statusSubmitThanhToan = StatusSubmitThanhToan.initial,
        required this.searchText,

      });

  // tạo list với Model là ModelChuathanhtoan
  final List<ModelChuathanhtoan> lstBillChuaThanhToan;

  // trạng thái
  final StatusChuaThanhToan statusBill;
  // final StatusHomePost statusDeleteProduct;
  final String error;
  final ModelChuathanhtoan modelChuathanhtoan;
  final DeleteStatusBill deleteStatusBill;
  final StatusBillType statusBillType;
  final StatusSubmitThanhToan statusSubmitThanhToan;

  final String searchText;


  ChuaThanhToanState copyWith({
    List<ModelChuathanhtoan>? lstBillChuaThanhToan,
    StatusChuaThanhToan? statusBill,
    String? error,
    ModelChuathanhtoan? modelChuathanhtoan,
    DeleteStatusBill? deleteStatusBill,
    StatusBillType? statusBillType,
    StatusSubmitThanhToan? statusSubmitThanhToan,

    //
    String? searchText,

  }) {
    return ChuaThanhToanState(
      lstBillChuaThanhToan: lstBillChuaThanhToan ?? this.lstBillChuaThanhToan,
      statusBill: statusBill ?? this.statusBill,
      error: error ?? this.error,
      modelChuathanhtoan: modelChuathanhtoan ?? this.modelChuathanhtoan,
      deleteStatusBill: deleteStatusBill ?? this.deleteStatusBill,
      statusBillType: statusBillType ?? this.statusBillType,
      statusSubmitThanhToan: statusSubmitThanhToan ?? this.statusSubmitThanhToan,
      searchText: searchText ?? this.searchText
    );
  }

  @override
  List<Object> get props => [lstBillChuaThanhToan, statusBill, error,modelChuathanhtoan,deleteStatusBill,statusBillType,statusSubmitThanhToan,searchText];
}
