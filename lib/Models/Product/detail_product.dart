


import 'package:equatable/equatable.dart';

class DetailProduct extends Equatable{
  const DetailProduct({
    required this.id,
    this.img_url = "",
    required this.nameProduct,
    required this.quantityProduct,
    required this.priceProduct,
    required this.supplierName,
    required this.phoneSupplier,
    required this.noteProduct,

});
      final String id;
      final String img_url;
      final String nameProduct;
      final String quantityProduct;
      final String priceProduct;
      final String supplierName;
      final String phoneSupplier;
      final String noteProduct;

  /// Tạo đối tượng rỗng.
  static const empty = DetailProduct(nameProduct: '', quantityProduct: '', priceProduct: '', supplierName: '', phoneSupplier: '', noteProduct: '', id: '');

  ///
  bool get isEmpty => this == DetailProduct.empty;

  ///
  bool get isNotEmpty => this != DetailProduct.empty;



  // copywith để thay chỗ cần thay
  DetailProduct copyWith({
    String? id,
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
  }) {
    return DetailProduct(
        id:  id ?? this.id,
        img_url: img_url ?? this.img_url,
        nameProduct: nameProduct ?? this.nameProduct,
        quantityProduct:  quantityProduct ?? this.quantityProduct,
        priceProduct: priceProduct ?? this.priceProduct,
        supplierName: supplierName ?? this.supplierName,
        phoneSupplier:  phoneSupplier ?? this.phoneSupplier,
        noteProduct: noteProduct ?? this.noteProduct
    );
  }


  // convert thành object ( from là lấy về , to là gửi lên )
  factory DetailProduct.fromJson(Map<String, dynamic> json) {
    return DetailProduct(
      id: json['id'] ?? "",
      img_url: json['img_url'] ?? "",
      nameProduct: json['nameProduct'] ?? "" ,
      quantityProduct: json['quantityProduct'] ?? "",
      priceProduct: json['priceProduct'] ?? "",
      supplierName: json['supplierName'] ?? "",
      phoneSupplier: json['phoneSupplier'] ?? "",
      noteProduct: json['noteProduct'] ?? "",

    );
  }


  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonDetailProduct() => {
    "img_url": img_url,
    "nameProduct": nameProduct,
    "quantityProduct": quantityProduct,
    "priceProduct": priceProduct,
    "supplierName": supplierName,
    "phoneSupplier": phoneSupplier,
    "noteProduct": noteProduct,
  };

 // check sự thay đổi
  @override
  List<Object?> get props =>[id,img_url, nameProduct,quantityProduct,priceProduct,supplierName,phoneSupplier,noteProduct];
}