import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/doi_mat_khau_bloc.dart';

class DoiMatKhauPage extends StatelessWidget {
  const DoiMatKhauPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoiMatKhauBloc(),
      child: const DoiMatKhauView(),
    );
  }
}

class DoiMatKhauView extends StatefulWidget {
  const DoiMatKhauView({super.key});

  @override
  State<DoiMatKhauView> createState() => _DoiMatKhauViewState();
}

class _DoiMatKhauViewState extends State<DoiMatKhauView> {
  final TextEditingController _passwordOldController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _confirmpasswordNewController = TextEditingController();
  final _formSignInKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordOldController.dispose();
    _passwordNewController.dispose();
    _confirmpasswordNewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.blueAccent,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          iconTheme:  IconThemeData(color: Colors.white),
          // chỉnh màu cho dấu back
          title: const Text(
            "Đổi mật khẩu",
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
                SizedBox(
                  height: 15.h,
                ),
                Container(
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
                        SizedBox(height: 10.h),
                        TextFormField(
                          obscureText: true,
                          onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                          controller:
                              _passwordOldController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Mật khẩu cũ";
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
                              "Mật khẩu cũ",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập mật khẩu cũ',
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
                        BlocBuilder<DoiMatKhauBloc, DoiMatKhauState>(
                          buildWhen: (current, prev) {
                            return current.isHiddenPassword != prev.isHiddenPassword;
                          },
                          builder: (context, state) {
                            return TextFormField(
                              obscureText: state.isHiddenPassword,
                              onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangePassword(value)), // lưu thay đổi vào state
                              controller:
                                  _passwordNewController, // đăng kí dùng controller
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Vui lòng nhập Mật khẩu mới";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<DoiMatKhauBloc>()
                                        .add(const HidePasswordChange());
                                  },
                                  icon: state.isHiddenPassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                label: const Text(
                                  "Mật khẩu mới",
                                  style: TextStyle(color: Colors.black),
                                ),
                                hintText: 'Nhập mật khẩu mới',
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
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        BlocBuilder<DoiMatKhauBloc, DoiMatKhauState>(
                          buildWhen: (current, prev) {
                            return current.isConfirmHiddenPassword != prev.isConfirmHiddenPassword;
                          },
                          builder: (context, state) {
                            return TextFormField(
                              obscureText: state.isConfirmHiddenPassword,
                              onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeConfirmPassword(value)), // lưu thay đổi vào state
                              controller: _confirmpasswordNewController, // đăng kí dùng controller
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Vui lòng nhập Mật khẩu mới";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context
                                        .read<DoiMatKhauBloc>()
                                        .add(const HideConfirmPasswordChange());
                                  },
                                  icon: state.isConfirmHiddenPassword
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                label: const Text(
                                  "Mật khẩu mới",
                                  style: TextStyle(color: Colors.black),
                                ),
                                hintText: 'Xác nhận mật khẩu mới',
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
                            );
                          },
                        ),
                        SizedBox(height: 25.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: ImageIcon(
                              const AssetImage(
                                  "assets/images/iconchangepassword.png"),
                              color: Colors.white,
                              size: 18.sp,
                            ),
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
                              "Đổi mật khẩu",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                          ),
                        ),
                        SizedBox(height: 13.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
