part of 'chitietsanpham_bloc.dart';






enum DetailStatus { initial, loading, failure ,successful}
enum DetailStatusInitial { initial,loading, failure ,successful}


class ChitietsanphamState extends Equatable {
  const ChitietsanphamState({
    this.detailProduct = DetailProduct.empty,
    this.detailStatus = DetailStatus.initial,
    this.detailStatusInitial = DetailStatusInitial.initial,
    this.deleteProduct = DetailStatusInitial.initial,
    this.error="",
    this.message="",
    this.lstData = const [],


  });

  // tạo list với Model là getDataProduct
  final DetailProduct detailProduct;
  final DetailStatus detailStatus;
  final DetailStatusInitial detailStatusInitial;
  final DetailStatusInitial deleteProduct;

  final String error;
  final String message;
  final List<getDataProduct> lstData;

  ChitietsanphamState copyWith({
    DetailProduct? detailProduct,
    DetailStatus? detailStatus,
    DetailStatusInitial? detailStatusInitial,
    DetailStatusInitial? deleteProduct,
    String? error,
    String? message,
    List<getDataProduct>? lstData

  }) {
    return ChitietsanphamState(
        detailProduct: detailProduct ?? this.detailProduct,
        detailStatus: detailStatus ?? this.detailStatus,
        detailStatusInitial: detailStatusInitial ?? this.detailStatusInitial,
        deleteProduct:  deleteProduct ?? this.deleteProduct,
        error: error ?? this.error,
        message: message ?? this.message,
        lstData:  lstData ?? this.lstData,
    );
  }


  // check sự thay đổi
  @override
  List<Object?> get props => [detailProduct, detailStatus, detailStatusInitial,deleteProduct, error, message,lstData];
}