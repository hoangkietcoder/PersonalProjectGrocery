
import '../../Repository/Login/Model/User.dart';


class FeedBackData {
  const FeedBackData({
    // required this.emailUser,
    required this.email,
    required this.chude,
    required this.noidung,
  });

  // final String emailUser;
  final String email;
  final String chude;
  final String noidung;

  /// tạo đối tượng rỗng
  static const empty = FeedBackData(email: '',chude: '', noidung: '',     );

  ///
  bool get isEmpty => this == FeedBackData.empty;

  ///
  bool get isNotEmpty => this != FeedBackData.empty;

  // copywith để thay chỗ cần thay
  FeedBackData copyWith({
    String? emailUser,
    String? email,
    String? chude,
    String? noidung,
  }) {
    return FeedBackData(
      // emailUser: emailUser ?? this.emailUser,
      email: email ?? this.email,
      chude: chude ?? this.chude,
      noidung: noidung ?? this.noidung,
    );
  }



  // Factory method để chuyển đổi từ DocumentSnapshot của Firebase thành DanhMuc
  // factory FeedBackData.fromDocumentSnapshot(Map<String, dynamic> data, String id) {
  //   return FeedBackData(
  //     idDanhMuc: id,
  //     img_url: data["img_url"],
  //     category: data['category'] ?? '', // Lấy dữ liệu từ Firebase và chuyển đổi
  //   );
  // }

  // convert thành object ( from là lấy về , to là gửi lên )
  factory FeedBackData.fromJson(Map<String, dynamic> json) => FeedBackData(
      // emailUser: json["emailUser"] ?? "",
      email: json["email"] ?? "",
      chude: json["chude"] ?? "",
      noidung: json["noidung"] ?? "",

  );

  // convert object thành map để đưa lên firebase ( màu xanh lá là trg trên firebase )
  Map<String, dynamic> toJsonCreateFeedBack() => {
    // "emailUser":emailUser,
    "email": email,
    "chude": chude,
    "noidung": noidung,

  };

  // check sự thay đổi
  @override
  List<Object?> get props =>[
    // emailUser,
    email,
    chude,
    noidung
  ];
}