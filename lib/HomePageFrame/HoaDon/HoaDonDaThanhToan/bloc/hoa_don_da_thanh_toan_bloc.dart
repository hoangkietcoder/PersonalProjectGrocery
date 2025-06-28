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
    on<SubmitHoaDonDaThanhToan>(_onSubmitPay);
    on<SearchBillDaThanhToanEventChange>(_onSearchProductChanged, transformer: debounce(Duration(milliseconds: 500)));

  }

  final BillRepository _billRepository;

  Future<void> _onSubscriptionRequested(
      HoaDonDaThanhToanSubscriptionRequested event,
      Emitter<HoaDonDaThanhToanState> emit,
      ) {
    return emit.onEach(
      _billRepository.billDaThanhToan,
      onData: (data) async {
        return emit(state.copyWith(
            lsBillDaThanhToan: data,
            statusInitial: StatusInitial.success, statusBill: null
        ));
      },
      onError: addError,
    );
  }

  Future<void> _onSubmitPay(
      SubmitHoaDonDaThanhToan event,
      Emitter<HoaDonDaThanhToanState> emit,
      ) async{
    try{
      emit(state.copyWith(statusThanhToan: StatusSubmit.isProcessing, statusBill: null));
      await _billRepository.updateBillDaThanhToan(doc: event.modelChuathanhtoan.idDocBill);
      if(isClosed) return;
      return emit(state.copyWith(
          statusThanhToan: StatusSubmit.success,
          msg: 'Thanh toán thành công', statusBill: null
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          statusThanhToan: StatusSubmit.failure,
          msg: error.toString(), statusBill: null
      ));
    }

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
  Future<void> _onSearchProductChanged(
      SearchBillDaThanhToanEventChange event,
      Emitter<HoaDonDaThanhToanState> emit,
      ) async{
    try{
      emit(state.copyWith(statusBill: StatusInitial.initial));
      final data = await _billRepository.searchBillDaThanhToanByName(event.query);
      return emit(state.copyWith(
          lsBillDaThanhToan: data,
          statusBill: StatusInitial.success
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lsBillDaThanhToan: [],
          statusBill: StatusInitial.failure
      ));
    }

  }

}
