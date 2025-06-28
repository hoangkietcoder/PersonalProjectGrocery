

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/second');
      },
      child: Container(
        padding: REdgeInsets.all(18),
        margin: REdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text("Sign In",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp
          ),),
        ),
      ),
    );
  }
}
