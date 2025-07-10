import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Authentication/bloc/authentication_bloc.dart';
import '../../../Compoents/UploadImage/upload_image.dart';
import '../../../Main_Bloc/main_bloc.dart';
import '../../../Models/Register/register_user.dart';
import '../../../Repository/CapNhatThongTin/CapNhatThongTin_repository.dart';
import '../../../Repository/Login/Model/User.dart';
import 'bloc/cap_nhat_thong_tin_bloc.dart';

class CapNhatThongTinPage extends StatelessWidget {
  const CapNhatThongTinPage({super.key, required this.capnhatthongtinRepository});

  // truyền repo qua
  final CapnhatthongtinRepository capnhatthongtinRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CapNhatThongTinBloc(CapnhatRepo: capnhatthongtinRepository)..add(LoadUserInfoEvent()),
      child: CapNhatThongTinView(),
    );
  }
}

class CapNhatThongTinView extends StatefulWidget {
  const CapNhatThongTinView({
    super.key,
  });

  @override
  State<CapNhatThongTinView> createState() => _CapNhatThongTinViewState();
}

class _CapNhatThongTinViewState extends State<CapNhatThongTinView> {
  // late là để chạy xong mới set
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final _formSignInKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    //  Khởi tạo controller mặc định ban đầu
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    // Gọi sự kiện để load dữ liệu từ Firestore
    context.read<CapNhatThongTinBloc>().add(LoadUserInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // quan trọng để bắt sự kiện ở cả vùng không có widget
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.blueAccent,
              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<CapNhatThongTinBloc, CapNhatThongTinState>(
                  builder: (context, state) {
                    final infomation = state.model;
                    print("đưaađa ${infomation.img_url_Info}");
                  return Stack(children: [
                  Container(
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundImage:  infomation.img_url_Info.isNotEmpty ?  NetworkImage(infomation.img_url_Info) : AssetImage("assets/images/feedback.jpg")  as ImageProvider,
                    ),
                  ),
                  Positioned(
                    left: 85,
                    bottom: -13,
                    right: -5.0, // kéo qua phải
                    child: IconButton(
                      onPressed: () async {
                        final productId = state.model!.id;
                        final bool? fromCamera = await showImagePickerOptions(context, productId);
                        if (fromCamera != null) {
                          final XFile? pickedFile = await ImagePicker().pickImage(
                            source: fromCamera ? ImageSource.camera : ImageSource.gallery,
                          );
          
                          if (pickedFile != null) {
                            final File imageFile = File(pickedFile.path);
          
                            context.read<CapNhatThongTinBloc>().add(UploadImageEvent(
                                imageFile: imageFile,
                                ProductId: productId,
                              ),
                            );
                          }
                        }
                      },
                      icon:  Icon(
                        Icons.camera_alt,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                ]);
            },
          ),
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
                  // BlocConsumer dùng để thông báo khi cập nhật thành công và thất bại
                  child:
                      BlocConsumer<CapNhatThongTinBloc, CapNhatThongTinState>(
                        listenWhen: (pre , cur ) => pre.statusLoadInfo != cur.statusLoadInfo,
                      listener: (context, state) {
                      if (state.statusLoadInfo == StatusLoadInfo.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(' Load dữ liệu thành công')),
                        );
                      } else if (state.statusLoadInfo == StatusLoadInfo.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(' Load dữ liệu thất bại')),
                        );
                      }
          
                      // Gán dữ liệu vào controller mỗi khi state thay đổi
                      _nameController.text = state.model.name;
                      _emailController.text = state.model.email;
                      _phoneController.text = state.model.phoneNumber;
                    },
                    builder: (context, state) {
                      return Form(
                        key: _formSignInKey,
                        child: Column(
                          children: [
                            Text(
                              "Thông Tin Của Bạn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              readOnly: true, // không cho chỉnh sửa
                              // tắt ẩn hiện nội dung
                              obscureText: false,
                              // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                              controller:
                              _emailController, // đăng kí dùng controller
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
                              // tắt ẩn hiện nội dung
                              obscureText: false,
                              // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                              controller:
                              _nameController, // đăng kí dùng controller
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
                              keyboardType: TextInputType.number,
                              // tắt ẩn hiện nội dung
                              obscureText: false,
                              // onChanged: (value) => context.read<DoiMatKhauBloc>().add(ChangeOldPassword(value)), // lưu thay đổi vào state
                              controller:
                                  _phoneController, // đăng kí dùng controller
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
                            BlocConsumer<CapNhatThongTinBloc, CapNhatThongTinState>(
                              listenWhen: (previous, current) => previous.statusCapNhatInfo != current.statusCapNhatInfo,
                              listener: (context, state) {
                                if (state.statusCapNhatInfo == StatusCapNhatInfo.success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("✅ Cập nhật thành công")),
                                  );
                                  // ✅ Trả model cập nhật về lại màn hình trước
                                  Navigator.pop(context, state.model);
                                } else if (state.statusCapNhatInfo == StatusCapNhatInfo.failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("❌ Cập nhật thất bại")),
                                  );
                                }
                                  },
                              builder: (context, state) {
                                return SizedBox(
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
                                        context.read<CapNhatThongTinBloc>().add(UpdateUserInfoEvent(
                                       name: _nameController.text,
                                       phoneNumber: _phoneController.text));
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
                            );
            },
          ),
                            SizedBox(height: 13.h),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
