part of 'doi_mat_khau_bloc.dart';




enum StatusChangePassword {inittial , loading, success, failure}

 class DoiMatKhauState extends Equatable {
  const DoiMatKhauState({this.isHiddenPassword = true, this.statusSubmit = StatusChangePassword.inittial,this.isConfirmHiddenPassword = true});


  final bool isHiddenPassword;
  final bool isConfirmHiddenPassword;
  final StatusChangePassword statusSubmit;


  DoiMatKhauState copyWith({
   bool? isHiddenPassword,
    bool? isConfirmHiddenPassword,
   StatusChangePassword? statusSubmit
 }) {
   return DoiMatKhauState(
   isHiddenPassword: isHiddenPassword ?? this.isHiddenPassword,
    isConfirmHiddenPassword: isConfirmHiddenPassword ?? this.isConfirmHiddenPassword,
    statusSubmit: statusSubmit ?? this.statusSubmit

   );
}

  @override
  List<Object?> get props => [isHiddenPassword,isConfirmHiddenPassword,statusSubmit,];
}


