part of 'themhoadon_bloc.dart';


enum BillStatus { initial,loading, failure ,successful}

 class ThemhoadonState extends Equatable {
  const ThemhoadonState({
    this.nameBill ="",
    this.codeBill ="",
    this.nameSeller ="",
    this.nameBuyer="",
    required this.date,
    this.totalPriceBill = "",
    this.noteBill = "",
    this.billStatus = BillStatus.initial,
    this.error = "",
    this.message="",
 });





  final String nameBill;
  final String codeBill; // mã hóa đơn
  final String nameSeller;
  final String nameBuyer;
  final String date;
  final String totalPriceBill;
  final String noteBill;
  final BillStatus billStatus;
  final String error;
  final String message;


  ThemhoadonState copyWith({
   String? nameBill,
   String? codeBill,
   String? nameSeller,
   String? nameBuyer,
   String? date,
   String? totalPriceBill,
   String? noteBill,
   BillStatus? billStatus,
   String? error,
   String? message,

 }){

   return ThemhoadonState(
    nameBill: nameBill ?? this.nameBill,
    codeBill: codeBill ?? this.codeBill,
    nameSeller: nameSeller ?? this.nameSeller,
    nameBuyer: nameBuyer ?? this.nameBuyer,
    date: date ?? this.date,
    totalPriceBill: totalPriceBill ?? this.totalPriceBill,
    noteBill: noteBill ?? this.noteBill,
    billStatus: billStatus ?? this.billStatus,
    error: error ?? this.error,
    message: message ?? this.message
   );
}



  @override
  List<Object> get props => [nameBill,codeBill,nameSeller,nameBuyer,date,totalPriceBill,noteBill,billStatus,error,message];
}


