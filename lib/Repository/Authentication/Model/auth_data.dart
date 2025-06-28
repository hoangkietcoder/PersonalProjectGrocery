
import 'package:equatable/equatable.dart';
import '../../Login/Model/User.dart';
import '../authentication_repository.dart';



class AuthData extends Equatable{

  const AuthData({
    required this.status,
    required this.user
});


  final AuthenticationStatus status; // lấy trạng thái status bên authen
  final UserAccount user;

  @override
  // TODO: implement props
  List<Object?> get props => [status,user];

}