part of 'themsanpham_bloc.dart';

sealed class ThemsanphamEvent extends Equatable {
  const ThemsanphamEvent();

  @override
  List<Object> get props => [];
}

class CreateProductRequested extends ThemsanphamEvent {
  const CreateProductRequested();
}



//===========================================================



class CreateTypeProduct extends ThemsanphamEvent {
  const CreateTypeProduct(this.typeProduct);
  final int typeProduct;
  @override
  List<Object> get props => [typeProduct];
}

class CreateNameProduct extends ThemsanphamEvent{
  const CreateNameProduct(this.ten);

  final String ten;
  @override
  List<Object> get props => [ten];
}

class CreateQuantityProduct extends ThemsanphamEvent{
  const CreateQuantityProduct(this.soluong);

  final String soluong;
  @override
  List<Object> get props => [soluong];
}

class CreatePriceProduct extends ThemsanphamEvent{
  const CreatePriceProduct(this.giasanpham);

  final String giasanpham;
  @override
  List<Object> get props => [giasanpham];
}

class CreateSupplierNameProduct extends ThemsanphamEvent{
  const CreateSupplierNameProduct(this.tennhacungcap);

  final String tennhacungcap;
  @override
  List<Object> get props => [tennhacungcap];
}


class CreatePhoneSupplierProduct extends ThemsanphamEvent{
  const CreatePhoneSupplierProduct(this.sdtnhacungcap);

  final String sdtnhacungcap;
  @override
  List<Object> get props => [sdtnhacungcap];
}

class CreateNoteProduct extends ThemsanphamEvent{
  const CreateNoteProduct(this.chuthich);

  final String chuthich;
  @override
  List<Object> get props => [chuthich];
}



