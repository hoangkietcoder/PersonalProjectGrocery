

import 'package:flutter/cupertino.dart';


// làm cái này để khi thay cho cái chuyển trang khi nhấn thông báo , vì _navigatorKey không cần context , còn thông báo phải cần context ( view )
class Navigatorkey {
  final navigatorKey = GlobalKey<NavigatorState>();

  Future<void> selectNotification() async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil("/HomeScreenPage",(route) => false); // false là xóa , true là k xóa
}

  Future<void> onDidReceiveLocalNotification() async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil("/HomeScreenPage",(route) => false); // false là xóa , true là k xóa
  }


}