import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../Compoents/Dialog/dialog_loading_login.dart';
import '../../../Repository/Bill/bill_repository.dart';
import 'bloc/themhoadon_bloc.dart';

class ThemHoaDonPage extends StatelessWidget {
  final String date;
  final BillRepository billRepository;
  const ThemHoaDonPage({super.key, required this.date, required this.billRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ThemhoadonBloc(date: date, billRepo: billRepository),
      child: ThemHoaDonView(date: date),
    );
  }
}


class ThemHoaDonView extends StatefulWidget {
  final String date;
  const ThemHoaDonView({super.key, required this.date});

  @override
  State<ThemHoaDonView> createState() => _ThemHoaDonViewState();
}

class _ThemHoaDonViewState extends State<ThemHoaDonView> {

  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _createNameBillController = TextEditingController();
  final TextEditingController _createNameSellerController = TextEditingController();
  final TextEditingController _createNameBuyerController = TextEditingController();
  final TextEditingController _createDateBillNameController = TextEditingController();
  final TextEditingController _createTotalPriceController = TextEditingController();
  final TextEditingController _createNoteBillController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');


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
          context.read<ThemhoadonBloc>().add(CreateDateBill(dateStr));
        }
    });
  }

  @override
  void dispose() {
    _createNameBillController.dispose();
    _createNameSellerController.dispose();
    _createNameBuyerController.dispose();
    _createDateBillNameController.dispose();
    _createTotalPriceController.dispose();
    _createNoteBillController.dispose();
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
          "Thêm Hóa Đơn",
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<ThemhoadonBloc, ThemhoadonState>(
        listenWhen: (pre, cur) {return pre.billStatus != cur.billStatus;
        },
        listener: (context, state) {
          if (state.billStatus == BillStatus.loading) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const DialogLoadingLogin(); // khi đang xử lí sẽ hiện nút loading
              },
            );
          }else if(state.billStatus == BillStatus.successful){
            // navigator đúng khi xóa hết mấy trang trước đi dùng pushNamedAndRemoveUntil
            // Navigator.pushNamedAndRemoveUntil(context, "/HomeScreenPage", (route) => false); // false là xóa , true là k xóa

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Thêm hóa đơn thành công!')));
            Future.delayed(Duration(seconds: 1));

            // vì do realtime rồi nên chỉ cần popuntil về thôi
            Navigator.popUntil(context, ModalRoute.withName('/HomeScreenPage'));


          } else {
            if (state.billStatus == BillStatus.failure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Text(state.message,)));
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
                  "Thông tin hóa đơn",
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10.h,),
                Image(image: AssetImage("assets/images/bill_icon.png",),height: 100.h,width: 100.w,),
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
                          onChanged: (value) => context.read<ThemhoadonBloc>().add(CreateNameBill(value)), // lưu thay đổi vào state
                          controller: _createNameBillController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Tên Hóa Đơn";
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
                              "Tên hóa đơn",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập tên hóa đơn',
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
                          onChanged: (value) => context.read<ThemhoadonBloc>().add((CreateNameSellerBill(value))), // lưu thay đổi vào state
                          controller: _createNameSellerController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Người Bán";
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
                              "Người Bán",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập người bán',
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
                          onChanged: (value) => context.read<ThemhoadonBloc>().add(CreateNameBuyerBill(value)), // lưu thay đổi vào state
                          controller: _createNameBuyerController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Người Mua";
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
                              "Người Mua",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập người mua',
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
                            "Ngày bắt đầu",
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
                          keyboardType: TextInputType.number, // chỉ đc nhập số
                          // maxLines: 1, // tối đa 1 dòng
                          onChanged: (value) => context.read<ThemhoadonBloc>().add(CreateTotalPriceBill(value)), // lưu thay đổi vào state

                          controller:_createTotalPriceController, // đăng kí dùng controller
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Vui lòng nhập Thành Tiền";
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
                              "Thành Tiền",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập thành tiền',
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
                          onChanged: (value) => context.read<ThemhoadonBloc>().add(CreateNoteBill(value)),// lưu thay đổi vào state
                          controller: _createNoteBillController, // đăng kí dùng controller
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            label: const Text(
                              "Chú thích hóa đơn ( nếu có )",
                              style: TextStyle(color: Colors.black),
                            ),
                            hintText: 'Nhập chú thích hóa đơn ( nếu có )',
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
                          ), ),

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
                                context.read<ThemhoadonBloc>().add(const CreateBillRequested());
                              }
                            },
                            label: Text(
                              "Thêm Hóa Đơn",
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
