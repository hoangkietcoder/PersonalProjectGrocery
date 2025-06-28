import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../Config/exception.dart';
import '../Firebase_Database/FirebaseDatabase_repository.dart';
import '../../Models/Register/register_user.dart';
import '../Firebase_Database/Register/register_repository.dart';
import '../Login/Model/User.dart';
import '../Notification/notification_repository.dart';
import 'Model/auth_data.dart';



// chứa những phương thức ( future<void>  , stream ) để gọi ra xử lí

//
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required RegisterRepository registerRepository,
  }) :  _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance, _registerRepository = registerRepository;

  // truyền bên ngoài vào repo
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final RegisterRepository _registerRepository;

  Stream<AuthData> get user async* {
    // await _notificationRepository.initNotification(selectNotification: selectNotification, onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    yield* _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserAccount.empty : firebaseUser.toUser;
      return AuthData(
          status: user == UserAccount.empty ? AuthenticationStatus.unauthenticated:
          AuthenticationStatus.authenticated,
          user: user
      );
    });
  }

  // phương thức đăng kí
  Future<void> signUp({ required RegisterUser registerUser}) async {
    try {
      log("registerUser $registerUser");
     await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerUser.email,
        password: registerUser.password,
       // dùng .whenComplete vì đăng kí nhanh quá bị báo lỗi k có quyền
      ).whenComplete(() async {
       await _registerRepository.signUpWithFireBase(registerUser: registerUser);
     });



    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }


  // đăng nhập bằng email password
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  // đăng xuất
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }


  // ForgotPassword
  Future<void> resetPassword({required String email})  async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ResetPasswordFailure.fromCode(e.code);
    }catch (e) {
     throw const ResetPasswordFailure();
    }
  }











}


//  lên mạng search
extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  UserAccount get toUser {
    return UserAccount(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
