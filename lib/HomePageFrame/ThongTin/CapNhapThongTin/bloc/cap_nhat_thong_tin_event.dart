part of 'cap_nhat_thong_tin_bloc.dart';

sealed class CapNhatThongTinEvent extends Equatable {
  const CapNhatThongTinEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}



/// Load dữ liệu từ Firebase
class LoadUserInfoEvent extends CapNhatThongTinEvent {
}

/// cập nhật lại thông tin người dùng
class UpdateUserInfoEvent extends CapNhatThongTinEvent {

  final String name;
  final String phoneNumber;

  UpdateUserInfoEvent({required this.name, required this.phoneNumber});

  @override
  List<Object?> get props => [name,phoneNumber];
}

// up hình ảnh
final class UploadImageEvent extends CapNhatThongTinEvent{
  const UploadImageEvent({ required this.ProductId,required this.imageFile });
  final String ProductId; // Id sản phẩm cần cập nhật ảnh
  final File imageFile;


  @override
  List<Object> get props => [ProductId,imageFile];
}

