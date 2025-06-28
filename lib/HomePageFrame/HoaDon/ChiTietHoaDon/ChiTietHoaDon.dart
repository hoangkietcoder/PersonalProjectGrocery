import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../Compoents/Dialog/dialog_delete_detailproduct_bill.dart';
import '../../../Main_Bloc/main_bloc.dart';

class ChiTietHoaDonPage extends StatelessWidget {
  const ChiTietHoaDonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChiTietHoaDonView();
  }
}

class ChiTietHoaDonView extends StatefulWidget {
  const ChiTietHoaDonView({super.key});

  @override
  State<ChiTietHoaDonView> createState() => ChiTietHoaDonViewState();
}

class ChiTietHoaDonViewState extends State<ChiTietHoaDonView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blueAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Chi Tiết Hóa Đơn",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
          final textColor = statusTheme ? Colors.white : Colors.black;
        return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, right: 18, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hóa Đơn 1",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Mã hóa đơn: ",
                          style: TextStyle(fontSize: 15.sp,color: textColor),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 5),
                        ),
                        TextSpan(
                          text: "#2121212",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Ngày tạo đơn: ",
                          style:
                              TextStyle(fontSize: 14.sp,color: textColor),
                        ),
                        TextSpan(
                          text: "10-07-2024",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            const CustomDivider(),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Tên SP",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Số lượng',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Đơn giá",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Thành Tiền",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            SlidableAutoCloseBehavior(
              closeWhenOpened: true, // khi kéo cái khác thì cái khác trước sẽ đóng
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // không cho phép cuộn
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  REdgeInsets.only(bottom: 20.0), // Khoảng cách giữa các dòng
                      child: Container(
                        width: double.infinity,
                        height: 20.h,
                        child: Slidable(
                            endActionPane: ActionPane // kéo từ phải trang trái
                            (
                              motion: const BehindMotion(),
                              children: [
                                // chức năng sửa
                                SlidableAction(
                                  onPressed: (context) {},
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                ),
                                // chức năng xóa
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const DialogDeleteDetailProductlBill();
                                      },
                                    );
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Chuối",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "10.000đ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "20.000đ",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 5.h),
            Divider(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Text(
                    "Tổng thành tiền:",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Text(
                    "40.000đ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Text(
              "Mô tả:",
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "Chúc quý khách vui vẻ, hẹn gặp lại",
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(height: 15.h),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "In",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                icon: Icon(
                  Icons.print,
                  color: Colors.white,
                  size: 20.sp,
                ),
                style: ElevatedButton.styleFrom(
                  padding: REdgeInsets.symmetric(vertical: 7, horizontal: 90),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      );
  },
),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h, // Độ dày của đường kẻ
      color: Colors.grey, // Màu sắc của đường kẻ
      margin: REdgeInsets.fromLTRB(1.0, 0, 3.0, 0),
    );
  }
}
