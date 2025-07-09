



import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable{

  const RegisterUser({
    required this.name ,
    required this.phoneNumber ,
    required this.email ,
    required this.password ,
    this.url_info = "",
  });


  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String url_info;


  /// Empty user which represents an unauthenticated user.
  static const empty = RegisterUser( name: '', phoneNumber: '', email: '', password: '', );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == RegisterUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != RegisterUser.empty;



  // copywith để thay chỗ cần thay
  RegisterUser copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? password
  }) {
    return RegisterUser(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password
    );
  }

  // convert thành object ( from là lấy về , to là gửi lên )
  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
      name: json["name"] ?? "",
      phoneNumber: json["phoneNumber"] ??"",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      url_info: json["url_info"] ?? "",
  );


  // convert object thành map để đưa lên firebase bỏ trường password đi
  Map<String, dynamic> toJsonUserProfile() => {
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "url_info":url_info,
  };


  // convert object thành map để đưa qua thằng login
  Map<String, dynamic> toJsonRegister() => {
    "email": email,
    "password": password
  };

  @override
  List<Object?> get props =>[ email, name, phoneNumber, password, url_info];

}