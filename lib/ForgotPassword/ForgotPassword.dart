import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Compoents/Dialog/dialog_loading_login.dart';
import '../Repository/Authentication/authentication_repository.dart';
import 'bloc/forgotpassword_bloc.dart';

class ForgotpasswordPage extends StatelessWidget {
  const ForgotpasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotpasswordBloc(
          Authen: RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const ForgotpasswordView(),
    );
  }
}

class ForgotpasswordView extends StatefulWidget {
  const ForgotpasswordView({super.key});

  @override
  State<ForgotpasswordView> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<ForgotpasswordView> {
  final _formSignInKey = GlobalKey<FormState>();

  final TextEditingController _emailForgotPasswordController = TextEditingController();




  // giải phóng controller
  @override
  void dispose() {
    _emailForgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Quên mật khẩu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ForgotpasswordBloc, ForgotpasswordState>(
                listenWhen: (pre, current) {
              return pre.statusSubmit != current.statusSubmit;
            }, listener: (context, state) {
              if (state.statusSubmit == StatusForgotPassword.loading) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const DialogLoadingLogin(); // khi đang xử lí sẽ hiện nút loading
                  },
                );
              } else if (state.statusSubmit == StatusForgotPassword.success) {

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã gửi link reset password!')));
                // vì do realtime rồi nên chỉ cần popuntil về thôi
                Navigator.popUntil(context, ModalRoute.withName('/Login'));

              } else if (state.statusSubmit == StatusForgotPassword.failure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        state.error,
                      )));
              }
            }),
          ],
          child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Icon(
                    Icons.lock,
                    size: 100.sp,
                  ),
                  Container(
                    padding:  REdgeInsets.fromLTRB(25.0, 10.0, 25.0, 20.0),
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
                          SizedBox(height: 25.h),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => context.read<ForgotpasswordBloc>().add(EmailForgotChange(value)), // lưu thay đổi vào state
                            controller: _emailForgotPasswordController, // đăng kí dùng controller
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Vui lòng nhập Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              label: const Text("Email"),
                              hintText: 'Nhập Email muốn lấy lại',
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
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey, // Cancel button màu xám
                                    padding: EdgeInsets.symmetric(vertical: 15.r,horizontal: 20.w,),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Xử lý khi nhấn Cancel
                                    Navigator.of(context).popUntil(ModalRoute.withName("/Login"));
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w), // khoảng cách giữa hai nút
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    padding: EdgeInsets.symmetric(vertical: 15.r,horizontal: 20.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    //currentState: Truy cập trạng thái của biểu mẫu.
                                    // validate(): Xác thực tất cả các trường biểu mẫu và trả về true nếu tất cả đều hợp lệ.
                                    if (_formSignInKey.currentState!.validate()) {
                                      // Gọi hàm xác thực
                                      context.read<ForgotpasswordBloc>().add(const ForgotPasswordRequested());
                                    }
                                  },
                                  child: Text(
                                    "Tìm Email",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )

        ),
      ),
    );
  }
}




