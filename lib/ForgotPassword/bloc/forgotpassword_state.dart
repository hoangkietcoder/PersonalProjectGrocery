part of 'forgotpassword_bloc.dart';




enum StatusForgotPassword {inittial , loading, success, failure}


// require là truyền từ bên ngoài , this thì truyền trong file này
 class ForgotpasswordState extends Equatable {
  const ForgotpasswordState({
    this.email = "",
    this.statusSubmit = StatusForgotPassword.inittial,
    this.error = ""
  });


  final String email;
  final StatusForgotPassword statusSubmit;
  final String error;


  ForgotpasswordState copyWith({
   String? email,
   StatusForgotPassword? statusSubmit,
   String? error,

 }) {
   return ForgotpasswordState(
    email: email ?? this.email,
    statusSubmit: statusSubmit ?? this.statusSubmit,
    error: error ?? this.error

   );
}

  @override
  List<Object?> get props => [email,statusSubmit,error];
}

