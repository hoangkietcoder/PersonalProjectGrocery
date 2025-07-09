part of 'thongtin_bloc.dart';

sealed class ThongtinEvent extends Equatable {
  const ThongtinEvent();
}


/// Load dữ liệu User từ Firebase
class LoadUserInfoEventChange extends ThongtinEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}