
import 'package:objectbox/objectbox.dart';

// file này để lưu local
@Entity()
class ModelProductLocal {
  int id = 0; // bắt buộc cho ObjectBox
  final String fireBaseId;
  final String img_url ;
  final String nameProduct;
  final String quantityProduct;
  final String priceProduct;
  final String supplierName;
  final String phoneSupplier;
  final String noteProduct;

  ModelProductLocal({
    this.id = 0,
    required this.fireBaseId,
    this.img_url = "",
    required this.nameProduct,
    required this.quantityProduct,
    required this.priceProduct,
    required this.supplierName,
    required this.phoneSupplier,
    required this.noteProduct,
});

  //
  Map<String,dynamic> toJson() => {
    'fireBaseId': fireBaseId,
    'img_url': img_url,
    'nameProduct': nameProduct,
    'quantityProduct': quantityProduct,
    'priceProduct': priceProduct,
    'supplierName': supplierName,
    'phoneSupplier': phoneSupplier,
    'noteProduct': noteProduct,
  };

  // convert thành object ( from là lấy về , to là gửi lên )
  factory ModelProductLocal.fromJson(Map<String, dynamic> json) => ModelProductLocal(
      fireBaseId: json["fireBaseId"] ?? "",
      img_url: json["img_url"] ?? "",
      nameProduct: json["nameProduct"] ?? "",
      quantityProduct: json["quantityProduct"] ?? "",
      priceProduct: json["priceProduct"] ?? "",
      supplierName: json["supplierName"] ?? "",
      phoneSupplier: json["phoneSupplier"] ?? -1,
      noteProduct: json["noteProduct"] ?? ""
  );


  // copywith để thay chỗ cần thay
  ModelProductLocal copyWith({
    int? id,
    String? fireBaseId,
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
}) {
    return ModelProductLocal (
      id: id ?? this.id,
      fireBaseId: fireBaseId ?? this.fireBaseId,
      img_url: img_url ?? this.img_url,
      nameProduct: nameProduct ?? this.nameProduct,
      quantityProduct: quantityProduct ?? this.quantityProduct,
      priceProduct: priceProduct ?? this.priceProduct,
      supplierName: supplierName ?? this.supplierName,
      phoneSupplier: phoneSupplier ?? this.phoneSupplier,
      noteProduct: noteProduct ?? this.noteProduct,
    );
}

  @override
  List<Object?> get props =>[id,fireBaseId,img_url, nameProduct,quantityProduct,priceProduct,supplierName,phoneSupplier,noteProduct];


}