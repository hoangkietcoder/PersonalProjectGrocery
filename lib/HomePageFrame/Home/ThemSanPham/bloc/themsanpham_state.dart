part of 'themsanpham_bloc.dart';

enum CreateStatus { inittial, loading, success, failure }

class ThemsanphamState extends Equatable {
  const ThemsanphamState({
    this.img_url="",
    this.ten = "",
    this.soluong = "",
    this.giasanpham = "",
    this.tennhacungcap = "",
    this.sdtnhacungcap = "",
    this.chuthich = "",
    this.statusSubmit = CreateStatus.inittial,
    this.error ="",
    this.message = "",
    this.typeProduct = 0,
  });
  final String img_url;
  final String ten;
  final String soluong;
  final String giasanpham;
  final String tennhacungcap;
  final String sdtnhacungcap;
  final String chuthich;
  final CreateStatus statusSubmit;
  final String error;
  final String message;
  final int? typeProduct; // biến để loại sản phẩm là gì

  ThemsanphamState copyWith({
    String? img_url,
    String? ten,
    String? soluong,
    String? giasanpham,
    String? tennhacungcap,
    String? sdtnhacungcap,
    String? chuthich,
    CreateStatus? statusSubmit,
    String? error,
    String? message,
    int? typeProduct,
  }) {
    return ThemsanphamState(
      img_url: img_url ?? this.img_url,
      ten: ten ?? this.ten,
      soluong: soluong ?? this.soluong,
      giasanpham: giasanpham ?? this.giasanpham,
      tennhacungcap: tennhacungcap ?? this.tennhacungcap,
      sdtnhacungcap: sdtnhacungcap ?? this.sdtnhacungcap,
      chuthich: chuthich ?? this.chuthich,
      statusSubmit: statusSubmit ?? this.statusSubmit,
      error: error ?? this.error,
      message: message ?? this.message,
      typeProduct: typeProduct ?? this.typeProduct,
    );
  }

  @override
  List<Object?> get props => [img_url,ten , soluong, giasanpham, tennhacungcap, sdtnhacungcap, chuthich, statusSubmit, error,message,typeProduct];
}
