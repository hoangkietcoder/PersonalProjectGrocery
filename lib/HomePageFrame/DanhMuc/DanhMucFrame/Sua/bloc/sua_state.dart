part of 'sua_bloc.dart';



enum StatusLoadSua {initial , loading, successful, failure}
enum StatusSearch {initial , loading, successful, failure}
class SuaState extends Equatable {
  const SuaState({
    this.createAt,
    this.id,
    this.img_url ="",
    required this.nameProduct,
    required this.noteProduct,
    required this.phoneSupplier,
    required this.priceProduct,
    required this.quantityProduct,
    required this.supplierName,
    this.typeProduct,
    this.userId = "",
    this.statusLoadSua = StatusLoadSua.initial,
    this.statusSearch = StatusSearch.initial,
    this.error = "",
    this.lstDanhMucSua = const [],
});




  final Timestamp? createAt;
  final String? id;
  final String img_url;
  final String nameProduct;
  final String noteProduct;
  final String phoneSupplier;
  final String priceProduct;
  final String quantityProduct;
  final String supplierName;
  final int? typeProduct;
  final String userId;

  final StatusLoadSua statusLoadSua;
  final StatusSearch statusSearch;
  final String error;
  final List<ModelDanhMucFireBase> lstDanhMucSua;

  // copywith để thay chỗ cần thay
  SuaState copyWith({
    Timestamp? createAt,
    String? id,
    String? img_url,
    String? nameProduct,
    String? noteProduct,
    String? phoneSupplier,
    String? priceProduct,
    String? quantityProduct,
    String? supplierName,
    int? typeProduct,
    String? userId,
    StatusLoadSua? statusLoadSua,
    StatusSearch? statusSearch,
    String? error,
    List<ModelDanhMucFireBase>? lstDanhMucSua,

  }) {
    return SuaState(
      createAt: createAt ?? this.createAt,
      id: id ?? this.id,
      img_url: img_url ?? this.img_url,
      nameProduct: nameProduct ?? this.nameProduct,
      noteProduct: noteProduct ?? this.noteProduct,
      phoneSupplier: phoneSupplier ?? this.phoneSupplier,
      priceProduct: priceProduct ?? this.priceProduct,
      quantityProduct: quantityProduct ?? this.quantityProduct,
      supplierName: supplierName ?? this.supplierName,
      typeProduct: typeProduct ?? this.typeProduct,
      userId: userId ?? this.userId,
      statusLoadSua: statusLoadSua ?? this.statusLoadSua,
      statusSearch : statusSearch ?? this.statusSearch,
      error: error ?? this.error,
      lstDanhMucSua: lstDanhMucSua ?? this.lstDanhMucSua,
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props => [createAt,id,img_url,nameProduct,noteProduct,phoneSupplier,priceProduct,quantityProduct,supplierName,typeProduct,userId,statusLoadSua,statusSearch,error,lstDanhMucSua];
}


