import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chi_tiet_hoa_don_event.dart';
part 'chi_tiet_hoa_don_state.dart';

class ChiTietHoaDonBloc extends Bloc<ChiTietHoaDonEvent, ChiTietHoaDonState> {
  ChiTietHoaDonBloc() : super(ChiTietHoaDonInitial()) {
    on<ChiTietHoaDonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
