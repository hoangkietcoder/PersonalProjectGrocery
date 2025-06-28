part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];

}

class ChangeTheme extends MainEvent{
  final bool isEnabled;

  const ChangeTheme(this.isEnabled);
  @override
  List<Object> get props => [isEnabled];
}
