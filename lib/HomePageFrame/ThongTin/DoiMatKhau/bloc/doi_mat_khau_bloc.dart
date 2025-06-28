import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Login/bloc/login_bloc.dart';

part 'doi_mat_khau_event.dart';
part 'doi_mat_khau_state.dart';

class DoiMatKhauBloc extends Bloc<DoiMatKhauEvent, DoiMatKhauState> {
  DoiMatKhauBloc() : super(DoiMatKhauState()) {
    on<DoiMatKhauEvent>((event, emit) {

      // <sự kiện > (phương thức )
      on<HidePasswordChange>(_onChangePassword);
      on<HideConfirmPasswordChange>(_onChangeConfirmPassword);
    });
  }


  void _onChangePassword (
      HidePasswordChange event,
      Emitter<DoiMatKhauState> emit
      ){
    emit(state.copyWith(isHiddenPassword: !state.isHiddenPassword));
  }

  void _onChangeConfirmPassword (
      HideConfirmPasswordChange event,
      Emitter<DoiMatKhauState> emit
      ){
    emit(state.copyWith(isConfirmHiddenPassword: !state.isConfirmHiddenPassword));
  }
}
