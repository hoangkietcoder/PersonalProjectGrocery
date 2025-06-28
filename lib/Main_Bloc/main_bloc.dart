import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc()
      : super(const MainState()) {
    on<ChangeTheme>(_onChangeTheme); // đăng kí sự kiện bloc
  }

  void _onChangeTheme(
    // sự kiện bloc
    ChangeTheme event, // nhận 1 sự kiện ChangeTheme
    Emitter<MainState> emit,
  ) {
    emit(state.copyWith(statusTheme: !state.statusTheme));
  }
}
