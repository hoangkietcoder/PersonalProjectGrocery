

import 'package:equatable/equatable.dart';

class ModelChuathanhtoan extends Equatable{

  const ModelChuathanhtoan({
    required this.idBill,
    this.idDocBill ="",
    required this.status,
    required this.nameBill,
    required this.nameSeller,
    required this.nameBuyer,
    required this.date,
    required this.totalPriceBill,
    required this.noteBill,
  });

  final String idBill; // mã hóa đơn tự sinh
  final String idDocBill;
  final String status;
  final String nameBill;
  final String nameSeller;
  final String nameBuyer;
  final String date;
  final String totalPriceBill;
  final String noteBill;



  /// Tạo đối tượng rỗng
  static const empty = ModelChuathanhtoan(idDocBill: '', idBill: '',nameBill: '', nameSeller: '', nameBuyer: '', date: '', totalPriceBill: '', noteBill: '', status: '');

  /// Tạo trống đối tượng
  bool get isEmpty => this == ModelChuathanhtoan.empty;

  /// Đối tượng không trống.
  bool get isNotEmpty => this != ModelChuathanhtoan.empty;

  // convert thành object ( from là lấy về , to là gửi lên )
  factory ModelChuathanhtoan.fromJson(Map<String, dynamic> json) => ModelChuathanhtoan(
      idBill: json["idBill"] ?? "",
      idDocBill: json["idDocBill"] ?? "",
      status: json["status"] ?? "0",
      nameBill: json["nameBill"] ?? "",
      nameSeller: json["nameSeller"] ?? "",
      nameBuyer: json["nameBuyer"] ?? "",
      date: json["date"] ?? "",
      totalPriceBill: json["totalPriceBill"] ?? -1,
      noteBill: json["noteBill"] ?? ""
  );

  // copywith để thay chỗ cần thay
  ModelChuathanhtoan copyWith({
    String? idDocBill,
    String? idBill,
    String? status,
    String? nameBill,
    String? nameSeller,
    String? nameBuyer,
    String? date,
    String? totalPriceBill,
    String? noteBill,
  }) {
    return ModelChuathanhtoan(
        idDocBill: idDocBill ?? this.idDocBill,
        idBill: idBill ?? this.idBill,
        status: status ?? this.status,
        nameBill: nameBill ?? this.nameBill,
        nameSeller:  nameSeller ?? this.nameSeller,
        nameBuyer: nameBuyer ?? this.nameBuyer,
        date: date ?? this.date,
        totalPriceBill:  totalPriceBill ?? this.totalPriceBill,
        noteBill: noteBill ?? this.noteBill
    );
  }


  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateProduct() => {
    "idBill": idBill,
    "idDocBill":idDocBill,
    "status": status,
    "nameBill": nameBill,
    "nameSeller": nameSeller,
    "nameBuyer": nameBuyer,
    "date": date,
    "totalPriceBill": totalPriceBill,
    "noteBill": noteBill,
  };


  @override
  List<Object?> get props =>[idBill,idDocBill,status, nameBill,nameSeller,nameBuyer,date,totalPriceBill,noteBill];

}