// ava và text tên
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    // final data =
    // context.select((AuthenticationBloc bloc) => bloc.state.data.data);
    return ListTile(
      leading: CircleAvatar(
        // backgroundImage: NetworkImage(data.profileImage),
        backgroundImage: const AssetImage("assets/images/avatar.png"),
        radius: 30.r,
      ),
      title: Text(
        // data.name,
        "Hoàng Kiệt",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "Development",
        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
      ),
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Account()));
      },
    );
  }
}