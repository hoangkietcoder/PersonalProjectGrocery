import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Main_Bloc/main_bloc.dart';

class CaiDatPage extends StatelessWidget {
  const CaiDatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CaiDatView();
  }
}

class CaiDatView extends StatefulWidget {
  const CaiDatView({super.key});

  @override
  State<CaiDatView> createState() => _CaiDatViewState();
}

class _CaiDatViewState extends State<CaiDatView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
        final appbar = statusTheme ? Colors.black : Colors.blueAccent;
        final textColorCategory = statusTheme ? Colors.blueAccent : Colors.black;
        return Scaffold(
            appBar: AppBar(
              systemOverlayStyle:  SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: appbar,
                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light,
                // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              // chỉnh màu cho dấu back
              title: Text("Cài Đặt",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: appbar,
              centerTitle: true,
            ),
            body:

            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  Flexible(
                    child: Container(
                      //color: Colors.white,
                      child: ListView(
                        physics:
                        const BouncingScrollPhysics(), // kéo màn hình dài ra
                        children: [
                          ListTile(
                            title: Text(
                              'CHUNG',
                              style: TextStyle(
                                color: textColorCategory,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          ListTile(
                            leading: const Icon(Icons.download),
                            title: const Text('Nâng Cấp Ứng Dụng'),
                            trailing: const Icon(Icons.navigate_next),
                            onTap: () {
                              // Navigate to Feedback settings page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Update()),
                              );
                            },
                          ),
                          Divider(),
                          // Feedback section
                          ListTile(
                            contentPadding: REdgeInsets.fromLTRB(16, 10, 0, 0),
                            title: Text(
                              'CHỦ ĐỀ',
                              style: TextStyle(
                                color: textColorCategory,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const _ButtonChangeTheme(),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

        );
      },
    );
  }
}


class Update extends StatefulWidget {
  const Update({super.key});

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool autoDownloadEnabled = false; // Biến để lưu trạng thái của switch mới

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffF3F0EF),
        appBar: AppBar(
          title: const Text('Update Application'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 5),
              child: Card(
                //color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Tải về cài đặt',
                    style: TextStyle(fontSize: 18.sp,),
                  ),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lần kiểm tra cuối vào ngày : 9 tháng 4, 2024'),
                      Text(
                          'Việc tải về qua mạng di động có thể phát sinh thêm phí,'),
                      Text(
                          'Nếu có thể, hãy tải về qua mạng Wi-Fi thay vì mạng di động .'),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 5),
              child: Card(
                //color: Colors.white,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tự động tải về qua Wi-Fi',
                        style: TextStyle(fontSize: 18.sp,),
                      ),
                      Switch(
                        //inactiveTrackColor: Colors.white,
                        activeColor: Colors.blueAccent,
                        value: autoDownloadEnabled,
                        onChanged: (newValue) {
                          // Thay đổi trạng thái khi người dùng thay đổi switch
                          setState(() {
                            autoDownloadEnabled = newValue;
                          });
                        },
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 5),
              child: Card(
                //color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Cập nhật gần nhất',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  subtitle: const Text(
                      'Bản cập nhật gần đây nhất đã được cài đặt vào 9 tháng 4, 2024 lúc 11:39'),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ));
  }
}

//thay đổi sáng tối cho giao diện.
class _ButtonChangeTheme extends StatelessWidget {
  const _ButtonChangeTheme();

  @override
  Widget build(BuildContext context) {
    final statusTheme = context.select((MainBloc bloc) =>
    bloc.state.statusTheme);
    final textColor = statusTheme ? Colors.white : Colors.black; // màu chữ

    return ListTile(
        leading: const Icon(Icons.dark_mode),
        title: Text(
          'Chủ Đề',
          style: TextStyle(
              color: textColor,
              fontSize: 14.sp
          ), // Áp dụng màu chữ
        ),
        trailing: BlocBuilder<MainBloc, MainState>(
          buildWhen: (cur, pre) {
            return cur.statusTheme != pre.statusTheme;
          },
          builder: (context, state) {
            return Switch(
                activeColor: Colors.blueAccent,
                value: state.statusTheme,
                onChanged: (value) =>
                    context.read<MainBloc>().add(ChangeTheme(value))
            );
          },
        )
    );
  }
}