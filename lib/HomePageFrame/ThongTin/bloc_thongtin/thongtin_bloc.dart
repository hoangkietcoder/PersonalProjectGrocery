import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Repository/ThongTin/thongtin_repository.dart';
import '../model_ThongTIn/Model_ThongTin.dart';

part 'thongtin_event.dart';
part 'thongtin_state.dart';

class ThongtinBloc extends Bloc<ThongtinEvent, ThongtinState> {
  ThongtinBloc({required ThongtinRepository thongtinRepo }) : thongtinRepository = thongtinRepo , super(ThongtinState(modelThongTin: ModelThongtin.empty)) {


    // đăng kí sự kiện
    on<LoadUserInfoEventChange>(_onLoadThongTin);
  }

  final ThongtinRepository thongtinRepository;


  /// Xử lý lấy dữ liệu từ Firestore
  Future<void> _onLoadThongTin(LoadUserInfoEventChange event, Emitter<ThongtinState> emit,) async {
    try {
      final user = await thongtinRepository.fetchUserInfo();
      print('📦 Kết quả từ Firestore: $user');
      if (user != null) {
        emit(state.copyWith(
          modelThongTin: user,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString()
      ));
    }
  }

}
