part of 'home_bloc.dart';

enum StatusHome{initial , failure , successful}
enum StatusHomePost{unknown , failure , successful, isProcessing}

class HomeState extends Equatable {
  const HomeState({this.lsProduct = const [],this.statusHome = StatusHome.initial,this.statusDeleteProduct=StatusHomePost.unknown,this.error=""});

  // tạo list với Model là getDataProduct
  final List<getDataProduct> lsProduct;

  // trạng thái
  final StatusHome statusHome;
  final StatusHomePost statusDeleteProduct;
  final String error;



  HomeState copyWith({
      List<getDataProduct>? lsProduct,
      StatusHome? statusHome,
      StatusHomePost? statusDeleteProduct,
      String? error,
  }) {
    return HomeState(
      lsProduct: lsProduct ?? this.lsProduct,
      statusHome: statusHome ?? this.statusHome,
      statusDeleteProduct: statusDeleteProduct ?? this.statusDeleteProduct,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [lsProduct,statusHome,statusDeleteProduct];
}

