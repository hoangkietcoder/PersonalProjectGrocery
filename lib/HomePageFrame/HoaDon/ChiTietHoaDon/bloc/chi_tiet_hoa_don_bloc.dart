import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personalprojectgrocery/HomePageFrame/HoaDon/HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';
import 'package:personalprojectgrocery/Repository/Bill/bill_repository.dart';

part 'chi_tiet_hoa_don_event.dart';
part 'chi_tiet_hoa_don_state.dart';

class ChiTietHoaDonBloc extends Bloc<ChiTietHoaDonEvent, ChiTietHoaDonState> {
  ChiTietHoaDonBloc({required BillRepository billRepo }) : billRepository = billRepo , super(ChiTietHoaDonState()) {


    // đăng kí sự kiện

    on<FetchChiTietHoaDonEvent>(_onFetchChiTietHoaDon);

  }

  // truyền repo từ ngoài vào
  final BillRepository billRepository;

  Future<void> _onFetchChiTietHoaDon(
      FetchChiTietHoaDonEvent event,
      Emitter<ChiTietHoaDonState> emit,
      ) async {
    await _loadChiTietHoaDon(event.idBill, emit);
  }


  /// ✅ HÀM LOGIC CHÍNH – có thể tái sử dụng trong các event khác
  Future<void> _loadChiTietHoaDon(String idBill, Emitter<ChiTietHoaDonState> emit) async {
    emit(state.copyWith(isloading: true, error: null));

    try {
      final bill = await billRepository.getBillById(idBill);
      emit(state.copyWith(modelChuathanhtoan: bill, isloading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isloading: false));
    }
  }


}
