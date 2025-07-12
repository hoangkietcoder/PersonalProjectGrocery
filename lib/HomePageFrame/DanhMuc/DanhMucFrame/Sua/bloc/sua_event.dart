part of 'sua_bloc.dart';

sealed class SuaEvent extends Equatable {
  const SuaEvent();
}

 // vào trang load dữ liệu
class FetchSuaEvent extends SuaEvent {
  final String userId;
  final int typeProduct;

  const FetchSuaEvent({required this.userId, required this.typeProduct});

  @override
  List<Object> get props => [userId, typeProduct];
}

// sự kiện click vào trang chi tiết sản phẩm
final class DetailSuaEventChange extends SuaEvent{
  const DetailSuaEventChange(this.productId);

  // truyền thêm ID vào trang chi tiết
  final String productId;
  @override
  List<Object> get props => [productId];

}

// sự kiện tìm kiếm sản phẩm
class SearchProductDanhMuc extends SuaEvent {
  const SearchProductDanhMuc(this.keyword,this.type);
  final  int type;
  final String keyword;
  @override
  List<Object?> get props => [keyword,type];

}

