import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'giohang_event.dart';
part 'giohang_state.dart';

class GiohangBloc extends Bloc<GiohangEvent, GiohangState> {
  GiohangBloc() : super(GiohangState()) {

  }
}
