import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Main_Bloc/main_bloc.dart';


class CapNhatThongTinPage extends StatelessWidget {
  const CapNhatThongTinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CapNhatThongTinView();
  }
}

class CapNhatThongTinView extends StatefulWidget {
  const CapNhatThongTinView({super.key});

  @override
  State<CapNhatThongTinView> createState() => _CapNhatThongTinViewState();
}

class _CapNhatThongTinViewState extends State<CapNhatThongTinView> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blueAccent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        // chỉnh màu cho dấu back
        title: const Text(
          "Cập Nhật Thông Tin",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
        body: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h,),
                Stack(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 60.r,
                          backgroundImage: const AssetImage("assets/images/feedback.jpg"),
                        ),
                      ),
                      Positioned(
                        left: 100,
                        bottom: -13,
                        right: -5.0, // kéo qua phải
                        child: IconButton(
                          onPressed: () {
                            // _requestPermissionsAndPickImage(context);
                          },
                          icon: const Icon(Icons.camera_alt,color: Colors.black,),
                        ),
                      )
                    ]
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
                      final textColor = statusTheme ? Colors.black : Colors.white;
                      final theme = statusTheme ? Colors.blueAccent : Colors.black;
                    return Container(
                  // height: MediaQuery.of(context).size.height - 150.h, // Chiều cao còn lại
                  padding: const EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  child: Form(
                    key: _formSignInKey,
                    child: Column(
                      children: [
                        Text("Thông Tin Của Bạn",style: TextStyle(
                          color: textColor ,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20.h),
                        TextFormField(
                          obscureText: true,
                          // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                          controller: _nameController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Tên";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            label: const Text(
                              "Tên",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập Tên',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          obscureText: true,
                          // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                          controller: _emailController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            label: const Text(
                              "Email",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập Email',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          obscureText: true,
                          // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                          controller: _phoneController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Số điện thoại";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            label: const Text(
                              "Số điện thoại",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập số điện thoại',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              minimumSize: const Size(327, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                              ),
                            ),
                            onPressed: () {
                              //currentState: Truy cập trạng thái của biểu mẫu.
                              // validate(): Xác thực tất cả các trường biểu mẫu và trả về true nếu tất cả đều hợp lệ.
                              if (_formSignInKey.currentState!.validate()) {
                                // Gọi hàm xác thực
                                // context.read<LoginBloc>().add(const SubmitLogin());
                              }
                            },
                            label: Text(
                              "CẬP NHẬT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                        SizedBox(height: 13.h),
                      ],
                    ),
                  ),
                );
  },
),
              ],
            ),
          ),
        ));
  }
}

