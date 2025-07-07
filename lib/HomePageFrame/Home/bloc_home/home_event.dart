part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// cho chức năng tạo sản phẩm
final class _ProductHomeEventChange extends HomeEvent{
  const _ProductHomeEventChange(this.lsProduct);

 final List<getDataProduct> lsProduct;
}

// cho chức năng search
final class SearchProductHomeEventChange extends HomeEvent{
  const SearchProductHomeEventChange(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

// cho chức năng xóa
final class DeleteProduct extends HomeEvent{
  const DeleteProduct(this.productId);

  // truyền thêm ID vào trang chi tiết
  final String productId;

}

// cho chức năng phân trang
final class FetchPage extends HomeEvent {
  FetchPage();
  @override
  List<Object?> get props => [];
}


// // cho thêm sản phẩm từ trang chủ qua trang giỏ hàng
// final class getProduct extends HomeEvent{
//   const getProduct(this.idGetProduct);
//
//   // truyền thêm ID vào trang chi tiết
//   final String idGetProduct;
//
// }