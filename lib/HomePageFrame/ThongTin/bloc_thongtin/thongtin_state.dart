part of 'thongtin_bloc.dart';


class ThongtinState extends Equatable {

  const ThongtinState({
    required this.modelThongTin,
    this.error = "",
  });

  final ModelThongtin modelThongTin;
  final String error;



  factory ThongtinState.initial() {
    return ThongtinState(
      modelThongTin: ModelThongtin.empty,
    );
  }

  ThongtinState copyWith({
    ModelThongtin? modelThongTin,
    String? error,
  }) {
    return ThongtinState(
        modelThongTin: modelThongTin ?? this.modelThongTin,
        error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [modelThongTin,error];
}
