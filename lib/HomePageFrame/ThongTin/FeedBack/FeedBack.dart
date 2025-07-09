import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Authentication/bloc/authentication_bloc.dart';
import '../../../Compoents/Dialog/dialog_loading_addproduct.dart';
import '../../../Main_Bloc/main_bloc.dart';
import '../../../Repository/FeedBack/feedback_repository.dart';
import '../../../Repository/Login/Model/User.dart';
import 'bloc/feedback_bloc.dart';

class Send_Feedback_Page extends StatelessWidget {
  const Send_Feedback_Page({super.key, required this.feedbackRepository});



  // truyền repo qua
  final FeedBackRepository feedbackRepository;


  @override
  Widget build(BuildContext context)
  {
    // lấy ra để sử dụng
    final userAccount = context.select((AuthenticationBloc bloc) => bloc.state.user);


    return BlocProvider(
      create: (context) => FeedbackBloc(feedbackRepository: feedbackRepository,user: userAccount),
      child: Send_Feedback(user: userAccount,),
    );
  }
}


class Send_Feedback extends StatefulWidget {
  const Send_Feedback({super.key, required this.user});

  final UserAccount user;

  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<Send_Feedback> {
  final _formSignInKey = GlobalKey<FormState>();

   // late là để chạy xong mới set
  late final TextEditingController _emailController;
  late final TextEditingController _chudeController;
  late final TextEditingController _noidungController;
  String imageUrl = '';

  @override
  void initState() {

    super.initState();
    _emailController = TextEditingController(text: widget.user.email);
    _chudeController = TextEditingController();
    _noidungController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _chudeController.dispose();
    _noidungController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
    final textColor = statusTheme ? Colors.white : Colors.black;
    final backgroundColor = statusTheme ? Colors.black : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gửi Feedback'),
      ),
      body: BlocListener<FeedbackBloc, FeedbackState>(
        listenWhen: (pre, cur) {
          return pre.statusFeedBack != cur.statusFeedBack;
        },
        listener: (context, state) {
          if (state.statusFeedBack == StatusFeedBack.loading) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const DialogLoadingAddProduct();// khi đang xử lí sẽ hiện nút loading
              },
            );
          } else if (state.statusFeedBack == StatusFeedBack.success) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã gửi phản hồi thành công!')));
            Navigator.popUntil(context, ModalRoute.withName('/HomeScreenPage'));
          } else if (state.statusFeedBack == StatusFeedBack.failure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(state.message)));
          }
        },
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: LayoutBuilder(
            builder: (context ,constraints){
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: REdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Form(
                      key: _formSignInKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : const AssetImage('assets/images/feedback.jpg') as ImageProvider<Object>, // Sử dụng AssetImage và ép kiểu ImageProvider<Object>
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: REdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            child: TextFormField(
                              readOnly: true, // không cho chỉnh sửa
                              onChanged: (value) => context.read<FeedbackBloc>().add(FeedBack_Email(value)),
                              controller: _emailController,
                              decoration: InputDecoration(
                                // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen )
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(color: textColor),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),

                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: REdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            child: TextFormField(
                              onChanged: (value) => context.read<FeedbackBloc>().add(FeedBack_ChuDe(value)),
                              decoration: InputDecoration(
                                // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen )
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "Chủ Đề",
                                labelStyle: TextStyle(color: textColor),
                                hintText: ('Nhập chủ đề'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Vui lòng nhập Chủ Đề";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: REdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            child: TextFormField(
                              onChanged: (value) => context.read<FeedbackBloc>().add(FeedBack_NoiDung(value)),
                              maxLines: 1,
                              decoration: InputDecoration(
                                // focusedBorder ( khi nhấn vô sẽ thay đổi khung qua màu đen )
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: ('Nội dung'),
                                labelStyle: TextStyle(color: textColor),
                                hintText: ('Nhập nội dung'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Vui lòng nhập Nội Dung";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: double.infinity,
                            margin:
                            REdgeInsets.symmetric(horizontal: 40, vertical: 23),
                            child: ElevatedButton.icon(
                              label: Text(
                                "Gửi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18.sp),
                              ),
                              icon: Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                                size: 22.sp,
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.grey),
                              onPressed: () {
                                // validate(): Xác thực tất cả các trường biểu mẫu và trả về true nếu tất cả đều hợp lệ.
                                if (_formSignInKey.currentState!.validate()) {
                                  context.read<FeedbackBloc>().add(const FeedBackRequested());
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
