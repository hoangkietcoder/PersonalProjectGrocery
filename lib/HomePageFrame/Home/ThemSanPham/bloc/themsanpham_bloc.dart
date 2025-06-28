import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/Product/create_product.dart';
import '../../../../Repository/Firebase_Database/Product/product_repository.dart';

part 'themsanpham_event.dart';
part 'themsanpham_state.dart';

class ThemsanphamBloc extends Bloc<ThemsanphamEvent, ThemsanphamState> {
  ThemsanphamBloc({required ProductRepository productRepository}) : _productRepository =  productRepository,super(const ThemsanphamState()) {

    // đăng kí sự kiện
    on<CreateNameProduct>(_onCreateNameProduct);
    on<CreateQuantityProduct>(_onCreateQuantityProduct);
    on<CreatePriceProduct>(_onCreatePriceProduct);
    on<CreateSupplierNameProduct>(_onCreateSupplierNameProduct);
    on<CreatePhoneSupplierProduct>(_onCreatePhoneSupplierProduct);
    on<CreateNoteProduct>(_onCreateNoteProduct);
    on<CreateProductRequested>(_onCreateProduct);
  }

  // truyền repo từ bên ngoài vào
  final ProductRepository _productRepository;


//=====================================================================
  // truyền vào state

  void _onCreateNameProduct(CreateNameProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(ten: event.ten,)
    );
  }

  void _onCreateQuantityProduct(CreateQuantityProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(soluong: event.soluong,)
    );
  }

  void _onCreatePriceProduct(CreatePriceProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(giasanpham: event.giasanpham,)
    );
  }

  void _onCreateSupplierNameProduct(CreateSupplierNameProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(tennhacungcap: event.tennhacungcap,)
    );
  }

  void _onCreatePhoneSupplierProduct(CreatePhoneSupplierProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(sdtnhacungcap: event.sdtnhacungcap,)
    );
  }

  void _onCreateNoteProduct(CreateNoteProduct event,
      Emitter<ThemsanphamState> emit) {
    emit(
        state.copyWith(chuthich: event.chuthich,)
    );
  }

  // xử lí tạo 1 sản phẩm
  Future<void> _onCreateProduct(CreateProductRequested event, Emitter<ThemsanphamState> emit) async {
    try {
      emit(
          state.copyWith(statusSubmit: CreateStatus.loading)
      );
      await _productRepository.createProductToFirebase(createProduct: CreateProduct(
        nameProduct:  state.ten,
        quantityProduct: state.soluong,
        priceProduct: state.giasanpham,
        supplierName: state.tennhacungcap,
        phoneSupplier: state.sdtnhacungcap,
        noteProduct: state.chuthich
      ));
      if(isClosed) return;
      emit(
          state.copyWith(statusSubmit: CreateStatus.success)
      );
    } catch (error) {
      log("feefes$error");
      if(isClosed) return;
      emit(
          state.copyWith(
              statusSubmit: CreateStatus.failure,
              error: error.toString()
          )
      );
    }

  }


}
