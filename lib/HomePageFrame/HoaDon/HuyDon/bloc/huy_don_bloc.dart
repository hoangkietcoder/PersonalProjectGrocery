import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Constant/enum.dart';
import '../../../../Repository/Bill/bill_repository.dart';
import '../../../../tranformer.dart';
import '../../HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';

part 'huy_don_event.dart';
part 'huy_don_state.dart';

class HuyDonBloc extends Bloc<HuyDonEvent, HuyDonState> {
  HuyDonBloc({required BillRepository billRepository}) : _billRepository =  billRepository, super(HuyDonState()) {

    // đăng kí sự kiện
    on<HuyDonSubscriptionRequested>(_onSubscriptionRequested);
    on<SearchBillDaHuyEventChange>(_onSearchBillDaThanhToanChanged, transformer: debounce(Duration(milliseconds: 500)),);
  }

  final  BillRepository _billRepository;



  // xử lý lấy dữ liệu đã hủy đơn về
  Future<void> _onSubscriptionRequested(HuyDonSubscriptionRequested event, Emitter<HuyDonState> emit,
      ) {
    return emit.onEach(_billRepository.getBillHuyDon,
      onData: (data) async {
        print("📥 Đã nhận được ${data.length} đơn huỷ từ Firebase");
        return emit(state.copyWith(
            lsBillDaHuy: data,
            statusBillDaHuy: StatusBillDaHuy.successful,
        ));
      },
      onError: addError,
    );
  }

  // xử lí thanh tìm kiếm hóa đơn đã thánh toán ( theo tên hóa đơn )
  Future<void> _onSearchBillDaThanhToanChanged(
      SearchBillDaHuyEventChange event,
      Emitter<HuyDonState> emit,
      ) async{
    try{
      emit(state.copyWith(statusBillSearch: StatusBillSearch.loading));
      final data = await _billRepository.searchHuyBillByName(event.query);
      return emit(state.copyWith(
          lsBillDaHuy: data,
          statusBillSearch: StatusBillSearch.successful
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lsBillDaHuy: [],
          statusBillSearch: StatusBillSearch.failure
      ));
    }
  }

}
