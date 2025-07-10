import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../Compoents/Dialog/dialog_loading_login.dart';
import '../Repository/Authentication/authentication_repository.dart';
import 'bloc/register_bloc.dart';

class RegisterPage extends StatelessWidget {
  final String date;

  const RegisterPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
          authen: RepositoryProvider.of<AuthenticationRepository>(context), dateOfBirthday: date),
      child:  RegisterView(date: date,),
    );
  }
}

class RegisterView extends StatefulWidget {
  final String date;
  const RegisterView({super.key, required this.date});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formSignInKey = GlobalKey<FormState>();

  final TextEditingController _nameRegisterController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _emailResgiterController = TextEditingController();
  final TextEditingController _passwordRegisterController = TextEditingController();


  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void dispose() {
    _emailResgiterController.dispose();
    _passwordRegisterController.dispose();
    _nameRegisterController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // vừa vô trang sẽ set mặc định cho date là ngày hôm nay
  @override
  void initState() {
    super.initState();
    _DateController.text = widget.date;
  }

  void _showStartDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(DateTime.now().year + 5),
    ).then((value) {
      if(value != null){
        String dateStr = _dateFormat.format(value);
        _DateController.text = dateStr ;
        context.read<RegisterBloc>().add(RegisterDateOfBirthdayAccount(dateStr));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white, // đổi màu dấu back về trong appbar
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Đăng Kí",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<RegisterBloc, RegisterState>(
              listenWhen: (pre, current) {
                return pre.statusSubmit != current.statusSubmit;
              },
              listener: (context, state) {
                if (state.statusSubmit == RegisterStatus.loading) {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const DialogLoadingLogin(); // khi đang xử lí sẽ hiện nút loading
                    },
                  );
                } else if (state.statusSubmit == RegisterStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          state.error,
                        )));
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // Chiều cao còn lại
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 25.h),
                          TextFormField(
                            onChanged: (value) => context.read<RegisterBloc>().add(RegisterNameAccount(value)), // lưu thay đổi vào state
                            controller: _nameRegisterController, // đăng kí dùng controller
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Vui lòng nhập tên";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen
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
                              hintText: 'Nhập NickName',
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
                            keyboardType: TextInputType.number, // định dạng số
                            onChanged: (value) => context.read<RegisterBloc>().add(RegisterPhoneNumberAccount(value)), // lưu thay đổi vào state
                            controller: _phoneNumberController,
                            // đăng kí dùng controller
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Vui lòng số điện thoại";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen
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
                              hintText: 'Nhập điện thoại',
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
                            controller: _DateController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              label: const Text(
                                "Ngày Tháng Năm Sinh",
                                style: TextStyle(color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  _showStartDatePicker(context);
                                },
                                icon: const Icon(Icons.calendar_today,
                                    color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            onChanged: (value) => context.read<RegisterBloc>().add(RegisterEmailAccount(value)), // lưu thay đổi vào state
                            controller: _emailResgiterController,
                            // đăng kí dùng controller
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Vui lòng nhập Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
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
                          _Password(controller: _passwordRegisterController),
                          SizedBox(height: 25.h),
                          // button
                          SizedBox(
                            width: double.infinity,
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, state) {
                                if (state.statusSubmit == RegisterStatus.loading) {
                                  return const Center(
                                      child: CircularProgressIndicator(color: Colors.white,)
                                  );
                                }
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    minimumSize: const Size(327, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.r)),
                                    ),
                                  ),
                                  onPressed: () {
                                    // validate(): Xác thực tất cả các trường biểu mẫu và trả về true nếu tất cả đều hợp lệ.
                                    if (_formSignInKey.currentState!.validate())
                                    {
                                      context.read<RegisterBloc>().add(const RegisterAccountRequested());
                                    }
                                  },
                                  child: Text(
                                    "Tạo Tài Khoản",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Password extends StatelessWidget with SU {
  final TextEditingController controller;

  const _Password({
    required this.controller,
  });

  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // bloc builder dùng để build lại 1 widget nào đó thay vì build lại hết
      buildWhen: (current, prev) {
        return current.isHiddenPassword != prev.isHiddenPassword;
      },
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<RegisterBloc>().add(RegisterPasswordAccount(value)), // lưu thay đổi vào state
          controller: controller, // đăng kí dùng controller
          obscureText: state.isHiddenPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return " Vui lòng nhập mật khẩu";
            }
            return null;
          },
          decoration: InputDecoration(
            // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                context.read<RegisterBloc>().add(const HidePassword());
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
