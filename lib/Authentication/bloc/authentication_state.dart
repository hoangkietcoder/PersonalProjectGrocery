part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserAccount.empty,
    this.isLogout = false,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserAccount user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated({bool isLogout = false})
      : this._(status: AuthenticationStatus.unauthenticated, isLogout: isLogout);

  final AuthenticationStatus status;
  final UserAccount  user;
  final bool isLogout;

  @override
  List<Object> get props => [status, user];
}