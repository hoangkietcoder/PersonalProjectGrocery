import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogDeleteAllProductCart extends StatelessWidget {
  const DialogDeleteAllProductCart({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          const Expanded(
            flex: 1,
            child:Icon(CupertinoIcons.bell_circle),
          ),
          Expanded(
            flex: 9,
            child:Text(" Thông Báo", style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      content: Text(
        "Bạn có muốn xóa tất cả sản phẩm trong giỏ hàng này không?", style: TextStyle(color: Colors.black,fontSize: 12.sp),),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("Hủy", style: TextStyle(color: Colors.black,fontSize: 13.sp)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("Xóa",style: TextStyle(color: Colors.red,fontSize: 13.sp),),
        ),
      ],
    );



  }
}