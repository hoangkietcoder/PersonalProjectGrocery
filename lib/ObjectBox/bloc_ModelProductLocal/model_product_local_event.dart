part of 'model_product_local_bloc.dart';

sealed class ModelProductLocalEvent extends Equatable {
  const ModelProductLocalEvent();
}

// Event để yêu cầu lưu danh sách sản phẩm
class SaveProductLocalEvent extends ModelProductLocalEvent {
  final ModelProductLocal product;

  const SaveProductLocalEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// Event lấy dữ liệu từ local lên
class GetProductLocalEvent extends ModelProductLocalEvent {
  const GetProductLocalEvent();
  @override
  List<Object?> get props => [];
}


// Event xử lí xóa 1 sản phẩm
final class DeleteLocalProductEvent extends ModelProductLocalEvent {
  final int id; // ID của sản phẩm trong ObjectBox

  const DeleteLocalProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// Event xử lí xóa tất cả sản phẩm
final class DeleteAllLocalProductCartEvent extends ModelProductLocalEvent {
  const DeleteAllLocalProductCartEvent();

  @override
  List<Object?> get props => [];
}

// Event xử lí sau khi xóa xong refresh lại danh sách ( dùng stream )
final class RefreshListProDuctLocalCartEvent extends ModelProductLocalEvent {
  const RefreshListProDuctLocalCartEvent();

  @override
  List<Object?> get props => [];
}





// Event xử lí tăng giảm số lượng
class UpdateQuantityProductLocalEvent extends ModelProductLocalEvent {
  UpdateQuantityProductLocalEvent({required this.product , required this.change});
  final ModelProductLocal product;
  final int change; // +1 hoặc -1
  @override
  List<Object?> get props => [product,change];
}




