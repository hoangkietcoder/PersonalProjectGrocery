import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/Product/detail_product.dart';
import '../../../../Models/Product/getData_ProductFromFirebase.dart';
import '../../../../Repository/Firebase_Database/Product/product_repository.dart';
part 'chitietsanpham_event.dart';
part 'chitietsanpham_state.dart';

class ChitietsanphamBloc extends Bloc<ChitietsanphamEvent, ChitietsanphamState> {
  ChitietsanphamBloc({required ProductRepository producRepo, }) : productRepository =producRepo ,super(ChitietsanphamState()) {

    on<DetailProductEventChange>(_onDetailProduct);
    on<DeleteDetailProduct>(_onDeleteProduct);


  }

  // truyền repo từ bên ngoài vào
  final ProductRepository productRepository;






  // xử lí chi tiết 1 sản phẩm
  Future<void> _onDetailProduct(DetailProductEventChange event, Emitter<ChitietsanphamState> emit) async {
    try {
      emit(
          state.copyWith(detailStatus: DetailStatus.loading)
      );
      final data = await productRepository.getProductById(event.productId);
      if(isClosed) return;
      emit(
          state.copyWith(
              detailProduct: data,
              detailStatusInitial: DetailStatusInitial.successful)
      );
    } catch (error) {
      log("feefes$error");
      if(isClosed) return;
      emit(
          state.copyWith(
              detailStatusInitial: DetailStatusInitial.failure,
              error: error.toString()
          )
      );
    }

  }


  Future<void> _onDeleteProduct(DeleteDetailProduct event, Emitter<ChitietsanphamState> emit) async {
    try {
      emit(state.copyWith(deleteProduct: DetailStatusInitial.loading));
      final newList = List<getDataProduct>.of(state.lstData);
      await productRepository.deleteProductById(event.deleteProductId);
      newList.removeAt(event.index);
      emit(state.copyWith(
        deleteProduct: DetailStatusInitial.successful,
        lstData: newList,
      ));
    } catch (error) {
      if (isClosed) return;
      emit(state.copyWith(
        deleteProduct: DetailStatusInitial.failure,
        error: error.toString(),
      ));
    }
  }



}






