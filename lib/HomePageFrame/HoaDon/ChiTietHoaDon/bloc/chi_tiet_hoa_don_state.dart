part of 'chi_tiet_hoa_don_bloc.dart';

 class ChiTietHoaDonState extends Equatable {
  const ChiTietHoaDonState({
    this.modelChuathanhtoan,
    this.isloading = false,
    this.error = ""
 });



  final ModelChuathanhtoan? modelChuathanhtoan;
  final bool isloading;
  final String error;


  ChiTietHoaDonState copyWith({
    ModelChuathanhtoan? modelChuathanhtoan,
    bool? isloading,
    String? error,
  }) {
    return ChiTietHoaDonState(
      modelChuathanhtoan: modelChuathanhtoan ?? this.modelChuathanhtoan,
      isloading: isloading ?? this.isloading,
      error: error ?? this.error,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [modelChuathanhtoan, isloading,error];
}

