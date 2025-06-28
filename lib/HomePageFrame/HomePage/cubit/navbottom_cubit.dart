import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Repository/Notification/notification_repository.dart';
part 'navbottom_state.dart';



class NavbottomCubit extends Cubit<NavbottomState> {
  NavbottomCubit({required NotificationRepository notificationRepository}) :
        _notificationRepository = notificationRepository,
        super(NavbottomState());

  final NotificationRepository _notificationRepository;
  void changeTab(int index){
    emit(state.copyWith(index: index));
  }

  // khởi tạo repo thông báo
  // Future<void> init() async{
  //   await _notificationRepository.scheduleNotification(0, "title", "body");
  //   emit(state.copyWith(statusNotification: StatusNotification.success));
  // }
}

