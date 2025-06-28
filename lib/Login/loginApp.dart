import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Compoents/Dialog/dialog_loading_login.dart';
import '../Register/register.dart';
import '../Repository/Authentication/authentication_repository.dart';
import '../Repository/Notification/notification_repository.dart';
import 'bloc/login_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
          email: '',
          password: '',
          isSaveAccount: false,
          notificationRepository:  RepositoryProvider.of<NotificationRepository>(context)),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget with SU {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formSignInKey = GlobalKey<FormState>();
  bool? rememberPassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? isLoading = false; // check lúc đăng nhập thành công

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (pre, cur) {
            return pre.statusSubmit != cur.statusSubmit;
          },
          listener: (BuildContext context, LoginState state) {
            if (state.statusSubmit == LoginStatus.isProcessing) {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const DialogLoadingLogin(); // khi đang xử lí sẽ hiện nút loading
                },
              );
            } else {
              if (state.statusSubmit == LoginStatus.fail) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        state.message,
                      )));
              }
            }
          },
          child: GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h, // Đặt chiều cao cố định
                    child: Center(
                      child: Icon(
                        Icons.local_grocery_store,
                        size: 100.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        150.h, // Chiều cao còn lại
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
                          SizedBox(height: 2.h),
                          Text(
                            "Đăng Nhập",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => context.read<LoginBloc>().add(
                                EmailLogin(value)), // lưu thay đổi vào state
                            controller:
                                _emailController, // đăng kí dùng controller
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Vui lòng nhập Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen
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
                              hintText: 'Nhập email',
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
                          _Password(controller: _passwordController),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    hoverColor: Colors.redAccent,
                                    value: rememberPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberPassword = value!;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                  const Text(
                                    "Ghi nhớ mật khẩu",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/ForgotPassword");
                                },
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: Text(
                                    "Quên mật khẩu?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                minimumSize: const Size(327, 50),
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
                                  context
                                      .read<LoginBloc>()
                                      .add(const SubmitLogin());
                                }
                              },
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 13.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Bạn chưa có tài khoản? ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => const RegisterPage()));
                                    },
                                  text: "Đăng kí",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class _Password extends StatelessWidget with SU {
  final TextEditingController controller;

  const _Password({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      // bloc builder dùng để build lại 1 widget nào đó thay vì build lại hết
      buildWhen: (current, prev) {
        return current.isHiddenPassword != prev.isHiddenPassword;
      },
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(PasswordLogin(value)), // lưu thay đổi vào state
          controller: controller, // đăng kí dùng controller
          obscureText: state.isHiddenPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return " Vui lòng nhập mật khẩu";
            }
            return null;
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginBloc>().add(const HidePasswordLogin());
              },
              icon: state.isHiddenPassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              color: Colors.grey,
            ),
            label: const Text(
              "Password",
              style: TextStyle(color: Colors.black),
            ),
            hintText: 'Nhập mật khẩu',
            hintStyle: const TextStyle(
              color: Colors.black26,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      },
    );
  }
}
