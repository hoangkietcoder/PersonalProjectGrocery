import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Repository/Authentication/authentication_repository.dart';


part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LogoutState());

  final AuthenticationRepository _authenticationRepository;


  Future<void> logOut() async {
    try {
      emit(state.copyWith(statusLogout: StatusInfo.isProccessing));
      await _authenticationRepository.logOut();

    } catch (error) {
      if (isClosed) return;
      emit(state.copyWith(
          statusLogout: StatusInfo.failure, error: error.toString()));
    }
  }
}
