part of 'main_bloc.dart';



final class MainState extends Equatable {
  const MainState({
    this.statusTheme = false ,
  }
      );

  final bool statusTheme;

  MainState copyWith({
    bool? statusTheme,

  }) {
    return MainState(
        statusTheme: statusTheme ?? this.statusTheme,

    );
  }

  @override // code này dùng để kiểm tra state này với state khác ntn ( so sánh 2 object có khác gì nhau ko từ đó build )
  List<Object> get props => [
    statusTheme,
  ];
}
