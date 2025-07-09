import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/HomePageFrame/HoaDon/HuyDon/bloc/huy_don_bloc.dart';
import '../../../Compoents/Dialog/dialog_delete_bill.dart';
import '../../../Constant/enum.dart';
import '../../../Main_Bloc/main_bloc.dart';
import 'bloc/hoa_don_da_thanh_toan_bloc.dart';

class HoaDonDaThanhToanPage extends StatelessWidget {
  const HoaDonDaThanhToanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HoaDonChuaDaThanhToanView();
  }
}

class HoaDonChuaDaThanhToanView extends StatefulWidget {
  const HoaDonChuaDaThanhToanView({super.key});

  @override
  State<HoaDonChuaDaThanhToanView> createState() =>
      _HoaDonDaThanhToanViewState();
}

class _HoaDonDaThanhToanViewState extends State<HoaDonChuaDaThanhToanView> {
  @override
  Widget build(BuildContext context) {
    final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
    final cardSearchColor = statusTheme ? Colors.grey[900] : Colors.white;
    return Column(
      children: [
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Padding(
                padding: REdgeInsets.only(right: 8.0, left: 8.0),
                child: TextField(
                  onChanged: (value) => context.read<HoaDonDaThanhToanBloc>().add(SearchBillDaThanhToanEventChange(value)),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: cardSearchColor,
                    contentPadding: REdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 3,
                    ),
                    hintText: 'Tìm kiếm hóa đơn ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // _openFilterDrawer(),
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
          BlocListener<HoaDonDaThanhToanBloc, HoaDonDaThanhToanState>(
            listenWhen: (pre , cur ) => pre.statusSubmitDeleteBillDaThanhToan != cur.statusSubmitDeleteBillDaThanhToan,
            listener: (context, state) {
              if(state.statusSubmitDeleteBillDaThanhToan == StatusSubmitDeleteBillDaThanhToan.successful)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Hủy hóa đơn thành công!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.fixed
                  ));
                  // ✅ Reset trạng thái để lần sau vẫn hiện lại được
                  context.read<HoaDonDaThanhToanBloc>().add(resetStatusDeleteNotification());
                }
              },
          child: BlocBuilder<HoaDonDaThanhToanBloc, HoaDonDaThanhToanState>(
            buildWhen: (pre, cur){
              return pre.statusThanhToan != cur.statusThanhToan ||
                  pre.lsBillDaThanhToan != cur.lsBillDaThanhToan ||
                  pre.statusSubmitDeleteBillDaThanhToan != cur.statusSubmitDeleteBillDaThanhToan ||// nếu muốn thêm search
                  pre.statusBillSearchDaThanhToan != cur.statusBillSearchDaThanhToan;
            },
            builder: (context, state) {
              if (state.statusBillSearchDaThanhToan == StatusBillSearchDaThanhToan.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.statusBillSearchDaThanhToan == StatusBillSearch.failure) {
                return const Center(child: Text("Tìm kiếm thất bại!"));
              }

              if (state.lsBillDaThanhToan.isEmpty && state.lsBillDaThanhToan == StatusBillSearch.successful) {
                return const Center(child: Text("Không tìm thấy hóa đơn nào."));
              }



              return BlocBuilder<HoaDonDaThanhToanBloc, HoaDonDaThanhToanState>(
                buildWhen: (pre, cur) => pre.lsBillDaThanhToan != cur.lsBillDaThanhToan,
                builder: (context, state) {
                  return Expanded(
                child: ListView.builder(
                  itemCount: state.lsBillDaThanhToan.length,
                  itemBuilder: (context, index) {
                    final item = state.lsBillDaThanhToan[index];
                    return Container(
                      margin:
                          REdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              // thay đổi màu viền cho list hóa đơn
                              width: 0.5,
                              color: Colors.black)),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: REdgeInsets.symmetric(
                                    vertical: 5, horizontal: 11),
                                child: Text(
                                  "Đã Tính Tiền",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hóa đơn: ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                    TextSpan(
                                      text: item.nameBill,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Khách hàng: ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                    TextSpan(
                                      text: item.nameBuyer,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Tổng tiền: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: item.totalPriceBill,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.expand_more,
                            size: 18.sp,
                          ),
                          children: <Widget>[
                            const Divider(color: Colors.grey),
                            ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Ngày tạo đơn:",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: item.date,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Mã hóa đơn: ',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: item.idBillRandom,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Người bán: ',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: item.nameSeller,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Số lượng vật phẩm: ',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "5",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Ghi chú: ',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: item.noteBill,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/ChiTietHoaDon');
                                          },
                                          icon: Icon(Icons.edit,
                                              size: 15.sp, color: Colors.white),
                                          label: Text('Xem',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            context.read<HoaDonDaThanhToanBloc>().add(DeleteBillDaThanhToan(item.idBill));
                                          },
                                          icon: Icon(Icons.delete,
                                              size: 15.sp, color: Colors.white),
                                          label: Text('Xóa',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
    },
  );
            },
          ),
  ),
      ],
    );
  }
}
