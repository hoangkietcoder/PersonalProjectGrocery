part of 'doi_mat_khau_bloc.dart';




enum StatusChangePassword {inittial , loading, success, failure}

 class DoiMatKhauState extends Equatable {
   const DoiMatKhauState({
    this.isHiddenPassword = true,
    this.isConfirmHiddenPassword = true,
    this.statusSubmit = StatusChangePassword.inittial,
    this.error = "",
    this.oldPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
    this.confirmPasswordError = "",
    this.passwordStrengthError = "",
  });


  final bool isHiddenPassword;
  final bool isConfirmHiddenPassword;
  final StatusChangePassword statusSubmit;
  final String error;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  // tạo 2 error dùng để báo lỗi khi mật khẩu yếu hoặc không khớp với nhau
   final String confirmPasswordError;
   final String passwordStrengthError;


  DoiMatKhauState copyWith({
   bool? isHiddenPassword,
   bool? isConfirmHiddenPassword,
   StatusChangePassword? statusSubmit,
   String? error,
   String? oldPassword,
   String? newPassword,
   String? confirmPassword,
   String? confirmPasswordError,
   String? passwordStrengthError,
 }) {
   return DoiMatKhauState(
     isHiddenPassword: isHiddenPassword ?? this.isHiddenPassword,
     isConfirmHiddenPassword: isConfirmHiddenPassword ?? this.isConfirmHiddenPassword,
     statusSubmit: statusSubmit ?? this.statusSubmit,
     error: error ?? this.error,
     oldPassword: oldPassword ?? this.oldPassword,
     newPassword: newPassword ?? this.newPassword,
     confirmPassword: confirmPassword ?? this.confirmPassword,
     passwordStrengthError: passwordStrengthError ?? this.passwordStrengthError,

   );
}

  @override
  List<Object?> get props => [isHiddenPassword,isConfirmHiddenPassword,statusSubmit,error,oldPassword,newPassword,confirmPassword,confirmPassword,passwordStrengthError];
}


