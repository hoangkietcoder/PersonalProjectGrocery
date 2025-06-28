



import 'package:equatable/equatable.dart';

class UserAccount extends Equatable{

  const UserAccount({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.password,
    this.isSaveAccount = false,
});


  final String id;

  /// The current user's email address.
  final String? email;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;


  final String? password;
  final bool? isSaveAccount;


  /// Empty user which represents an unauthenticated user.
  static const empty = UserAccount(id: '', );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserAccount.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserAccount.empty;

  @override
  List<Object?> get props =>[id, email, name, photo, password, isSaveAccount];

}