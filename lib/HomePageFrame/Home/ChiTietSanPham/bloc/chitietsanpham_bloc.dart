import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Models/Product/detail_product.dart';
import '../../../../Models/Product/getData_ProductFromFirebase.dart';
import '../../../../Repository/Firebase_Database/Product/product_repository.dart';
part 'chitietsanpham_event.dart';
part 'chitietsanpham_state.dart';

class ChitietsanphamBloc extends Bloc<ChitietsanphamEvent, ChitietsanphamState> {
  ChitietsanphamBloc({required ProductRepository producRepo, }) : productRepository =producRepo ,super(ChitietsanphamState()) {

    on<DetailProductEventChange>(_onDetailProduct);
    on<DeleteDetailProduct>(_onDeleteProduct);
    on<UploadImageEvent>(_onUploadImage);


  }

  // truyền repo từ bên ngoài vào
  final ProductRepository productRepository;
  final ImagePicker _picker = ImagePicker();





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

  // xóa sản phẩm
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

  // upload ảnh
  Future<void> _onUploadImage(
      UploadImageEvent event,
      Emitter<ChitietsanphamState> emit,
      ) async {
    try {
      emit(state.copyWith(imageStatus: ImageStatus.uploading));

      // ✅ Upload ảnh lên Firebase Storage
      final imageUrl = await productRepository.uploadProductImage(
        event.imageFile,
        event.ProductId,
      );

      // ✅ Lưu URL vào Firestore
      await productRepository.saveImageUrlToFirestore(
        productId: event.ProductId,
        imageUrl: imageUrl,
      );

      // ✅ Cập nhật lại state.detailProduct.img_url
      final updatedProduct = state.detailProduct?.copyWith(img_url: imageUrl);

      emit(state.copyWith(
        detailProduct: updatedProduct,
        imageStatus: ImageStatus.successful,
        message: "Tải ảnh thành công",
      ));



    } catch (e) {
      emit(state.copyWith(
        imageStatus: ImageStatus.failure,
        error: 'Lỗi upload: $e',
      ));
    }
  }





}






