



import 'package:equatable/equatable.dart';

class CreateProduct extends Equatable{

  const CreateProduct({
    this.img_url = "",
    required this.nameProduct,
    required this.quantityProduct,
    required this.priceProduct,
    required this.supplierName,
    required this.phoneSupplier,
    required this.noteProduct,
  });


  final String img_url;
  final String nameProduct;
  final String quantityProduct;
  final String priceProduct;
  final String supplierName;
  final String phoneSupplier;
  final String noteProduct;



  /// Tạo đối tượng rỗng
  static const empty = CreateProduct(nameProduct: '', quantityProduct: '', priceProduct: '', supplierName: '', phoneSupplier: '', noteProduct: '');

  /// Tạo trống đối tượng
  bool get isEmpty => this == CreateProduct.empty;

  /// Đối tượng không trống.
  bool get isNotEmpty => this != CreateProduct.empty;

  // convert thành object ( from là lấy về , to là gửi lên )
  factory CreateProduct.fromJson(Map<String, dynamic> json) => CreateProduct(
      img_url: json["img_url"] ?? "",
      nameProduct: json["nameProduct"] ?? "",
      quantityProduct: json["quantityProduct"] ?? "",
      priceProduct: json["priceProduct"] ?? "",
      supplierName: json["supplierName"] ?? "",
      phoneSupplier: json["phoneSupplier"] ?? -1,
      noteProduct: json["noteProduct"] ?? ""
  );

  // copywith để thay chỗ cần thay
  CreateProduct copyWith({
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
  }) {
    return CreateProduct(
        img_url: img_url ?? this.img_url,
        nameProduct: nameProduct ?? this.nameProduct,
        quantityProduct:  quantityProduct ?? this.quantityProduct,
        priceProduct: priceProduct ?? this.priceProduct,
        supplierName: supplierName ?? this.supplierName,
        phoneSupplier:  phoneSupplier ?? this.phoneSupplier,
        noteProduct: noteProduct ?? this.noteProduct
    );
  }


  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateProduct() => {
    "img_url": img_url,
    "nameProduct": nameProduct,
    "quantityProduct": quantityProduct,
    "priceProduct": priceProduct,
    "supplierName": supplierName,
    "phoneSupplier": phoneSupplier,
    "noteProduct": noteProduct,
  };




  @override
  List<Object?> get props =>[img_url, nameProduct,quantityProduct,priceProduct,supplierName,phoneSupplier,noteProduct];

}