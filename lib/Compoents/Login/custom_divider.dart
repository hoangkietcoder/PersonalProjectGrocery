

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// custom đường kẻ
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.h, // Độ dày của đường kẻ
            color: Colors.grey, // Màu sắc của đường kẻ
            margin: REdgeInsets.fromLTRB(16.0, 0, 8.0, 0), // Điều chỉnh khoảng cách
          ),
        ),
        Text(
          ("or Continue"),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp, // Điều chỉnh kích thước chữ
          ),
        ),
        Expanded(
          child: Container(
            height: 1.h,
            color: Colors.grey,
            margin: REdgeInsets.fromLTRB(8.0, 0, 30.0, 0),
          ),
        ),
      ],
    );
  }
}


