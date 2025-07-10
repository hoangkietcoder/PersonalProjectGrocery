

import 'package:firebase_auth/firebase_auth.dart';

class DoiMatKhauRepository {
  DoiMatKhauRepository({FirebaseAuth? firebaseAuth }): firebaseAuth = firebaseAuth ??  firebaseAuth ?? FirebaseAuth.instance;


  final FirebaseAuth firebaseAuth;


  // xử lí đổi mật khẩu
  Future<void> DoiMatKhau({required String matKhauCu, required String matKhauMoi,}) async {
    final user = firebaseAuth.currentUser;

    if (user == null || user.email == null) {
      throw Exception('Không tìm thấy người dùng.');
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: matKhauCu,
    );
    print("Email: ${user.email}, Mật khẩu cũ: $matKhauCu");

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(matKhauMoi);
      } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw Exception('Mật khẩu cũ không đúng.');
        case 'weak-password':
          throw Exception('Mật khẩu mới quá yếu.');
        case 'requires-recent-login':
          throw Exception('Vui lòng đăng nhập lại để tiếp tục.');
        default:
          throw Exception(e.message ?? 'Lỗi đổi mật khẩu.');
      }
    }catch (_){
      throw Exception('Lỗi không xác định khi đổi mật khẩu.');
    }
  }
}