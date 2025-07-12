  // tạo Model để convert từ firebase về gán vô model này
  import 'package:cloud_firestore/cloud_firestore.dart';

  class ModelDanhMucFireBase {
    const ModelDanhMucFireBase({
      this.createAt,
      required this.id,
      this.img_url ="",
      required this.nameProduct,
      required this.noteProduct,
      required this.phoneSupplier,
      required this.priceProduct,
      required this.quantityProduct,
      required this.supplierName,
      this.typeProduct,
      this.userId = "",

    });

    final Timestamp? createAt;
    final String id;
    final String img_url;
    final String nameProduct;
    final String noteProduct;
    final String phoneSupplier;
    final String priceProduct;
    final String quantityProduct;
    final String supplierName;
    final int? typeProduct;
    final String userId;

    /// tạo đối tượng rỗng
    static const empty = ModelDanhMucFireBase(nameProduct: '', noteProduct: '', phoneSupplier: '', priceProduct: '', quantityProduct: '', supplierName: '',id: "");

    ///
    bool get isEmpty => this == ModelDanhMucFireBase.empty;

    ///
    bool get isNotEmpty => this != ModelDanhMucFireBase.empty;

    // copywith để thay chỗ cần thay
    ModelDanhMucFireBase copyWith({
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
    }) {
      return ModelDanhMucFireBase(
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
      );
    }


    // convert thành object ( from là lấy về , to là gửi lên )
    factory ModelDanhMucFireBase.fromJson(Map<String, dynamic> json, String id) => ModelDanhMucFireBase(
            createAt: json["createAt"] is Timestamp ? json["createAt"] as Timestamp : null,
            id:  id, // gán id: id, tức là dùng doc.id từ Firestore "",
            img_url: json["img_url"] ?? "",
            nameProduct: json["nameProduct"] ?? "",
            noteProduct: json["noteProduct"] ?? "",
            phoneSupplier: json["phoneSupplier"] ?? "",
            priceProduct: json["priceProduct"] ?? "",
            quantityProduct: json["quantityProduct"] ?? "",
            supplierName: json["supplierName"] ?? "",
            typeProduct:  json["typeProduct"] is int ? json["typeProduct"] : int.tryParse(json["typeProduct"].toString()),
            userId: json["userId"] ?? "",

      );

      // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
      Map<String, dynamic> toJson() =>
          {
            "createAt": createAt,
            "id": id,
            "img_url": img_url,
            "nameProduct": nameProduct,
            "noteProduct": noteProduct,
            "phoneSupplier": phoneSupplier,
            "priceProduct": priceProduct,
            "quantityProduct": quantityProduct,
            "supplierName": supplierName,
            "typeProduct": typeProduct,
            "userId": userId,
          };

    // check sự thay đổi
    @override
    List<Object?> get props =>[createAt,id,img_url,nameProduct,noteProduct,phoneSupplier,priceProduct,quantityProduct,supplierName,typeProduct,userId];
  }
