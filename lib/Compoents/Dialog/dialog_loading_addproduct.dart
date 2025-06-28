import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DialogLoadingAddProduct extends StatelessWidget {
  const DialogLoadingAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false, // false => không thể quay lại trang trước
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            elevation: 0,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LoadingAnimationWidget.threeArchedCircle( // dùng package để custom loading
                  size: 41.sp,
                  color: Colors.blueAccent,
                )
              ],
            )
        ));
  }
}
