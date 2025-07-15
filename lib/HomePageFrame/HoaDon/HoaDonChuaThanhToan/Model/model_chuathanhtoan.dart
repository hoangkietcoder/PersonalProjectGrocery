

import 'package:equatable/equatable.dart';

class ModelChuathanhtoan extends Equatable{

  const ModelChuathanhtoan({
    required this.idBillRandom,
    this.idBill = "",
    required this.status,
    required this.nameBill,
    required this.nameSeller,
    required this.nameBuyer,
    required this.date,
    required this.totalPriceBill,
    required this.noteBill,
    required this.listProducts,
    required this.quantityProductLocal,
  });

  final String idBillRandom; // mã hóa đơn tự sinh
  final String idBill;
  final String status;
  final String nameBill;
  final String nameSeller;
  final String nameBuyer;
  final String date;
  final String totalPriceBill;
  final String noteBill;
  final int quantityProductLocal;


  ///  /// Danh sách sản phẩm (dưới dạng Map vì Firebase không hỗ trợ object custom trực tiếp)
  final List<Map<String, dynamic>> listProducts;



  /// Tạo đối tượng rỗng
  static const empty = ModelChuathanhtoan(idBillRandom: '',nameBill: '', nameSeller: '', nameBuyer: '', date: '', totalPriceBill: '', noteBill: '', status: '', idBill: '', listProducts: [], quantityProductLocal: 0);

  /// Tạo trống đối tượng
  bool get isEmpty => this == ModelChuathanhtoan.empty;

  /// Đối tượng không trống.
  bool get isNotEmpty => this != ModelChuathanhtoan.empty;

  // convert thành object ( from là lấy về , to là gửi lên )
    factory ModelChuathanhtoan.fromJson(Map<String, dynamic> json) => ModelChuathanhtoan(
        idBillRandom: json["idBillRandom"] ?? "",
        idBill:  json["idBill"] ?? "",
        status: json["status"] ?? "0",
        nameBill: json["nameBill"] ?? "",
        nameSeller: json["nameSeller"] ?? "",
        nameBuyer: json["nameBuyer"] ?? "",
        date: json["date"] ?? "",
        totalPriceBill: json["totalPriceBill"] ?? -1,
        noteBill: json["noteBill"] ?? "",
        listProducts: List<Map<String, dynamic>>.from(json["listProducts"] ?? []), //
        quantityProductLocal: json["quantityProductLocal"] is int ? json["quantityProductLocal"] : int.tryParse(json["quantityProductLocal"]?.toString() ?? "0") ?? 0,
    );

  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateProduct() => {

    "idBillRandom": idBillRandom,
    "status": status,
    "nameBill": nameBill,
    "nameSeller": nameSeller,
    "nameBuyer": nameBuyer,
    "date": date,
    "totalPriceBill": totalPriceBill,
    "noteBill": noteBill,
    "listProducts": listProducts,
    "quantityProductLocal" : quantityProductLocal

  };

  // copywith để thay chỗ cần thay
  ModelChuathanhtoan copyWith({
    String? idBillRandom,
    String? idBill,
    String? status,
    String? nameBill,
    String? nameSeller,
    String? nameBuyer,
    String? date,
    String? totalPriceBill,
    String? noteBill,
    List<Map<String, dynamic>>? listProducts,
    int? quantityProductLocal,
  }) {
    return ModelChuathanhtoan(
        idBillRandom: idBillRandom ?? this.idBillRandom,
        idBill: idBill ?? this.idBill,
        status: status ?? this.status,
        nameBill: nameBill ?? this.nameBill,
        nameSeller:  nameSeller ?? this.nameSeller,
        nameBuyer: nameBuyer ?? this.nameBuyer,
        date: date ?? this.date,
        totalPriceBill:  totalPriceBill ?? this.totalPriceBill,
        noteBill: noteBill ?? this.noteBill,
        listProducts: listProducts ?? this.listProducts,
        quantityProductLocal : quantityProductLocal ?? this.quantityProductLocal
    );
  }





  @override
  List<Object?> get props =>[idBillRandom,status, nameBill,nameSeller,nameBuyer,date,totalPriceBill,noteBill,listProducts,quantityProductLocal];

}