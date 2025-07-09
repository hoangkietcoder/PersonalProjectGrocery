import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/Repository/CapNhatThongTin/CapNhatThongTin_repository.dart';
import '../../Authentication/bloc/authentication_bloc.dart';
import '../../Compoents/Dialog/dialog_loading_logout.dart';
import '../../Compoents/Dialog/dialog_logout.dart';
import '../../Logout/cubit/logout_cubit.dart';
import '../../Main_Bloc/main_bloc.dart';
import '../../Repository/Authentication/authentication_repository.dart';
import '../../Repository/FeedBack/feedback_repository.dart';
import '../../Repository/ThongTin/thongtin_repository.dart';
import '../../Routes/argument/CapNhatThongTinArgument.dart';
import '../../Routes/argument/FeedBackArgument.dart';
import 'bloc_thongtin/thongtin_bloc.dart';


class ThongTinPage extends StatelessWidget {
  const ThongTinPage({super.key});

  @override
  Widget build(BuildContext context) {

    // dùng blocProvider để dùng cubit , authen đã đăng kí toàn app phải dùng lệnh lấy ra xài thôi ( lệnh : RepositoryProvider.of<AuthenticationRepository>(context)   )
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LogoutCubit(authenticationRepository:RepositoryProvider.of<AuthenticationRepository>(context)),
            child: const ThongTinView()),
        BlocProvider(
          create: (_) => ThongtinBloc(thongtinRepo: ThongtinRepository())..add(LoadUserInfoEventChange()),
        ),
      ], child: const ThongTinView(),
    );
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
    final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
    final textColorCategory = statusTheme ? Colors.white : Colors.black;
    final backgroundColor = statusTheme ? Colors.black: Colors.white;
    final textColorLogout = statusTheme ? Colors.white : Colors.white;
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
                    BlocBuilder<ThongtinBloc, ThongtinState>(
                    builder: (context, state) {
                      final name = state.modelThongTin.name;
                      return Center(
                      child: Text(
                        "Xin chào, $name",
                        style: TextStyle(
                            fontSize: 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    );
  },
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
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.r),
                        topRight: Radius.circular(60.r))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      ListTile(
                        onTap: () {
                          // khai báo repo
                          final capnhathongtinRepository = CapnhatthongtinRepository();
                          Navigator.pushNamed(context, '/CapNhatThongTin', arguments: CapNhatThongTinArgument(capnhatthongtinRepository: capnhathongtinRepository) );
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
                              fontWeight: FontWeight.w500, fontSize: 15.sp,color: textColorCategory),
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
                              fontWeight: FontWeight.w500, fontSize: 15.sp,color: textColorCategory),
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
                              fontWeight: FontWeight.w500, fontSize: 15.sp,color: textColorCategory),
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
                              fontWeight: FontWeight.w500, fontSize: 15.sp,color: textColorCategory),
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
                              color: textColorLogout,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                        icon: Icon(
                          Icons.logout,
                          color: textColorLogout,
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
    return BlocBuilder<ThongtinBloc, ThongtinState>(
      builder: (context, state) {
        final thongTin = state.modelThongTin;
        return ListTile(
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(data.profileImage),
      //   radius: 30.r,
      // ),
      leading: CircleAvatar(
        backgroundImage: thongTin.img_url_Info.isNotEmpty
            ? NetworkImage(thongTin.img_url_Info)
            : const AssetImage("assets/images/21.jpg") as ImageProvider,
        radius: 30.r,
      ),
      title: Text(
        thongTin.email.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        thongTin.phoneNumber.toString(),
        style: TextStyle(fontSize: 13.sp, color: Colors.white),
      ),
    );
  },
);
  }
}
