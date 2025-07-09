part of 'cap_nhat_thong_tin_bloc.dart';



enum StatusLoadInfo { initial, loading, success, failure }
enum StatusCapNhatInfo {initial, loading, success, failure}
enum StatusLoadImage { initial, loading, success, failure }

class CapNhatThongTinState extends Equatable {

  const CapNhatThongTinState({
    required this.model,
    this.statusLoadInfo = StatusLoadInfo.initial,
    this.statusCapNhatInfo = StatusCapNhatInfo.initial,
    this.statusLoadImage = StatusLoadImage.initial,
    this.imageUrl_info="",
    this.error = "",
  });

  final ModelCapnhatthongtin model;
  final StatusLoadInfo statusLoadInfo;
  final StatusCapNhatInfo statusCapNhatInfo;
  final StatusLoadImage statusLoadImage;
  final String? imageUrl_info;
  final String error;



  factory CapNhatThongTinState.initial() {
    return CapNhatThongTinState(
      model: const ModelCapnhatthongtin(id:'',name: '', email: '', phoneNumber: '',img_url_Info: ''),
    );
  }

  CapNhatThongTinState copyWith({
    ModelCapnhatthongtin? model,
    StatusLoadInfo? statusLoadInfo,
    StatusCapNhatInfo? statusCapNhatInfo,
    StatusLoadImage? statusLoadImage,
    String? imageUrl_info,
    String? error,
  }) {
    return CapNhatThongTinState(
      model: model ?? this.model,
      statusLoadInfo: statusLoadInfo ?? this.statusLoadInfo,
      statusCapNhatInfo: statusCapNhatInfo ?? this.statusCapNhatInfo,
      statusLoadImage: statusLoadImage ?? this.statusLoadImage,
      imageUrl_info: imageUrl_info ?? this.imageUrl_info,
      error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [model, statusLoadInfo,statusCapNhatInfo,statusLoadImage,imageUrl_info,error];
}
