class ModelCapnhatthongtin {
  const ModelCapnhatthongtin({ required this.id,required this.email,required this.name, required this.phoneNumber});
  final String id;
  final String email;
  final String name;
  final String phoneNumber;



  /// Empty user which represents an unauthenticated user.
  static const empty = ModelCapnhatthongtin(id: '',email: '',name: '', phoneNumber: '' );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == ModelCapnhatthongtin.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != ModelCapnhatthongtin.empty;


  // convert thành object ( from là lấy về , to là gửi lên )

  factory ModelCapnhatthongtin.fromJson(Map<String, dynamic> json) {
    return ModelCapnhatthongtin(
      id: json['id'] ?? "",
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  // copywith để thay chỗ cần thay
  ModelCapnhatthongtin copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
  }) {
    return ModelCapnhatthongtin(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,

    );
  }
}
