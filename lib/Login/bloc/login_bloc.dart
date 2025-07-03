import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Config/exception.dart';
import '../../Repository/Authentication/authentication_repository.dart';
import '../../Repository/Notification/notification_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required String email,
    required String password,
    required AuthenticationRepository authenticationRepository,
    required bool isSaveAccount,
    required NotificationRepository notificationRepository,
  }) :

        _authenticationRepository = authenticationRepository,
        _notificationRepository = notificationRepository,
        super(LoginState(email: email, password: password, isSaveAccount: isSaveAccount)) {

    on<HidePasswordLogin>(_onPassword);
    on<PasswordLogin>(_onChangePassword);
    on<EmailLogin>(_onChangeEmail);
    on<SaveAccountLogin>(_onChangeSaveAccount);
    on<SubmitLogin>(_onSubmit);
  }

  // truyền repo vào
  final AuthenticationRepository _authenticationRepository;
  final NotificationRepository _notificationRepository;


  void _onPassword(
      HidePasswordLogin event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(isHiddenPassword: !state.isHiddenPassword));
  }


  void _onChangePassword(
      PasswordLogin event,
      Emitter<LoginState> emit,
      ){
    emit(state.copyWith(password: event.password));

  }

  void _onChangeEmail(
      EmailLogin event,
      Emitter<LoginState> emit,
      ){
    emit(state.copyWith(email: event.email));
  }

  void _onChangeSaveAccount(
      SaveAccountLogin event,
      Emitter<LoginState> emit,
      ){
    emit(state.copyWith(isSaveAccount: !state.isSaveAccount));
  }

  Future<void> _onSubmit(SubmitLogin event, Emitter<LoginState> emit)  async{
    try{

      emit(
          state.copyWith(
              statusSubmit: LoginStatus.isProcessing
          )
      );

      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      // await _notificationRepository.scheduleDailyNotification(1, "hoh", "hihih", "", 14, 10);

    }on LogInWithEmailAndPasswordFailure catch (e) {
      if(isClosed) return;
      emit(
        state.copyWith(
          message: e.message,
          statusSubmit: LoginStatus.fail,
        ),
      );
    }catch(error){
      if(isClosed) return;
      log("error ${error.toString()}");
      emit(
          state.copyWith(
              statusSubmit: LoginStatus.fail,
              message: error.toString()
          )
      );
    }
  }


}
