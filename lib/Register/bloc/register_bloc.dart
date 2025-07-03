import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Config/exception.dart';
import '../../Models/Register/register_user.dart';
import '../../Repository/Authentication/authentication_repository.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthenticationRepository authen}): _authenticationRepository = authen,
        super(const RegisterState()) {
    // đăng kí sự kiện
    on<HidePassword>(_onPassword);
    on<RegisterNameAccount>(_onRegisterNameAccount);
    on<RegisterPhoneNumberAccount>(_onRegisterPhoneNumberAccount);
    on<RegisterEmailAccount>(_onRegisterEmailAccount);
    on<RegisterPasswordAccount>(_onRegisterPasswordAccount);
    on<RegisterAccountRequested>(_onRegisterAccount);
  }

  // truyền repo từ bên ngoài vào
  final AuthenticationRepository _authenticationRepository;



  // Tất cả phương thức để xử lí
  void _onPassword(HidePassword event, Emitter<RegisterState> emit,) {
    emit(state.copyWith(isHiddenPassword: !state.isHiddenPassword));
  }

  void _onRegisterNameAccount(RegisterNameAccount event, Emitter<RegisterState> emit) {
    emit(
        state.copyWith(
          Name: event.name,
        )
    );
  }

  void _onRegisterPhoneNumberAccount(RegisterPhoneNumberAccount event, Emitter<RegisterState> emit) {
    emit(
        state.copyWith(
          phoneNumber: event.phoneNumber,
        )
    );
  }

  void _onRegisterEmailAccount(RegisterEmailAccount event, Emitter<RegisterState> emit) {
    emit(state.copyWith(Email: event.email,)
    );
  }

  void _onRegisterPasswordAccount(RegisterPasswordAccount event,
      Emitter<RegisterState> emit) {
    emit(
        state.copyWith(passwordResgister: event.passwordRegister,)
    );
  }

//=====================================================================================

  // xử lí đăng kí
  Future<void> _onRegisterAccount(RegisterAccountRequested event, Emitter<RegisterState> emit) async {
      try {
        emit(
          state.copyWith(statusSubmit: RegisterStatus.loading)
        );
        await _authenticationRepository.signUp(
          registerUser: RegisterUser(
              name: state.name,
              phoneNumber: state.phoneNumber,
              email: state.email,
              password: state.passwordResgister,
          )
        );
        print("feahfehsfhes${state.phoneNumber}");
        emit(
          state.copyWith(statusSubmit: RegisterStatus.success)
        );


      }on SignUpWithEmailAndPasswordFailure catch (e) {
        emit(
          state.copyWith(
            error: e.message,
            statusSubmit: RegisterStatus.failure,
          ),
        );
      } catch (error) {
        if(isClosed) return;
        emit(
          state.copyWith(
            statusSubmit: RegisterStatus.failure,
            error: error.toString(),
          )
        );
      }

  }



}
