import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import '../../../Compoents/Dialog/dialog_loading_addproduct.dart';
import '../../../Repository/Firebase_Database/Product/product_repository.dart';
import 'bloc/themsanpham_bloc.dart';

class ThemSanPhamPage extends StatelessWidget {
  const ThemSanPhamPage({super.key, required this.productRepository});

  // truyền repo qua
  final ProductRepository productRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemsanphamBloc(productRepository: productRepository),
      child: const ThemSanPhamView(),
    );
  }
}

class ThemSanPhamView extends StatefulWidget {
  const ThemSanPhamView({super.key});

  @override
  State<ThemSanPhamView> createState() => _ThemSanPhamViewState();
}

class _ThemSanPhamViewState extends State<ThemSanPhamView> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _createNameController = TextEditingController();
  final TextEditingController _createQuantityController =
      TextEditingController();
  final TextEditingController _createPriceController = TextEditingController();
  final TextEditingController _createSupplierNameController =
      TextEditingController();
  final TextEditingController _createPhoneSupplierController =
      TextEditingController();
  final TextEditingController _createNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _createNameController.dispose();
    _createQuantityController.dispose();
    _createPriceController.dispose();
    _createSupplierNameController.dispose();
    _createPhoneSupplierController.dispose();
    _createNoteController.dispose();
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
          statusBarIconBrightness:
          Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Thêm Sản Phẩm",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<ThemsanphamBloc, ThemsanphamState>(
        listenWhen: (pre, cur) {
          return pre.statusSubmit != cur.statusSubmit;
        },
        listener: (context, state) {
          if (state.statusSubmit == CreateStatus.loading) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const DialogLoadingAddProduct(); // khi đang xử lí sẽ hiện nút loading
              },
            );
          }else if(state.statusSubmit == CreateStatus.success){
            // navigator đúng khi xóa hết mấy trang trước đi dùng pushNamedAndRemoveUntil
           // Navigator.pushNamedAndRemoveUntil(context, "/HomeScreenPage", (route) => false); // false là xóa , true là k xóa
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Thêm sản phẩm thành công!')));
            // vì do realtime rồi nên chỉ cần popuntil về thôi
            Navigator.popUntil(context, ModalRoute.withName('/HomeScreenPage'));

          } else {
            if (state.statusSubmit == CreateStatus.failure) {
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
                  height: 15.h,
                ),
                Text(
                  "Thông tin sản phẩm",
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Stack(children: [
                  Container(
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundImage: const AssetImage("assets/images/avamacdinhsanpham.jpg"),

                    ),
                  ),
                ]),
                Container(
                  // height: MediaQuery.of(context).size.height - 150.h, // Chiều cao còn lại
                  padding: REdgeInsets.fromLTRB(25.0, 40.0, 25.0, 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0.r),
                      topLeft: Radius.circular(40.0.r),
                    ),
                  ),
                  child: Form(
                    key: _formSignInKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        TextFormField(
                          onChanged: (value) => context.read<ThemsanphamBloc>().add(CreateNameProduct(value)), // lưu thay đổi vào state
                          controller: _createNameController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Tên Sản Phẩm";
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
                              "Tên sản phẩm",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập tên sản phẩm',
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
                          inputFormatters: [CurrencyInputFormatterPrice(locale: "en_US")],
                          keyboardType: TextInputType.number,
                          onChanged: (value) => context
                              .read<ThemsanphamBloc>()
                              .add(CreateQuantityProduct(
                                  value)), // lưu thay đổi vào state
                          controller:
                              _createQuantityController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Số Lượng";
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
                              "Số lượng",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập số lượng sản phẩm',
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
                          keyboardType: TextInputType.number, // chỉ đc nhập số
                          // inputFormatters dùng để kiểm soát và định dạng dữ liệu người dùng nhập vào TextFormField
                          inputFormatters: [CurrencyInputFormatterPrice(locale: "vi_VN")],
                          onChanged: (value) {
                            // Loại bỏ dấu "." để có giá trị thật sự
                            final rawValue = value.replaceAll('.', '');
                            context.read<ThemsanphamBloc>().add(CreatePriceProduct(rawValue));// lưu thay đổi vào state
                          },
                          controller: _createPriceController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Giá Sản Phẩm";
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
                              "Giá sản phẩm",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập giá sản phẩm',
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
                          onChanged: (value) => context.read<ThemsanphamBloc>().add(CreateSupplierNameProduct(
                                  value)), // lưu thay đổi vào state
                          controller:
                              _createSupplierNameController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Tên nhà cung cấp";
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
                              "Tên nhà cung cấp",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập tên nhà cung cấp',
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
                          keyboardType: TextInputType.number, // chỉ đc nhập số
                          maxLines: 1, // tối đa 1 dòng
                          onChanged: (value) => context.read<ThemsanphamBloc>().add(CreatePhoneSupplierProduct(
                                  value)), // lưu thay đổi vào state
                          controller:
                              _createPhoneSupplierController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Số điện thoại nhà cung cấp";
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
                              "Số điện thoại nhà cung cấp",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập số điện thoại nhà cung cấp',
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
                          minLines: 1,
                          maxLines: 3, // số dòng tối đa cho phép nhập
                          onChanged: (value) => context
                              .read<ThemsanphamBloc>()
                              .add(CreateNoteProduct(
                                  value)), // lưu thay đổi vào state
                          controller:
                              _createNoteController, // đăng kí dùng controller
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            label: const Text(
                              "Chú thích sản phẩm ( nếu có )",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập chú thích sản phẩm ( nếu có )',
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
                        SizedBox(height: 15.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
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
                                context.read<ThemsanphamBloc>().add(const CreateProductRequested());
                              }
                            },
                            label: Text(
                              "Thêm",
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
        ),
      ),
    );
  }
}
