import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


// custom phần loading
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // static Route<void> route() {
  //   return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop( // dùng package để custom loading
          size: 200.sp,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}