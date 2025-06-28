part of 'logout_cubit.dart';

enum StatusInfo { unknown, isProccessing, success, failure }

class LogoutState extends Equatable {
  const LogoutState({this.statusLogout = StatusInfo.unknown, this.error = ""});

  final StatusInfo statusLogout;
  final String error;

  LogoutState copyWith({StatusInfo? statusLogout, String? error}) {
    return LogoutState(
      statusLogout: statusLogout ?? this.statusLogout,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [statusLogout, error];
}
