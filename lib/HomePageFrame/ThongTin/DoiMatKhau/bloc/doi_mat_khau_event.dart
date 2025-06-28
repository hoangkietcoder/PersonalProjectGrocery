part of 'doi_mat_khau_bloc.dart';

 class DoiMatKhauEvent extends Equatable {
  const DoiMatKhauEvent();

  @override

  List<Object?> get props => [];
}

class HidePasswordChange extends DoiMatKhauEvent {
 const HidePasswordChange();
}

class HideConfirmPasswordChange extends DoiMatKhauEvent {
 const HideConfirmPasswordChange();
}

class ChangeOldPassword extends DoiMatKhauEvent {
 const ChangeOldPassword(this.password);

 final String password;

 @override
 List<Object> get props => [password];
}


class ChangePassword extends DoiMatKhauEvent {
 const ChangePassword(this.password);

 final String password;

 @override
 List<Object> get props => [password];
}

class ChangeConfirmPassword extends DoiMatKhauEvent {
 const ChangeConfirmPassword(this.password);

 final String password;

 @override
 List<Object> get props => [password];
}


class ChangePasswordRequested extends DoiMatKhauEvent {
 const ChangePasswordRequested();
}
