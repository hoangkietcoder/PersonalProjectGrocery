part of 'danhmuc_bloc.dart';



enum DanhMucStatus { initial, loading, failure ,successful}
 class DanhmucState extends Equatable {
  const DanhmucState({
   this.error = "",
   this.message = "",
   this.danhmucStatus = DanhMucStatus.initial,
   this.lstDanhMuc = const [],

 });



  final String error;
  final String message;
  final DanhMucStatus danhmucStatus;
  final List<DanhMucData> lstDanhMuc;

  DanhmucState copyWith ({
    String? error,
    String? message,
    DanhMucStatus? danhmucStatus,
    List<DanhMucData>? lstDanhMuc,
 }) {
   return DanhmucState(
    error:  error ?? this.error,
    message: message ?? this.message,
    danhmucStatus: danhmucStatus ?? this.danhmucStatus,
    lstDanhMuc: lstDanhMuc ?? this.lstDanhMuc
   );
}


  // check sự thay đổi
  @override
  List<Object> get props => [error,message,danhmucStatus,lstDanhMuc];
}

