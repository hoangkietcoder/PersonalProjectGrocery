import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Compoents/Dialog/dialog_delete_bill.dart';
import '../HoaDonDaThanhToan/bloc/hoa_don_da_thanh_toan_bloc.dart';
import 'bloc/chua_thanh_toan_bloc.dart';

class HoaDonChuaThanhToanPage extends StatelessWidget {
  const HoaDonChuaThanhToanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HoaDonChuaThanhToanView();
  }
}

class HoaDonChuaThanhToanView extends StatefulWidget {
  const HoaDonChuaThanhToanView({super.key});

  @override
  State<HoaDonChuaThanhToanView> createState() =>
      _HoaDonChuaThanhToanViewState();
}

class _HoaDonChuaThanhToanViewState extends State<HoaDonChuaThanhToanView> {
  @override
  Widget build(BuildContext context) {
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
                  onChanged: (value) => context.read<ChuaThanhToanBloc>().add(SearchBillChuaThanhToanEventChange(value)), // lưu thay đổi vào state, để tìm kiếm sản phẩm
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
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
        BlocBuilder<ChuaThanhToanBloc, ChuaThanhToanState>(
          buildWhen: (pre, cur) => pre.statusBill != cur.statusBill,
          builder: (context, state) {
            if (state.statusBill == StatusChuaThanhToan.initial) {
              return Center(child: const CircularProgressIndicator());
            }
            return BlocBuilder<ChuaThanhToanBloc, ChuaThanhToanState>(
              buildWhen: (pre, cur) =>
                  pre.lstBillChuaThanhToan != cur.lstBillChuaThanhToan,
              builder: (context, state) {
                final bill = state.modelChuathanhtoan;
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.lstBillChuaThanhToan.length,
                    itemBuilder: (context, index) {
                      // lấy trong danh sách phù hợp theo từng index
                      final billchuathanhtoan = state.lstBillChuaThanhToan[index];
                      return Container(
                        margin: REdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
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
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: REdgeInsets.symmetric(
                                      vertical: 5, horizontal: 11),
                                  child: Text(
                                    "Chưa Tính Tiền",
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
                                            color: Colors.black,
                                            fontSize: 15.sp),
                                      ),
                                      TextSpan(
                                        text: billchuathanhtoan.nameBill,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp),
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
                                            color: Colors.black,
                                            fontSize: 15.sp),
                                      ),
                                      TextSpan(
                                        text: billchuathanhtoan.nameBuyer,
                                        style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 17.sp,
                                        ),
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
                                        ),
                                      ),
                                      TextSpan(
                                        text: billchuathanhtoan.totalPriceBill,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
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
                                                  text: billchuathanhtoan.date,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  text:
                                                      billchuathanhtoan.idBill,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  text: billchuathanhtoan
                                                      .nameSeller,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  text: billchuathanhtoan
                                                      .noteBill,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                size: 15.sp,
                                                color: Colors.white),
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
                                              final bloc = context.read<ChuaThanhToanBloc>();
                                              showDialog<bool>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const DialogDeleteBill();
                                                },
                                              ).then((value) {
                                                if (value != null && value) {
                                                  bloc.add(DeleteBillChuaThanhToan(bill.idDocBill,state.lstBillChuaThanhToan.length));
                                                  print("ID được truyền: ${bill.idDocBill}");
                                                  Navigator.pushNamedAndRemoveUntil(context, '/HoaDon',(route) => false); // false là xóa , true là k xóa
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.delete,
                                                size: 15.sp,
                                                color: Colors.white),
                                            label: Text('Xóa',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.white)),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                             context.read<HoaDonDaThanhToanBloc>().add(SubmitHoaDonDaThanhToan(billchuathanhtoan));
                                            },
                                            icon: Icon(Icons.check,
                                                size: 15.sp,
                                                color: Colors.white),
                                            label: Text('TToán',
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.white)),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                          ),
                                        ),
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
      ],
    );
  }
}
