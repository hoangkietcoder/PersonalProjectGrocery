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
    on<PayBillChuaThanhToan>(_onPayBill);


    //  Reset status sau khi hiển thị SnackBar
    on<resetStatusNotification>((event, emit) {
      emit(state.copyWith(
        statusSubmitThanhToan: StatusSubmitThanhToan.initial,
        statusBillType: null,
      ));
    });


  }

  final BillRepository _billRepository;
  // khởi tạo stream truyền vào là 1 lớp Model ( để lúc thêm sản phẩm xong thì trang chưa thanh toán tự fetch lại dữ liệu )
  // late final StreamSubscription<List<ModelChuathanhtoan>> _billSubscription;

// tự động dùng khi bấm nút thêm sản phẩm ( tự fetch )
  Future<void> _onSubscriptionRequested(CreateBillChange event, Emitter<ChuaThanhToanState> emit,
      ) {
    return emit.onEach(_billRepository.createBill,
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
      emit(state.copyWith(deleteStatusBill: DeleteStatusBill.loading));
      final newList = List<ModelChuathanhtoan>.of(state.lstBillChuaThanhToan);
      await _billRepository.deleteBillById(event.deleteBillChuaThanhToanId);
      if (event.index < newList.length) {
        newList.removeAt(event.index);
      }
      emit(state.copyWith(
        deleteStatusBill: DeleteStatusBill.successful,
        lstBillChuaThanhToan: newList,
        statusBillType: StatusBillType.delete,
        statusSubmitThanhToan: StatusSubmitThanhToan.initial, //  reset lại ( để không trùng với thanh toán ) vì bấm xóa là 2 thông báo xóa với thanh toán cùng xảy ra
      ));
      print("✅ Bloc: Đã xóa bill ở index ${event.index}");
    } catch (error) {
      if (isClosed) return;
      emit(state.copyWith(
        deleteStatusBill: DeleteStatusBill.failure,
        error: error.toString(),
      ));
    }
  }


  // xử lí nút thanh toán ở trang chưa thanh toán
  Future<void> _onPayBill(
      PayBillChuaThanhToan event,
      Emitter<ChuaThanhToanState> emit,
      ) async {
    try {
      await _billRepository.updateBillDaThanhToan(doc: event.billId);
      // Không cần cập nhật lại danh sách ở đây vì stream sẽ tự động loại khỏi status = "0"
      // ✅ emit trạng thái thành công và actionType là "pay"
      emit(state.copyWith(
        statusSubmitThanhToan: StatusSubmitThanhToan.successful,
        statusBillType: StatusBillType.submitPay,
      ));
    } catch (e) {
      emit(state.copyWith(
        deleteStatusBill: DeleteStatusBill.failure,
        error: e.toString(),
      ));
    }
  }

  // xử lí sau khi thanh toán mỗi lần thành công sẽ reset lại trạng thái




}
