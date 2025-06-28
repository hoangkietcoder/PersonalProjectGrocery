part of 'forgotpassword_bloc.dart';

sealed class ForgotpasswordEvent extends Equatable {
  const ForgotpasswordEvent();


  @override
  List<Object> get props => [];
}





class ForgotPasswordRequested extends ForgotpasswordEvent {
  const ForgotPasswordRequested();
}

class EmailForgotChange extends ForgotpasswordEvent {
  const EmailForgotChange(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}


