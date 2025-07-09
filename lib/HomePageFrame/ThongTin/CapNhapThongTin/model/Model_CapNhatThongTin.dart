class ModelCapnhatthongtin {
  const ModelCapnhatthongtin({ required this.id,required this.email,required this.name, required this.phoneNumber,this.img_url_Info=""});
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String img_url_Info;



  /// Empty user which represents an unauthenticated user.
  static const empty = ModelCapnhatthongtin(id: '',email: '',name: '', phoneNumber: '' ,img_url_Info: '');

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
      img_url_Info: json['url_info'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'img_url_Info':img_url_Info
    };
  }

  // copywith để thay chỗ cần thay
  ModelCapnhatthongtin copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? img_url_Info,
  }) {
    return ModelCapnhatthongtin(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        img_url_Info: img_url_Info ?? this.img_url_Info
    );
  }

  // check sự thay đổi
  @override
  List<Object?> get props =>[id,name, phoneNumber,email,img_url_Info];
}
