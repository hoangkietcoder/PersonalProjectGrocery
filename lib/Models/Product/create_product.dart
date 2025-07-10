



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CreateProduct extends Equatable{

  const CreateProduct({
    this.id = "",
    this.img_url = "",
    required this.nameProduct,
    required this.quantityProduct,
    required this.priceProduct,
    required this.supplierName,
    required this.phoneSupplier,
    required this.noteProduct,
    this.createdAt,
    required this.userId,
  });

  final String id;
  final String img_url;
  final String nameProduct;
  final String quantityProduct;
  final String priceProduct;
  final String supplierName;
  final String phoneSupplier;
  final String noteProduct;
  final Timestamp? createdAt ;
  final String userId;


  /// Tạo đối tượng rỗng
  static const empty = CreateProduct(id: '',nameProduct: '', quantityProduct: '', priceProduct: '', supplierName: '', phoneSupplier: '', noteProduct: '' ,img_url: "", userId: '');

  /// Tạo trống đối tượng
  bool get isEmpty => this == CreateProduct.empty;

  /// Đối tượng không trống.
  bool get isNotEmpty => this != CreateProduct.empty;



  // copywith để thay chỗ cần thay
  CreateProduct copyWith({
    String? id,
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
    Timestamp? createdAt,
    String? userId,
  }) {
    return CreateProduct(
        id: id ?? this.id,
        img_url: img_url ?? this.img_url,
        nameProduct: nameProduct ?? this.nameProduct,
        quantityProduct:  quantityProduct ?? this.quantityProduct,
        priceProduct: priceProduct ?? this.priceProduct,
        supplierName: supplierName ?? this.supplierName,
        phoneSupplier:  phoneSupplier ?? this.phoneSupplier,
        noteProduct: noteProduct ?? this.noteProduct,
        createdAt: createdAt ?? this.createdAt,
        userId: userId ?? this.userId,
    );
  }

  // convert thành object ( from là lấy về , to là gửi lên )
  factory CreateProduct.fromJson(Map<String, dynamic> json,String id) => CreateProduct(
    id: id,
    img_url: json["img_url"] ?? "",
    nameProduct: json["nameProduct"] ?? "",
    quantityProduct: json["quantityProduct"] ?? "",
    priceProduct: json["priceProduct"] ?? "",
    supplierName: json["supplierName"] ?? "",
    phoneSupplier: json["phoneSupplier"] ?? -1,
    noteProduct: json["noteProduct"] ?? "",
    createdAt:  json["createdAt"], // <-- không cần ép kiểu vì đã là Timestamp
    userId:  json["userId"],
  );



  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateProduct() => {
    'id': id,
    "img_url": img_url,
    "nameProduct": nameProduct,
    "quantityProduct": quantityProduct,
    "priceProduct": priceProduct,
    "supplierName": supplierName,
    "phoneSupplier": phoneSupplier,
    "noteProduct": noteProduct,
    "createdAt": createdAt, // hoặc FieldValue.serverTimestamp() nếu là lúc tạo
    "userId" : userId,
  };




  @override
  List<Object?> get props =>[id,img_url, nameProduct,quantityProduct,priceProduct,supplierName,phoneSupplier,noteProduct,createdAt,userId];

}