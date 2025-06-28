part of 'login_bloc.dart';

enum LoginStatus { unknown, isProcessing, success, fail }

class LoginState extends Equatable {
  const LoginState({
    this.isHiddenPassword = true,
    this.email = "",
    this.password = "",
    this.statusSubmit = LoginStatus.unknown,
    this.message = "",
    this.isSaveAccount = false
  });

  final bool isHiddenPassword;
  final String email, password;
  final LoginStatus statusSubmit;
  final String message;
  final bool isSaveAccount;

  LoginState copyWith({
    bool? isHiddenPassword,
    String? email,
    String? password,
    LoginStatus? statusSubmit,
    String? message,
    bool? isSaveAccount
  }) {
    return LoginState(
        isHiddenPassword: isHiddenPassword ?? this.isHiddenPassword,
        email: email ?? this.email,
        password: password ?? this.password,
        statusSubmit: statusSubmit ?? this.statusSubmit,
        message: message ?? this.message,
        isSaveAccount: isSaveAccount ?? this.isSaveAccount
    );
  }

  @override
  List<Object?> get props => [
    isHiddenPassword,
    email,
    password,
    statusSubmit,
    message,
    isSaveAccount
  ];
}
