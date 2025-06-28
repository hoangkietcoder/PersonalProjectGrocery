// tạo Model để convert từ firebase về gán vô model này
import 'package:cloud_firestore/cloud_firestore.dart';

class DanhMucData {
  const DanhMucData({required this.img_url, required this.category});



  final String img_url;
  final String category;

  /// tạo đối tượng rỗng
  static const empty = DanhMucData(img_url: '', category: '', );

  ///
  bool get isEmpty => this == DanhMucData.empty;

  ///
  bool get isNotEmpty => this != DanhMucData.empty;

  // copywith để thay chỗ cần thay
  DanhMucData copyWith({

    String? img_url,
    String? category,
  }) {
    return DanhMucData(

      img_url: img_url ?? this.img_url,
      category: category ?? this.category,
    );
  }



  factory DanhMucData.fromDocumentSnapshot(DocumentSnapshot doc) {
    return DanhMucData(
      category: doc['category'],
      img_url: doc['img_url'],

    );
  }


  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'img_url': img_url,
    };
  }
  // check sự thay đổi
  @override
  List<Object?> get props =>[img_url,category];
}
