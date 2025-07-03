part of 'chitietsanpham_bloc.dart';

class ChitietsanphamEvent extends Equatable {
  const ChitietsanphamEvent();

  @override
  List<Object> get props => [];
}





final class DetailProductEventChange extends ChitietsanphamEvent{
  const DetailProductEventChange(this.productId);

  // truyền thêm ID vào trang chi tiết
  final String productId;
  @override
  List<Object> get props => [productId];

}


final class DeleteDetailProduct extends ChitietsanphamEvent{
  const DeleteDetailProduct(this.deleteProductId, this.index);

  // truyền thêm ID vào trang chi tiết ( index dùng để bắt độ dài list )
  final String deleteProductId;
  final int index;

  @override
  List<Object> get props => [deleteProductId,index];

}

  // up hình ảnh
final class UploadImageEvent extends ChitietsanphamEvent{
  const UploadImageEvent({ required this.ProductId,required this.imageFile });
  final String ProductId; // Id sản phẩm cần cập nhật ảnh
  final File imageFile;


  @override
  List<Object> get props => [ProductId,imageFile];
}

