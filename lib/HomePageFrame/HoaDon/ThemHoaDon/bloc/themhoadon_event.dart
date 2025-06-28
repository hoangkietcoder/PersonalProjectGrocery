part of 'themhoadon_bloc.dart';

 class ThemhoadonEvent extends Equatable {
  const ThemhoadonEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CreateBillRequested extends ThemhoadonEvent {
  const CreateBillRequested();
}




//===========================================================

class CreateNameBill extends ThemhoadonEvent{
  const CreateNameBill(this.nameBill);

  final String nameBill;
  @override
  List<Object> get props => [nameBill];
}

class CreateNameSellerBill extends ThemhoadonEvent{
  const CreateNameSellerBill(this.nameSeller);

  final String nameSeller;
  @override
  List<Object> get props => [nameSeller];
}

class CreateNameBuyerBill extends ThemhoadonEvent{
  const CreateNameBuyerBill(this.nameBuyer);

  final String nameBuyer;
  @override
  List<Object> get props => [nameBuyer];
}

class CreateDateBill extends ThemhoadonEvent{
  const CreateDateBill(this.dateBill);

  final String dateBill;
  @override
  List<Object> get props => [dateBill];
}

class CreateTotalPriceBill extends ThemhoadonEvent{
  const CreateTotalPriceBill(this.totalPriceBill);

  final String totalPriceBill;
  @override
  List<Object> get props => [totalPriceBill];
}

class CreateNoteBill extends ThemhoadonEvent{
  const CreateNoteBill(this.noteBill);

  final String noteBill;
  @override
  List<Object> get props => [noteBill];
}


