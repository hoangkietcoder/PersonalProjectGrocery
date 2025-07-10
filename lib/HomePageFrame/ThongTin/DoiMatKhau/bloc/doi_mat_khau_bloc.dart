import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Compoents/FormatPassword/FormatPassword.dart';
import '../../../../Login/bloc/login_bloc.dart';
import '../../../../Repository/DoiMatKhau/doi_mat_khau_repository.dart';

part 'doi_mat_khau_event.dart';
part 'doi_mat_khau_state.dart';

class DoiMatKhauBloc extends Bloc<DoiMatKhauEvent, DoiMatKhauState> {
  DoiMatKhauBloc({required DoiMatKhauRepository doimatkhauRepo }) : doiMatKhauRepository = doimatkhauRepo ,super(DoiMatKhauState()) {


    // <sự kiện > (phương thức )
    on<HidePasswordChange>(_onChangePassword);
    on<HideConfirmPasswordChange>(_onChangeConfirmPassword);
    on<ChangeOldPassword>(_onOldPasswordChanged);
    on<ChangePassword>(_onPasswordChanged);
    on<ChangeConfirmPassword>(_onConfirmPasswordChanged);
    on<ChangePasswordRequested>(_onSubmitChangePassword);


  }

  final  DoiMatKhauRepository doiMatKhauRepository;


  //  icon ẩn hiện
  void _onChangePassword (
      HidePasswordChange event,
      Emitter<DoiMatKhauState> emit
      ){
    emit(state.copyWith(isHiddenPassword: !state.isHiddenPassword));
  }

  // icon ẩn hiện
  void _onChangeConfirmPassword (
      HideConfirmPasswordChange event,
      Emitter<DoiMatKhauState> emit
      ){
    emit(state.copyWith(isConfirmHiddenPassword: !state.isConfirmHiddenPassword));
  }



  void _onOldPasswordChanged(ChangeOldPassword event , Emitter<DoiMatKhauState> emit ){
      emit(state.copyWith(oldPassword: event.oldPassword));
  }

  // xử lí khi người dùng nhập mật khẩu mới
  void _onPasswordChanged(ChangePassword event, Emitter<DoiMatKhauState> emit) {
    final password = event.newPassword;
    final isStrong = FormatPassword.isStrong(password);
    String passwordError = '';
    // xử lí khi người dùng không nhập gì , nếu có nhập phải ≥ 8 ký tự, có chữ hoa, thường, số và ký tự đặc biệt
    if(password.isEmpty){
      passwordError = 'Vui lòng nhập mật khẩu';
    } else if (!isStrong){
        passwordError = 'Mật khẩu phải ≥ 8 ký tự, có chữ hoa, thường, số và ký tự đặc biệt';
    }
    emit(state.copyWith(
      newPassword: password,
      passwordStrengthError: passwordError ,
      confirmPasswordError: password == state.confirmPassword ? '' : state.confirmPassword.isNotEmpty ? 'Mật khẩu xác nhận không khớp' : '',
    ));
  }

  // xử lí khi người dùng xác nhận mật khẩu mới
  void _onConfirmPasswordChanged(ChangeConfirmPassword event, Emitter<DoiMatKhauState> emit) {
    final confirmPassword = event.confirmPassword;
    final newPassword = state.newPassword; // lấy lại newPassword
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError: confirmPassword != newPassword && confirmPassword.isNotEmpty
          ? 'Mật khẩu xác nhận không khớp'
          : '',
    ));
  }




  // xử lí khi ấn nút đổi mật khẩu
  Future<void> _onSubmitChangePassword(ChangePasswordRequested event, Emitter<DoiMatKhauState> emit,
      ) async {
    // Reset lỗi cũ nếu có
    emit(state.copyWith(
      statusSubmit: StatusChangePassword.loading,
      error: "",
      confirmPasswordError: "",
      passwordStrengthError: "",
    ));

    // Kiểm tra xác nhận mật khẩu
    if (state.newPassword != state.confirmPassword) {
      emit(state.copyWith(
        statusSubmit: StatusChangePassword.failure,
        confirmPasswordError: "Mật khẩu xác nhận không khớp.",
      ));
      return;
    }

    // Kiểm tra độ mạnh mật khẩu (nếu chưa kiểm)
    final isStrong = FormatPassword.isStrong(state.newPassword);
    if (!isStrong) {
      emit(state.copyWith(
        statusSubmit: StatusChangePassword.failure,
        passwordStrengthError: "Mật khẩu quá yếu (ít nhất 8 ký tự, có chữ và số).",
      ));
      return;
    }

    try {
      await doiMatKhauRepository.DoiMatKhau(
        matKhauCu: state.oldPassword,
        matKhauMoi: state.newPassword,
      );
      emit(state.copyWith(
        statusSubmit: StatusChangePassword.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusSubmit: StatusChangePassword.failure,
        error: e.toString().replaceFirst("Exception: ", ""),
      ));
    }
  }

}
