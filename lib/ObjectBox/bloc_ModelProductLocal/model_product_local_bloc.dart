import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personalprojectgrocery/main.dart';

import '../../Repository/DataLocal/data_local_repository.dart';
import '../model/ModelProductLocal.dart';

part 'model_product_local_event.dart';
part 'model_product_local_state.dart';

class ModelProductLocalBloc extends Bloc<ModelProductLocalEvent, ModelProductLocalState> {
  ModelProductLocalBloc({required DataLocalRepository DataLocalRepository})
      : dataLocalRepository = DataLocalRepository,
        super(ModelProductLocalState()) {
    // đăng kí sự kiện
    on<SaveProductLocalEvent>(_onSaveProductLocal);
    on<DeleteLocalProductEvent>(_deleteSaveProductLocal);
    on<DeleteAllLocalProductCartEvent>(_deleteAllProductsLocal);
    on<RefreshListProDuctLocalCartEvent>(
        _getAllProductsLocal); // refresh lại danh sách
    on<UpdateQuantityProductLocalEvent>(_updateQuantityProductLocal);

    // lắng nghe sự kiện () xử lí thêm tổng tiền khi thêm sản phẩm vào danh sách
    _productLocalSubscription =
        dataLocalRepository.getAllProducts().listen((productLocals) {
          final int totalPrice = productLocals.fold(0, (sum, item){
            final quantity = int.tryParse(item.quantityProduct) ?? 0;
            final price = int.tryParse(item.priceProduct) ?? 0;
            return sum + (quantity * price);
          });
          emit(state.copyWith(
              totalPriceInCart: totalPrice,
              lstModelProductLocal: productLocals));
        });
  }


  // truyền repo từ bên ngoài vào
  final DataLocalRepository dataLocalRepository;
  late final StreamSubscription<
      List<ModelProductLocal>> _productLocalSubscription; // thêm biến stream

  // xử lí lưu dữ liệu dưới local
  Future<void> _onSaveProductLocal(SaveProductLocalEvent event,
      Emitter<ModelProductLocalState> emit) async {
    try {
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.loading)
      );
      await dataLocalRepository.saveProduct(event.product);
      if (isClosed) return;
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.success,
      ));
    } catch (error) {
      if (isClosed) return;
      emit(
          state.copyWith(
              statusSaveDataLocal: StatusSaveDataLocal.failure,
              error: error.toString()
          )
      );
    }
  }

  Future<void> _deleteAllProductsLocal(DeleteAllLocalProductCartEvent event,
      Emitter<ModelProductLocalState> emit) async {
    try {
      emit(
          state.copyWith(statusDeleteDataLocal: StatusDeleteDataLocal.loading));
      // Gọi repo xóa dữ liệu
      await dataLocalRepository.deleteAllProductsLocal();
      //  KHÔNG cần getAllProducts() nữa
      //  Stream sẽ tự update lại danh sách → emit tự động
      emit(
          state.copyWith(statusDeleteDataLocal: StatusDeleteDataLocal.success));
    } catch (error) {
      emit(state.copyWith(
          error: error.toString(),
          statusDeleteDataLocal: StatusDeleteDataLocal.failure));
    }
  }



  //=========================== xử lí xóa tất cả sản phẩm và refesh lại danh sách ( dùng stream tự động cập nhật )
  Future<void> _getAllProductsLocal(RefreshListProDuctLocalCartEvent event,
      Emitter<ModelProductLocalState> emit,) {
    return emit.onEach(dataLocalRepository.getAllProducts(),
      onData: (data) async {
        return emit(state.copyWith(
            statusGetDataLocal: StatusGetDataLocal.success,
            lstModelProductLocal: data
        ));
      },
      onError: (error, strace) {
        return emit(state.copyWith(
            statusGetDataLocal: StatusGetDataLocal.failure,
            error: "Lấy danh sách thất bại!"
        ));
      },
    );
  }


  //============== xử lí xóa dữ liệu 1 sản phẩm trong giỏ hàng dưới local
  Future<void> _deleteSaveProductLocal(DeleteLocalProductEvent event,
      Emitter<ModelProductLocalState> emit) async {
    try {
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.loading));
      await dataLocalRepository.deleteProduct(event.id);
      if (isClosed) return;
      emit(state.copyWith(statusSaveDataLocal: StatusSaveDataLocal.success));
    } catch (error) {
      if (isClosed) return;
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
  Future<void> _updateQuantityProductLocal(
      UpdateQuantityProductLocalEvent event,
      Emitter<ModelProductLocalState> emit) async {
    try {
      // Lấy số lượng hiện tại từ sản phẩm, nếu lỗi thì mặc định là 0
      final currentQty = int.tryParse(event.product.quantityProduct) ?? 0;

      // Tính số lượng mới bằng cách cộng thêm change (+1 hoặc -1)
      final updatedQty = currentQty + event.change;
      print('Updated Qty: $updatedQty');


      // Kiểm tra số lượng mới có hợp lệ không
      if (updatedQty <= 0) {
        // Xóa sản phẩm nếu số lượng <= 0
        await dataLocalRepository.deleteProduct(event.product.id);
      } else {
        // Cập nhật sản phẩm với số lượng mới
        final updatedProduct = event.product.copyWith(
          quantityProduct: updatedQty.toString(),
        );

        await dataLocalRepository.saveProduct(updatedProduct);
      }
      // Reload danh sách
      final newList = await dataLocalRepository
          .getAllProducts()
          .first;
      emit(state.copyWith(
        lstModelProductLocal: newList,
        statusGetDataLocal: StatusGetDataLocal.success,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }




  @override
  Future<void> close() {
    _productLocalSubscription.cancel();
    return super.close();
  }

}

