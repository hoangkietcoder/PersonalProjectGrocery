import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogLogout extends StatelessWidget {
  final VoidCallback onPress;
  const DialogLogout({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Đăng xuất khỏi tài khoản của bạn ?',
        style: TextStyle(fontSize: 20.sp),
      ),
      contentPadding: REdgeInsets.all(10),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'HỦY',
              style: TextStyle(color: Colors.grey),
            )),
        TextButton(
            onPressed: onPress,
            child: const Text(
              'ĐĂNG XUẤT',
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}
