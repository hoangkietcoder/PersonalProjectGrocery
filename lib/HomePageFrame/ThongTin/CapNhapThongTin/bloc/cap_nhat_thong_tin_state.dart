part of 'cap_nhat_thong_tin_bloc.dart';



enum StatusLoadInfo { initial, loading, success, failure }
enum StatusCapNhatInfo {initial, loading, success, failure}

class CapNhatThongTinState extends Equatable {
  final ModelCapnhatthongtin model;
  final StatusLoadInfo statusLoadInfo;
  final StatusCapNhatInfo statusCapNhatInfo;

  const CapNhatThongTinState({
    required this.model,
    this.statusLoadInfo = StatusLoadInfo.initial,
    this.statusCapNhatInfo = StatusCapNhatInfo.initial,
  });

  factory CapNhatThongTinState.initial() {
    return CapNhatThongTinState(
      model: const ModelCapnhatthongtin(id:'',name: '', email: '', phoneNumber: ''),
    );
  }

  CapNhatThongTinState copyWith({
    ModelCapnhatthongtin? model,
    StatusLoadInfo? statusLoadInfo,
    StatusCapNhatInfo? statusCapNhatInfo,
  }) {
    return CapNhatThongTinState(
      model: model ?? this.model,
      statusLoadInfo: statusLoadInfo ?? this.statusLoadInfo,
      statusCapNhatInfo: statusCapNhatInfo ?? this.statusCapNhatInfo,
    );
  }

  @override
  List<Object?> get props => [model, statusLoadInfo,statusCapNhatInfo];
}
