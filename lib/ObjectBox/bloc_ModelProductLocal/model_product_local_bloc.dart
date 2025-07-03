import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personalprojectgrocery/main.dart';

import '../../Repository/DataLocal/data_local_repository.dart';
import '../model/ModelProductLocal.dart';

part 'model_product_local_event.dart';
part 'model_product_local_state.dart';

class ModelProductLocalBloc extends Bloc<ModelProductLocalEvent, ModelProductLocalState> {
  ModelProductLocalBloc({required DataLocalRepository DataLocalRepository}) : dataLocalRepository = DataLocalRepository,
        super(ModelProductLocalState()) {

    // đăng kí sự kiện
    on<SaveProductLocalEvent>(_onSaveProductLocal);
    on<DeleteLocalProductEvent>(_deleteSaveProductLocal);
    on<DeleteAllLocalProductCartEvent>(_deleteAllProductsLocal);
    on<RefreshListProDuctLocalCartEvent>(_getAllProductsLocal); // refresh lại danh sách
    on<UpdateQuantityProductLocalEvent>(_updateQuantityProductLocal);

  }


  // truyền repo từ bên ngoài vào
  final DataLocalRepository dataLocalRepository;


  // xử lí lưu dữ liệu dưới local
  Future<void> _onSaveProductLocal(SaveProductLocalEvent event, Emitter<ModelProductLocalState> emit) async {
    try {
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.loading)
      );
      await dataLocalRepository.saveProduct(event.product);

      if(isClosed) return;
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.success
      ));
    }catch (error) {
      if(isClosed) return;
      emit(
          state.copyWith(
              statusSaveDataLocal: StatusSaveDataLocal.failure,
              error: error.toString()
          )
      );
    }
  }

  Future<void> _deleteAllProductsLocal(DeleteAllLocalProductCartEvent event, Emitter<ModelProductLocalState> emit) async{
        try{
          emit(state.copyWith(statusDeleteDataLocal: StatusDeleteDataLocal.loading));
          // Gọi repo xóa dữ liệu
          await dataLocalRepository.deleteAllProductsLocal();
        }catch(error) {
          emit(state.copyWith(
              error: error.toString(),
              statusDeleteDataLocal: StatusDeleteDataLocal.failure));
        }
  }

  //=========================== xử lí xóa tất cả sản phẩm và refesh lại danh sách ( dùng stream tự động cập nhật )
  Future<void> _getAllProductsLocal(RefreshListProDuctLocalCartEvent event, Emitter<ModelProductLocalState> emit,)
    {
      return emit.onEach(dataLocalRepository.getAllProducts(),
      onData: (data) async {
        return emit(state.copyWith(
          statusGetDataLocal: StatusGetDataLocal.success,
          lstModelProductLocal: data
        ));
      },
      onError: (error, strace){
        return emit(state.copyWith(
            statusGetDataLocal: StatusGetDataLocal.failure,
            error: "Lấy danh sách thất bại!"
        ));
      },
    );
  }

  //============== xử lí xóa dữ liệu 1 sản phẩm trong giỏ hàng dưới local
  Future<void> _deleteSaveProductLocal(DeleteLocalProductEvent event, Emitter<ModelProductLocalState> emit) async {
    try {
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.loading));
      await dataLocalRepository.deleteProduct(event.id);
      if(isClosed) return;
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.success));
    }catch (error) {
      if(isClosed) return;
      emit(
          state.copyWith(
              statusSaveDataLocal: StatusSaveDataLocal.failure,
              error: error.toString()
          )
      );
    }
  }


  // xử lí xóa tất cả sản phẩm trong giỏ hàng dưới local
  // Future<void> _deleteAllProductLocalCart(DeleteAllLocalProductCartEvent event, Emitter<ModelProductLocalState> emit) async {
  //   try {
  //     emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.loading)
  //     );
  //     // Xóa tất cả
  //     await dataLocalRepository.deleteAllProductsLocal();
  //     // Sau khi xóa, lấy lại danh sách rỗng
  //     final getAfterDelete = await dataLocalRepository.getAllProducts();
  //     print("hdjawhdjawdhawdhk ${getAfterDelete}" );
  //     if(isClosed) return;
  //     emit(state.copyWith(
  //         lstModelProductLocal: getAfterDelete,
  //         statusSaveDataLocal: StatusSaveDataLocal.success));
  //   }catch (error) {
  //     if(isClosed) return;
  //     emit(
  //         state.copyWith(
  //             statusSaveDataLocal: StatusSaveDataLocal.failure,
  //             error: error.toString()
  //         )
  //     );
  //   }
  // }


  // ========================= xử lí nút thêm bớt số lượng
  Future<void> _updateQuantityProductLocal(UpdateQuantityProductLocalEvent event, Emitter<ModelProductLocalState> emit) async {
    try {
      final currentQuantity = int.tryParse(event.product.quantityProduct) ?? 0; // ép kiểu về int
      final updatedQuantity = currentQuantity + event.change ;
      if(updatedQuantity <= 0 ){
        // Nếu nhỏ hơn 1 thì xóa sản phẩm khỏi local
        dataLocalRepository.deleteProduct(event.product.id);
      }
     else {
        final updatedProduct = event.product.copyWith(quantityProduct: updatedQuantity.toString()); // Chuyển int -> String khi lưu lại
        dataLocalRepository.saveProduct(updatedProduct); // Ghi lại vào ObjectBox
        // ✅ Luôn luôn gọi lại toàn bộ danh sách mới sau khi thao tác xong
        final newList = await dataLocalRepository.getAllProducts().first; // sẽ đợi giá trị đầu tiên của stream (thường là ngay lập tức), sau đó lấy List<ModelProductLocal> ra và gán vào state
        emit(state.copyWith(
          lstModelProductLocal: newList,
          statusGetDataLocal: StatusGetDataLocal.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

}

