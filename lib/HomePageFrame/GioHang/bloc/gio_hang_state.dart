part of 'gio_hang_bloc.dart';

sealed class GioHangState extends Equatable {
  const GioHangState();
}

final class GioHangInitial extends GioHangState {
  @override
  List<Object> get props => [];
}
