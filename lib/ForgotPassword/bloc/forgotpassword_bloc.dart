import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../Config/exception.dart';
import '../../Repository/Authentication/authentication_repository.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {


  ForgotpasswordBloc({required AuthenticationRepository Authen}) :
        _authenticationRepository = Authen,
        super(const ForgotpasswordState()) {
    on<EmailForgotChange>(_onChangeEmail);
    on<ForgotPasswordRequested>(_onSubmit);
  }

  // truyền repo từ bên ngoài vào
  final AuthenticationRepository _authenticationRepository;


  // Tất cả phương thức để xử lí
  void _onChangeEmail(EmailForgotChange event, Emitter<ForgotpasswordState> emit){
    emit(
      state.copyWith(
        email: event.email
      )
    );
  }

  Future<void> _onSubmit(ForgotPasswordRequested event, Emitter<ForgotpasswordState> emit)  async{
    try{

      emit(
          state.copyWith(
              statusSubmit: StatusForgotPassword.loading
          )
      );

      await _authenticationRepository.resetPassword(
        email: state.email,
      );
      emit(
          state.copyWith(
              statusSubmit: StatusForgotPassword.success
          )
      );


    }on ResetPasswordFailure catch (e) {
      if(isClosed) return;
      emit(
        state.copyWith(
          error: e.message,
          statusSubmit: StatusForgotPassword.failure,
        ),
      );
    }catch(error){
      if(isClosed) return;
      log("error ${error.toString()}");
      emit(
          state.copyWith(
              statusSubmit: StatusForgotPassword.failure,
              error: error.toString()
          )
      );
    }
  }





}
