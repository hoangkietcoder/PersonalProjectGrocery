import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Authentication/bloc/authentication_bloc.dart';
import '../../Compoents/Dialog/dialog_loading_logout.dart';
import '../../Compoents/Dialog/dialog_logout.dart';
import '../../Logout/cubit/logout_cubit.dart';
import '../../Repository/Authentication/authentication_repository.dart';
import '../../Repository/FeedBack/feedback_repository.dart';
import '../../Routes/argument/FeedBackArgument.dart';


class ThongTinPage extends StatelessWidget {
  const ThongTinPage({super.key});

  @override
  Widget build(BuildContext context) {

    // dùng blocProvider để dùng cubit , authen đã đăng kí toàn app phải dùng lệnh lấy ra xài thôi ( lệnh : RepositoryProvider.of<AuthenticationRepository>(context)   )
    return BlocProvider(
      create: (context) => LogoutCubit(authenticationRepository:RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const ThongTinView());
  }
}

class ThongTinView extends StatefulWidget {
  const ThongTinView({super.key});

  @override
  State<ThongTinView> createState() => _ThongTinViewState();
}

class _ThongTinViewState extends State<ThongTinView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listenWhen: (cur, pre) {
        return cur.statusLogout != pre.statusLogout;
      },
      listener: (context, state) {
        if (state.statusLogout == StatusInfo.isProccessing) {
          showDialog<void>(
              context: context,
              barrierDismissible: false, // người dùng sẽ không thể đóng hộp thoại bằng cách chạm vào khu vực bên ngoài của hộp thoại
              builder: (BuildContext context) {
                return  DialogLoadingLogout();
              });
        } else {
          if (state.statusLogout == StatusInfo.failure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.blue.shade700,
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: REdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Xin chào,",
                        style: TextStyle(
                            fontSize: 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              UserProfileTile(),
              SizedBox(height: 25.h,),
              Expanded(
                  child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.r),
                        topRight: Radius.circular(60.r))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/CapNhatThongTin');
                      },
                      leading: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.blueAccent,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Cập Nhật Thông Tin",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      trailing: SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: Icon(
                          Icons.navigate_next_outlined,
                          size: 32.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.2.h,
                      indent: 18,
                      endIndent: 40,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/DoiMatKhau');
                      },
                      leading: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.blueAccent,
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Đổi Mật Khẩu",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      trailing: SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: Icon(
                          Icons.navigate_next_outlined,
                          size: 32.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.2.h,
                      indent: 18,
                      endIndent: 40,
                    ),
                    ListTile(
                      onTap: () {
                        // khai báo repo
                        final feedbackRepository = FeedBackRepository();
                        Navigator.pushNamed(context, '/FeedBack', arguments: FeedBackArgument(feedbackRepository: feedbackRepository) );
                      },

                      leading: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.blueAccent,
                        ),
                        child: const Icon(
                          Icons.feedback,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Feedback",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      trailing: SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: Icon(
                          Icons.navigate_next_outlined,
                          size: 32.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.2.h,
                      indent: 18,
                      endIndent: 40,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/CaiDat');
                      },
                      leading: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.blueAccent,
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Cài Đặt",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                      trailing: SizedBox(
                        width: 50.w,
                        height: 50.h,
                        child: Icon(
                          Icons.navigate_next_outlined,
                          size: 32.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.2.h,
                      indent: 18,
                      endIndent: 40,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        final bloc = context.read<LogoutCubit>();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogLogout(
                            onPress: () {
                              bloc.logOut();
                            })
                        );
                      },
                      label: Text(
                        "Đăng Xuất",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            REdgeInsets.symmetric(vertical: 7, horizontal: 90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
// ava và text tên
class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return ListTile(
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(data.profileImage),
      //   radius: 30.r,
      // ),
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/21.jpg"),
        radius: 30.r,
      ),
      title: Text(
        // data.name,
        data.email.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        // data.user,
        "Dev Mobible",
        style: TextStyle(fontSize: 13.sp, color: Colors.white),
      ),
    );
  }
}
