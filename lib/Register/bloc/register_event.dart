part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
class HidePassword extends RegisterEvent{
 const HidePassword();
}



class RegisterAccountRequested extends RegisterEvent {
  const RegisterAccountRequested();
}



//=================================================
class RegisterNameAccount extends RegisterEvent{
  RegisterNameAccount(this.name);

  final String name;
  @override
  List<Object> get props => [name];
}

class RegisterPhoneNumberAccount extends RegisterEvent{
  RegisterPhoneNumberAccount( this.phoneNumber);

  final String phoneNumber;
  @override
  List<Object> get props => [phoneNumber];
}

class RegisterEmailAccount extends RegisterEvent{
  RegisterEmailAccount(this.email);

  final String email;
  @override
  List<Object> get props => [email];
}

class RegisterPasswordAccount extends RegisterEvent{
  RegisterPasswordAccount(this.passwordRegister);

  final String passwordRegister;
  @override
  List<Object> get props => [passwordRegister];
}