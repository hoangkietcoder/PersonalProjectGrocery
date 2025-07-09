import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../../Repository/CapNhatThongTin/CapNhatThongTin_repository.dart';
import '../model/Model_CapNhatThongTin.dart';


part 'cap_nhat_thong_tin_event.dart';
part 'cap_nhat_thong_tin_state.dart';

class CapNhatThongTinBloc extends Bloc<CapNhatThongTinEvent, CapNhatThongTinState> {
  CapNhatThongTinBloc({required CapnhatthongtinRepository CapnhatRepo}) : _capnhatthongtinRepository = CapnhatRepo , super(CapNhatThongTinState.initial()) {


    /// đăng kí sự kiện

    on<LoadUserInfoEvent>(_onLoadThongTin);
    on<UpdateUserInfoEvent>(_onCapNhatThongTin);
    on<UploadImageEvent>(_onUploadImage);


  }
  // truyền FeedbackRepository
  final CapnhatthongtinRepository _capnhatthongtinRepository;


  /// Xử lý lấy dữ liệu từ Firestore
  Future<void> _onLoadThongTin(LoadUserInfoEvent event, Emitter<CapNhatThongTinState> emit,) async {
    emit(state.copyWith(statusLoadInfo: StatusLoadInfo.loading));
    try {
      final user = await _capnhatthongtinRepository.fetchUser();
      print('📦 Kết quả từ Firestore: $user');
      if (user != null) {
        emit(state.copyWith(
          model: user,
          statusLoadInfo: StatusLoadInfo.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(statusCapNhatInfo: StatusCapNhatInfo.failure));
    }
  }

  /// Xử lý cập nhật lại dữ liệu lên Firestore
  Future<void> _onCapNhatThongTin(UpdateUserInfoEvent event, Emitter<CapNhatThongTinState> emit,) async {
    emit(state.copyWith(statusCapNhatInfo: StatusCapNhatInfo.loading));
    try {
      final updatedModel = state.model.copyWith(
        name: event.name,
        phoneNumber: event.phoneNumber,
      );
      await _capnhatthongtinRepository.updateUser(updatedModel);
      // 🔁 Gọi lại LoadUserInfoEvent để load lại dữ liệu mới từ Firestore
      add(LoadUserInfoEvent());
      emit(state.copyWith(statusCapNhatInfo: StatusCapNhatInfo.success));
    } catch (e) {
      emit(state.copyWith(statusCapNhatInfo: StatusCapNhatInfo.failure));
    }
  }

  /// upload ảnh
  Future<void> _onUploadImage(UploadImageEvent event, Emitter<CapNhatThongTinState> emit,
      ) async {
    try {
      emit(state.copyWith(statusLoadImage: StatusLoadImage.loading));

      // ✅ Upload ảnh lên Firebase Storage
      final imageUrl = await _capnhatthongtinRepository.uploadProductImage(
        event.imageFile,
        event.ProductId,
      );

      // ✅ Lưu URL vào Firestore
      await _capnhatthongtinRepository.saveImageUrlToFirestore(
        productId: event.ProductId,
        imageUrl: imageUrl,
      );

      // ✅ Cập nhật lại state.detailProduct.img_url
      final updatedProduct = state.model?.copyWith(img_url_Info: imageUrl);

      emit(state.copyWith(
        model: updatedProduct,
        statusLoadImage: StatusLoadImage.success,
        error: "Tải ảnh thành công",
      ));

    } catch (e) {
      emit(state.copyWith(
        statusLoadImage: StatusLoadImage.failure,
        error: 'Lỗi upload: $e',
      ));
    }
  }
}
