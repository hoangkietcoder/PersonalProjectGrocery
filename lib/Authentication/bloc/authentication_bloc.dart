import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Repository/Authentication/Model/auth_data.dart';
import '../../Repository/Authentication/authentication_repository.dart';
import '../../Repository/Login/Model/User.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository
  }) :
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);

    _userSubscription = _authenticationRepository.user.listen(
          (data) => add(_AuthenticationStatusChanged(data)),
    );
  }

  // truyền repo vào
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthData> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit,
      ){
    if(event.data.status == AuthenticationStatus.unauthenticated){
      return emit(const AuthenticationState.unauthenticated());
    }else{
      return emit(AuthenticationState.authenticated(event.data.user));
    }
  }



}

