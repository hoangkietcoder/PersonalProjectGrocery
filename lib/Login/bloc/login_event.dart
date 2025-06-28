part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class HidePasswordLogin extends LoginEvent {
  const HidePasswordLogin();
}

class PasswordLogin extends LoginEvent {
  const PasswordLogin(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class EmailLogin extends LoginEvent {
  const EmailLogin(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class SaveAccountLogin extends LoginEvent {
  const SaveAccountLogin();
}

class SubmitLogin extends LoginEvent {
  const SubmitLogin();
}
