part of 'chua_thanh_toan_bloc.dart';

enum StatusChuaThanhToan { initial, failure, successful }
enum DetailStatusInitial { initial,loading, failure ,successful} // trạng thái xóa bill
class ChuaThanhToanState extends Equatable {
  const ChuaThanhToanState({
        this.lstBillChuaThanhToan = const [],
        this.statusBill = StatusChuaThanhToan.initial,
        this.error = "",
        this.modelChuathanhtoan = ModelChuathanhtoan.empty,
        this.deleteProduct = DetailStatusInitial.initial,

      });

  // tạo list với Model là ModelChuathanhtoan
  final List<ModelChuathanhtoan> lstBillChuaThanhToan;

  // trạng thái
  final StatusChuaThanhToan statusBill;
  // final StatusHomePost statusDeleteProduct;
  final String error;
  final ModelChuathanhtoan modelChuathanhtoan;
  final DetailStatusInitial deleteProduct;

  ChuaThanhToanState copyWith({
    List<ModelChuathanhtoan>? lstBillChuaThanhToan,
    StatusChuaThanhToan? statusBill,
    String? error,
    ModelChuathanhtoan? modelChuathanhtoan,
    DetailStatusInitial? deleteProduct,

  }) {
    return ChuaThanhToanState(
      lstBillChuaThanhToan: lstBillChuaThanhToan ?? this.lstBillChuaThanhToan,
      statusBill: statusBill ?? this.statusBill,
      // statusHome: statusHome ?? this.statusHome,
      // statusDeleteProduct: statusDeleteProduct ?? this.statusDeleteProduct,
      error: error ?? this.error,
     modelChuathanhtoan: modelChuathanhtoan ?? this.modelChuathanhtoan,
      deleteProduct: deleteProduct ?? this.deleteProduct,
    );
  }

  @override
  List<Object> get props => [lstBillChuaThanhToan, statusBill, error,modelChuathanhtoan,deleteProduct];
}
