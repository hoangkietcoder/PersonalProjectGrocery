class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'Email hoặc mật khẩu không đúng.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email không hợp lệ hoặc định dạng sai.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email không tồn tại, hãy đăng ký tài khoản.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Mật khẩu không đúng, hãy thử lại.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class LogOutFailure implements Exception {}



class ResetPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const ResetPasswordFailure([
    this.message = 'Email hoặc mật khẩu không đúng.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory ResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const ResetPasswordFailure(
          'An unknown exception occurred.',
        );
      case 'wrong-password':
        return const ResetPasswordFailure(
          'Sai mật khẩu',
        );
      case 'weak-password':
        return const ResetPasswordFailure(
          'Mật khẩu yếu',
        );
      default:
        return const ResetPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}