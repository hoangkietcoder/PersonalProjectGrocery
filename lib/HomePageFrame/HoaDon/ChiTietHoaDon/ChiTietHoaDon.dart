import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personalprojectgrocery/Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import 'package:personalprojectgrocery/Repository/Bill/bill_repository.dart';
import '../../../Compoents/Dialog/dialog_delete_detailproduct_bill.dart';
import '../../../Main_Bloc/main_bloc.dart';
import '../HoaDonChuaThanhToan/Model/model_chuathanhtoan.dart';
import 'bloc/chi_tiet_hoa_don_bloc.dart';

class ChiTietHoaDonPage extends StatelessWidget {
  const ChiTietHoaDonPage({super.key, required this.billRepository, required this.idBill});

  final BillRepository billRepository;
  final String idBill;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => ChiTietHoaDonBloc(billRepo: billRepository)..add(FetchChiTietHoaDonEvent(idBill)),
  child: ChiTietHoaDonView(),
);
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
        return BlocBuilder<ChiTietHoaDonBloc, ChiTietHoaDonState>(
          builder: (context, state) {
            final BillDetail = state.modelChuathanhtoan;


            if (BillDetail == null || BillDetail.isEmpty) {
              return const Center(child: CircularProgressIndicator()); // hoặc hiển thị "Không có dữ liệu"
            }
            final totalPrice = BillDetail!.totalPriceBill;
            final formatTotalPrice = formatCurrencyVN(totalPrice);

          return SingleChildScrollView(
        padding:  REdgeInsets.only(top: 20, right: 18, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hóa đơn: ${BillDetail?.nameBill}",
                style: TextStyle(fontSize: 14.sp, )),
            SizedBox(height: 10.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Mã hóa đơn: ",
                        style: TextStyle(fontSize: 14.sp, color: textColor),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: BillDetail?.idBillRandom ?? '',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h), // khoảng cách giữa 2 dòng
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Ngày tạo đơn: ",
                            style: TextStyle(fontSize: 14.sp, color: textColor),
                          ),
                          TextSpan(
                            text: BillDetail?.date ?? '',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Thời gian: ",
                            style: TextStyle(fontSize: 14.sp, color: textColor),
                          ),
                          TextSpan(
                            text: BillDetail?.date ?? '',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h), // khoảng cách giữa 2 dòng
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Người bán: ",
                        style: TextStyle(fontSize: 14.sp, color: textColor),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: BillDetail?.nameSeller,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h), // khoảng cách giữa 2 dòng
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Người mua: ",
                        style: TextStyle(fontSize: 14.sp, color: textColor),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 5),
                      ),
                      TextSpan(
                        text: BillDetail?.nameBuyer,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // không cho phép cuộn
                itemCount: BillDetail?.listProducts.length ?? 0,
                itemBuilder: (context, index) {
                  final product = BillDetail!.listProducts[index];
                  final totalPrice = state.modelChuathanhtoan?.totalPriceBill;
                  final name = product['nameProduct'] ?? "";
                  final quantityProduct = product['quantityProduct'] ?? "";
                  final priceProduct = product['priceProduct'] ?? "";



                  final quantity = int.tryParse(product['quantityProduct']?.toString() ?? "0") ?? 0;
                  final price = int.tryParse(product['priceProduct']?.toString() ?? "0") ?? 0;

                  final thanhTien = quantity * price;

                  final formattedPrice = formatCurrencyVN(price.toString());
                  final formattedThanhTien = formatCurrencyVN(thanhTien.toString());

                  return Padding(
                    padding:  REdgeInsets.only(bottom: 20.0), // Khoảng cách giữa các dòng
                    child: Container(
                      width: double.infinity,
                      height: 20.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              name,
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
                                quantityProduct,
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
                                formattedPrice,
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
                              formattedThanhTien,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
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
                    formatTotalPrice,
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
              BillDetail?.noteBill ?? "Không có ghi chú",
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(height: 15.h),
            // Center(
            //   child: ElevatedButton.icon(
            //     onPressed: () {},
            //     label: Text(
            //       "In",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16.sp,
            //       ),
            //     ),
            //     icon: Icon(
            //       Icons.print,
            //       color: Colors.white,
            //       size: 20.sp,
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       padding: REdgeInsets.symmetric(vertical: 7, horizontal: 90),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20.r),
            //       ),
            //       backgroundColor: Colors.blueAccent,
            //     ),
            //   ),
            // ),
          ],
        ),
      );
  },
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
