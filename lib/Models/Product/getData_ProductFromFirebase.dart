

import 'package:equatable/equatable.dart';

class getDataProduct extends Equatable{

  const getDataProduct({
    this.img_url = "",
    required this.nameProduct,
    required this.quantityProduct,
    required this.priceProduct,
    required this.supplierName,
    required this.phoneSupplier,
    required this.noteProduct,
    required this.id
  });


  final String img_url;
  final String nameProduct;
  final String quantityProduct;
  final String priceProduct;
  final String supplierName;
  final String phoneSupplier;
  final String noteProduct;
  final String id;



  /// Empty user which represents an unauthenticated user.
  static const empty = getDataProduct(nameProduct: '', quantityProduct: '', priceProduct: '', supplierName: '', phoneSupplier: '', noteProduct: '', id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == getDataProduct.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != getDataProduct.empty;

  // convert Json thành object
  factory getDataProduct.fromJson(Map<String, dynamic> json, String id) => getDataProduct(
      img_url: json["img_url"] ?? "",
      nameProduct: json["nameProduct"] ?? "",
      quantityProduct: json["quantityProduct"] ?? "",
      priceProduct: json["priceProduct"] ?? "",
      supplierName: json["supplierName"] ?? "",
      phoneSupplier: json["phoneSupplier"] ?? -1,
      noteProduct: json["noteProduct"] ?? "",
      id: id
  );

  // copywith để thay chỗ cần thay
  getDataProduct copyWith({
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
    String? id,
  }) {
    return getDataProduct(
        img_url: img_url ?? this.img_url,
        nameProduct: nameProduct ?? this.nameProduct,
        quantityProduct:  quantityProduct ?? this.quantityProduct,
        priceProduct: priceProduct ?? this.priceProduct,
        supplierName: supplierName ?? this.supplierName,
        phoneSupplier:  phoneSupplier ?? this.phoneSupplier,
        noteProduct: noteProduct ?? this.noteProduct,
        id: id ?? this.id
    );
  }


  // convert object thành map để đưa lên firebase
  Map<String, dynamic> toJsonGetDataProduct() => {
    "img_url": img_url,
    "nameProduct": nameProduct,
    "quantityProduct": quantityProduct,
    "priceProduct": priceProduct,
    "supplierName": supplierName,
    "phoneSupplier": phoneSupplier,
    "noteProduct": noteProduct,
    "id" : id
  };


  @override
  List<Object?> get props =>[img_url, nameProduct,quantityProduct,priceProduct,supplierName,phoneSupplier,noteProduct, id];

}