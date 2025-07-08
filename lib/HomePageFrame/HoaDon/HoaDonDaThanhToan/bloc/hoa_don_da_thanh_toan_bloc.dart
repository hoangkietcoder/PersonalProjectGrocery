import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Constant/enum.dart';
import '../../../../Repository/Bill/bill_repository.dart';
import '../../../../tranformer.dart';
import '../../HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';

part 'hoa_don_da_thanh_toan_event.dart';
part 'hoa_don_da_thanh_toan_state.dart';

class HoaDonDaThanhToanBloc extends Bloc<HoaDonDaThanhToanEvent, HoaDonDaThanhToanState> {
  HoaDonDaThanhToanBloc({required BillRepository billRepository}) :
        _billRepository = billRepository,
        super(HoaDonDaThanhToanState()) {
    on<HoaDonDaThanhToanSubscriptionRequested>(_onSubscriptionRequested);
    on<SearchBillDaThanhToanEventChange>(_onSearchBillDaThanhToanChanged, transformer: debounce(Duration(milliseconds: 500)));
    on<DeleteBillDaThanhToan>(_onDeleteBill);


    //  Reset status sau khi hiển thị SnackBar
    on<resetStatusDeleteNotification>((event, emit) {
      emit(state.copyWith(
        statusSubmitDeleteBillDaThanhToan: StatusSubmitDeleteBillDaThanhToan.initial,
        statusBill: null,
      ));
    });
  }

  final BillRepository _billRepository;


  // xử lý lấy dữ liệu đã thanh toán về
  Future<void> _onSubscriptionRequested(
      HoaDonDaThanhToanSubscriptionRequested event,
      Emitter<HoaDonDaThanhToanState> emit,
      ) {
    return emit.onEach(_billRepository.billDaThanhToan,
      onData: (data) async {
        return emit(state.copyWith(
            lsBillDaThanhToan: data,
            statusInitial: StatusInitial.success, statusBill: null
        ));
      },
      onError: addError,
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


  // xử lí thanh tìm kiếm hóa đơn đã thánh toán ( theo tên hóa đơn )
  Future<void> _onSearchBillDaThanhToanChanged(
      SearchBillDaThanhToanEventChange event,
      Emitter<HoaDonDaThanhToanState> emit,
      ) async{
    try{
      emit(state.copyWith(statusBillSearchDaThanhToan: StatusBillSearchDaThanhToan.loading, statusBill: null));
      final data = await _billRepository.searchBillDaThanhToanByName(event.query);
      return emit(state.copyWith(
          lsBillDaThanhToan: data,
        statusBillSearchDaThanhToan: StatusBillSearchDaThanhToan.successful, statusBill: null,
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lsBillDaThanhToan: [],
          statusBillSearchDaThanhToan: StatusBillSearchDaThanhToan.failure,
          statusBill: null,
      ));
    }
  }

  // xử lí xóa trong trang đã thanh toán
  Future<void> _onDeleteBill(DeleteBillDaThanhToan event, Emitter<HoaDonDaThanhToanState> emit,) async {
    try {
      await _billRepository.deleteBillDaThanhToan(doc: event.billId);
      // Không cần cập nhật lại danh sách ở đây vì stream sẽ tự động loại khỏi status = "0"
      // ✅ emit trạng thái thành công và actionType là "pay"
      emit(state.copyWith(
        statusSubmitDeleteBillDaThanhToan: StatusSubmitDeleteBillDaThanhToan.successful, statusBill: null,
      ));

    } catch (e) {
      emit(state.copyWith(
        statusSubmitDeleteBillDaThanhToan: StatusSubmitDeleteBillDaThanhToan.failure, statusBill: null,
        msg: e.toString(),
      ));
    }
  }

}
