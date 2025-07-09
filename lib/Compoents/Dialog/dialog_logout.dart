import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Main_Bloc/main_bloc.dart';

class DialogLogout extends StatelessWidget {
  final VoidCallback onPress;
  const DialogLogout({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
    final textColor = statusTheme ? Colors.white : Colors.white;
    final backgroundColor = statusTheme ? Colors.black : Colors.white;


    return AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(
        'Đăng xuất khỏi tài khoản của bạn ?',
        style: TextStyle(fontSize: 20.sp,color: textColor),
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
