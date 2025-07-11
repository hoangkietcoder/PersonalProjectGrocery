import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shared_preference_event.dart';
part 'shared_preference_state.dart';

class SharedPreferenceBloc extends Bloc<SharedPreferenceEvent, SharedPreferenceState> {
  SharedPreferenceBloc() : super(SharedPreferenceState()) {


    // đăng kí sự kiện
  }
}
