part of 'chitietsanpham_bloc.dart';






enum DetailStatus { initial, loading, failure ,successful}
enum DetailStatusInitial { initial,loading, failure ,successful}
enum ImageStatus{ initial, picking,uploading, failure ,successful}


class ChitietsanphamState extends Equatable {
  const ChitietsanphamState({
    this.detailProduct = DetailProduct.empty,
    this.detailStatus = DetailStatus.initial,
    this.detailStatusInitial = DetailStatusInitial.initial,
    this.deleteProduct = DetailStatusInitial.initial,
    this.imageStatus = ImageStatus.initial,
    this.imagesByProductId = const {},
    this.error="",
    this.message="",
    this.lstData = const [],
    this.imageUrl="",
    this.typeProduct,


  });

  // tạo list với Model là getDataProduct
  final DetailProduct detailProduct;
  final DetailStatus detailStatus;
  final DetailStatusInitial detailStatusInitial;
  final DetailStatusInitial deleteProduct;
  final ImageStatus imageStatus;

  // Nếu có ảnh theo productId
  final Map<String, File> imagesByProductId;

  final String error;
  final String message;
  final List<getDataProduct> lstData;
  final String? imageUrl;
  final int? typeProduct;

  ChitietsanphamState copyWith({
    DetailProduct? detailProduct,
    DetailStatus? detailStatus,
    DetailStatusInitial? detailStatusInitial,
    DetailStatusInitial? deleteProduct,
    ImageStatus? imageStatus,
    Map<String, File>? imagesByProductId, // up ảnh
    String? error,
    String? message,
    List<getDataProduct>? lstData,
    String? imageUrl,
    int? typeProduct,

  }) {
    return ChitietsanphamState(
        detailProduct: detailProduct ?? this.detailProduct,
        detailStatus: detailStatus ?? this.detailStatus,
        detailStatusInitial: detailStatusInitial ?? this.detailStatusInitial,
        deleteProduct:  deleteProduct ?? this.deleteProduct,
        imageStatus: imageStatus ?? this.imageStatus,
        imagesByProductId: imagesByProductId ?? this.imagesByProductId,
        error: error ?? this.error,
        message: message ?? this.message,
        lstData:  lstData ?? this.lstData,
        imageUrl: imageUrl ?? this.imageUrl,
        typeProduct: typeProduct ?? this.typeProduct,
    );
  }


  // check sự thay đổi
  @override
  List<Object?> get props => [detailProduct, detailStatus, detailStatusInitial,deleteProduct,imageStatus,imagesByProductId, error, message,lstData,imageUrl,typeProduct];
}