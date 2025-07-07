import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Compoents/Dialog/dialog_delete_bill.dart';


class HuyDonPage extends StatelessWidget {
  const HuyDonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HuyDonView();
  }
}

class HuyDonView extends StatefulWidget {
  const HuyDonView({super.key});

  @override
  State<HuyDonView> createState() => _HuyDonViewState();
}

class _HuyDonViewState extends State<HuyDonView> {



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
        Expanded(
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              // final item = items[index];
              return Container(
                margin: REdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                    border: Border.all( // thay đổi màu viền cho list hóa đơn
                        width: 0.5,
                        color: Colors.black
                    )
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                            BorderRadius.circular(10.r),
                          ),
                          padding: REdgeInsets.symmetric(vertical: 5, horizontal: 11),
                          child: Text(
                            "Hủy Đơn",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hóa đơn: ',
                                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                              ),
                              TextSpan(
                                text: "#HD17534929",
                                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Khách hàng: ',
                                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                              ),
                              TextSpan(
                                text: "Hoàng Kiệt",
                                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tổng tiền: ',
                                style: TextStyle(color: Colors.black, fontSize: 15.sp,fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "199.000 VNĐ",
                                style: TextStyle(color: Colors.red, fontSize: 15.sp),
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
                                          text: "30-8-2024",
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
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Ngày kết thúc:',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text:'30-12-2025',
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
                                          text: "#HD158094830",
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
                                          text: "Tống Hoàng Kiệt",
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
                                          text: "Hóa đơn này chưa tính tiền",
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
        ),
      ],
    );
  }
}





