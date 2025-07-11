import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gio_hang_event.dart';
part 'gio_hang_state.dart';

class GioHangBloc extends Bloc<GioHangEvent, GioHangState> {
  GioHangBloc() : super(GioHangInitial()) {
    on<GioHangEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
