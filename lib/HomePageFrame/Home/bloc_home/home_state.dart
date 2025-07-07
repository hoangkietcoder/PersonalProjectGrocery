part of 'home_bloc.dart';

enum StatusHome{initial , failure , successful}
enum StatusHomePost{unknown , failure , successful, isProcessing}
enum StatusLoadPage{initial, loading,success, failure}

class HomeState extends Equatable {
  const HomeState({
    this.lsProduct = const [],
    this.statusHome = StatusHome.initial,
    this.statusDeleteProduct=StatusHomePost.unknown,
    this.error="",
    required this.hasReachedEnd,
    this.statusLoadPage = StatusLoadPage.initial

  });

  // tạo list với Model là getDataProduct
  final List<getDataProduct> lsProduct;

  // trạng thái
  final StatusHome statusHome;
  final StatusHomePost statusDeleteProduct;
  final String error;

  // làm cho phân trang
  final bool hasReachedEnd;
  final StatusLoadPage statusLoadPage;




  HomeState copyWith({
      List<getDataProduct>? lsProduct,
      StatusHome? statusHome,
      StatusHomePost? statusDeleteProduct,
      String? error,
      bool? hasReachedEnd,
      StatusLoadPage? statusLoadPage,


  }) {
    return HomeState(
      lsProduct: lsProduct ?? this.lsProduct,
      statusHome: statusHome ?? this.statusHome,
      statusDeleteProduct: statusDeleteProduct ?? this.statusDeleteProduct,
      error: error ?? this.error,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      statusLoadPage: statusLoadPage ?? this.statusLoadPage,

    );
  }

  @override
  List<Object?> get props => [lsProduct,statusHome,statusDeleteProduct,error,hasReachedEnd,statusLoadPage];
}

