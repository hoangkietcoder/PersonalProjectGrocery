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
 const ChangeOldPassword(this.oldPassword);

 final String oldPassword;

 @override
 List<Object> get props => [oldPassword];
}


class ChangePassword extends DoiMatKhauEvent {
 const ChangePassword(this.newPassword);

 final String newPassword;

 @override
 List<Object> get props => [newPassword];
}

class ChangeConfirmPassword extends DoiMatKhauEvent {
 const ChangeConfirmPassword(this.confirmPassword);

 final String confirmPassword;

 @override
 List<Object> get props => [confirmPassword];
}


class ChangePasswordRequested extends DoiMatKhauEvent {
 const ChangePasswordRequested();
}
