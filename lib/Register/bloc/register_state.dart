part of 'register_bloc.dart';

enum RegisterStatus { inittial , loading, success, failure}

final class RegisterState extends Equatable {
  const RegisterState({
    this.name = "",
    this.phoneNumber="",
    this.email = "",
    this.passwordResgister = "",
    this.isHiddenPassword = true,
    this.statusSubmit = RegisterStatus.inittial,
    this.error="",
  });


  final String name;
  final String phoneNumber;
  final String email;
  final String passwordResgister;
  final bool isHiddenPassword;
  final RegisterStatus statusSubmit;
  final String error;

  RegisterState copyWith({
    String? Name,
    String? phoneNumber,
    String? Email,
    String? passwordResgister,
    bool? isHiddenPassword,
    RegisterStatus? statusSubmit,
    String? error,
  }) {
    return RegisterState(
      name: Name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: Email ?? this.email,
      passwordResgister: passwordResgister ?? this.passwordResgister,
      isHiddenPassword: isHiddenPassword ?? this.isHiddenPassword,
      statusSubmit: statusSubmit ?? this.statusSubmit,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isHiddenPassword, passwordResgister, email, name, statusSubmit,phoneNumber];
}
