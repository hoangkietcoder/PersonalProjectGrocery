import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Repository/Bill/bill_repository.dart';
import '../../../../tranformer.dart';
import '../Model/model_chuathanhtoan.dart';

part 'chua_thanh_toan_event.dart';
part 'chua_thanh_toan_state.dart';

class ChuaThanhToanBloc extends Bloc<ChuaThanhToanEvent, ChuaThanhToanState> {
  ChuaThanhToanBloc({required BillRepository billrepo}) : _billRepository =  billrepo , super(ChuaThanhToanState()) {
    // < tên sự kiện > ( phương thức )
    on<CreateBillChange>(_onSubscriptionRequested);
    on<SearchBillChuaThanhToanEventChange>(_onSearchProductChanged, transformer: debounce(Duration(milliseconds: 500)));
    on<DeleteBillChuaThanhToan>(_onDeleteBill);

    // lắng nghe sự kiện ( khi có sự kiện thì auto cập nhật - cho chức năng thêm hóa đơn)
    // _billSubscription = _billRepository.createBill.listen((data) => add(CreateBillChange(data)));
  }

  final BillRepository _billRepository;
  // khởi tạo stream truyền vào là 1 lớp Model ( để lúc thêm sản phẩm xong thì trang chưa thanh toán tự fetch lại dữ liệu )
  // late final StreamSubscription<List<ModelChuathanhtoan>> _billSubscription;
// tự động dùng khi bấm nút thêm sản phẩm ( tự fetch )
  Future<void> _onSubscriptionRequested(
      CreateBillChange event,
      Emitter<ChuaThanhToanState> emit,
      ) {
    return emit.onEach(
      _billRepository.createBill,
      onData: (data) async {
          return emit(state.copyWith(
              lstBillChuaThanhToan: data,
              statusBill: StatusChuaThanhToan.successful
          ));
      },
      onError: (error, stackTrace){
        log("error $error, stack $stackTrace");
        log("asdadsadasdsadsa ");
        return emit(state.copyWith(
            statusBill: StatusChuaThanhToan.failure
        ));

      },
    );
  }


  // void _onBillChange(
  //     CreateBillChange event,
  //     Emitter<ChuaThanhToanState> emit,
  //     ){
  //   return emit(state.copyWith(
  //       lstBillChuaThanhToan: event.lstBillChuaThanhToan,
  //       statusBill: StatusChuaThanhToan.successful
  //   ));
  // }


  // xử lí thanh tìm kiếm hóa đơn chưa thánh toán ( theo tên hóa đơn )
  Future<void> _onSearchProductChanged(
      SearchBillChuaThanhToanEventChange event,
      Emitter<ChuaThanhToanState> emit,
      ) async{
    try{
      emit(state.copyWith(statusBill: StatusChuaThanhToan.initial));
      final data = await _billRepository.searchBillChuaThanhToanByName(event.query);
      return emit(state.copyWith(
          lstBillChuaThanhToan: data,
          statusBill: StatusChuaThanhToan.successful
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lstBillChuaThanhToan: [],
          statusBill: StatusChuaThanhToan.failure
      ));
    }

  }


  // xử lí xóa 1 hóa đơn chưa thanh toán
  Future<void> _onDeleteBill(DeleteBillChuaThanhToan event, Emitter<ChuaThanhToanState> emit) async {
    try {
      emit(state.copyWith(deleteProduct: DetailStatusInitial.loading));
      final newList = List<ModelChuathanhtoan>.of(state.lstBillChuaThanhToan);
      await _billRepository.deleteBillById(event.deleteBillChuaThanhToanId);
      newList.removeAt(event.index);
      emit(state.copyWith(
        deleteProduct: DetailStatusInitial.successful,
        lstBillChuaThanhToan: newList,
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
