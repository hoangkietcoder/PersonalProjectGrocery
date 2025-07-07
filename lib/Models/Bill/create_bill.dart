



import 'package:equatable/equatable.dart';

class CreateBill extends Equatable{

  const CreateBill({
    required this.idBillRandom,
    this.idBill = "",
    this.idDocBill = "",
    this.status = "0",
    required this.nameBill,
    required this.nameSeller,
    required this.nameBuyer,
    required this.date,
    required this.totalPriceBill,
    required this.noteBill,
  });

  final String idBillRandom;
  final String idBill;
  final String idDocBill;
  final String status;
  final String nameBill;
  final String nameSeller;
  final String nameBuyer;
  final String date;
  final String totalPriceBill;
  final String noteBill;

  /// Tạo đối tượng rỗng
  static const empty = CreateBill(idBillRandom:'',idBill:'',nameBill: '', nameSeller: '', nameBuyer: '', date: '', totalPriceBill: '', noteBill: '');

  /// Tạo trống đối tượng
  bool get isEmpty => this == CreateBill.empty;

  /// Đối tượng không trống.
  bool get isNotEmpty => this != CreateBill.empty;

  // convert thành object ( from là lấy về , to là gửi lên )
  factory CreateBill.fromJson(Map<String, dynamic> json) => CreateBill(
      idBillRandom: json["idBill"] ?? "",
      idBill: json["idBill"] ?? "",
      idDocBill: json["idDocBill"] ?? "",
      status: json["status"] ?? "",
      nameBill: json["nameBill"] ?? "",
      nameSeller: json["nameSeller"] ?? "",
      nameBuyer: json["nameBuyer"] ?? "",
      date: json["date"] ?? "",
      totalPriceBill: json["totalPriceBill"] ?? -1,
      noteBill: json["noteBill"] ?? ""
  );

  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateProduct() => {
    "idBillRandom" : idBillRandom,
    "idBill": idBill,
    "idDocBill": idDocBill,
    "status": status,
    "nameBill": nameBill,
    "nameSeller": nameSeller,
    "nameBuyer": nameBuyer,
    "date": date,
    "totalPriceBill": totalPriceBill,
    "noteBill": noteBill,
  };

  // copywith để thay chỗ cần thay
  CreateBill copyWith({
    String? idBillRandom,
    String? idBill,
    String? idDocBill,
    String? status,
    String? nameBill,
    String? nameSeller,
    String? nameBuyer,
    String? date,
    String? totalPriceBill,
    String? noteBill,
  }) {
    return CreateBill(
        idBillRandom:idBillRandom ?? this.idBillRandom ,
        idBill: idBill ?? this.idBill,
        idDocBill: idDocBill ?? this.idDocBill,
        status: status ?? this.status,
        nameBill: nameBill ?? this.nameBill,
        nameSeller:  nameSeller ?? this.nameSeller,
        nameBuyer: nameBuyer ?? this.nameBuyer,
        date: date ?? this.date,
        totalPriceBill:  totalPriceBill ?? this.totalPriceBill,
        noteBill: noteBill ?? this.noteBill
    );
  }





  @override
  List<Object?> get props =>[idBillRandom,idBill, idDocBill, status, nameBill, nameSeller, nameBuyer, date, totalPriceBill, noteBill];

}