// tạo Model để convert từ firebase về gán vô model này
import 'package:cloud_firestore/cloud_firestore.dart';

class DanhMucData {
  const DanhMucData({required this.img_url, required this.category,required this.id, required this.idType});



  final String img_url;
  final String category;
  final String id;
  final int idType;

  /// tạo đối tượng rỗng
  static const empty = DanhMucData(img_url: '', category: '', id: '', idType: 0, );

  ///
  bool get isEmpty => this == DanhMucData.empty;

  ///
  bool get isNotEmpty => this != DanhMucData.empty;

  // copywith để thay chỗ cần thay
  DanhMucData copyWith({

    String? img_url,
    String? category,
    String? id,
    int? idType,
  }) {
    return DanhMucData(
      img_url: img_url ?? this.img_url,
      category: category ?? this.category,
      id: id ?? this.id,
      idType: idType ?? this.idType,
    );
  }



  factory DanhMucData.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DanhMucData(
      category: data['category'],
      img_url: data['img_url'],
      id:  doc.id,
      idType: data['idType'] ??  0,

    );
  }


  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'img_url': img_url,
      'id': id,
      'idType': idType
    };
  }
  // check sự thay đổi
  @override
  List<Object?> get props =>[img_url,category,id,idType];
}
