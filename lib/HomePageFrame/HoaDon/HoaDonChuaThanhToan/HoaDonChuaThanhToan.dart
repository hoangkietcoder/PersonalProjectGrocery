import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../Compoents/Dialog/dialog_auto_deleteBill.dart';
import '../../../Compoents/Dialog/dialog_delete_bill.dart';
import '../../../Compoents/speech_to_text/SpeechToTextService.dart';
import '../../../Main_Bloc/main_bloc.dart';
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


  final TextEditingController _controller = TextEditingController();
  final SpeechToTextService _speechService = SpeechToTextService();
  bool _isListening = false;

  // xử lí khi voice
  Future<void> _handleVoiceInput() async {
    final available = await _speechService.initSpeech();
    if (!available) return;

    setState(() => _isListening = true );

    await _speechService.startListening(onResult: (text) {
      setState(() {
        _isListening = false;
        _controller.text = text;
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
      });

      // Gửi kết quả tới BLoC
      context.read<ChuaThanhToanBloc>().add(SearchBillChuaThanhToanEventChange(text));
      setState(() => _isListening = false);

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


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
                  controller: _controller,
                  onChanged: (value) => context.read<ChuaThanhToanBloc>().add(SearchBillChuaThanhToanEventChange(value)), // lưu thay đổi vào state, để tìm kiếm sản phẩm
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: cardSearchColor,
                    suffixIcon: IconButton(icon: Icon(Icons.keyboard_voice) , onPressed: (){
                          _handleVoiceInput();
                       }),
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
          ],
        ),
        SizedBox(height: 10.h),
        BlocListener<ChuaThanhToanBloc, ChuaThanhToanState>(
        listenWhen: (pre , cur ) => pre.deleteStatusBill != cur.deleteStatusBill || pre.statusSubmitThanhToan != cur.statusSubmitThanhToan,
        listener: (context, state) {
          if(state.statusBillType == StatusBillType.delete &&
              state.deleteStatusBill == DeleteStatusBill.successful){
            showDialog(
              context: context,
              builder: (_) => const DialogAutoDeletebill(),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(); // Tự động đóng sau 2s
              }
            });
          }
          if(state.statusBillType == StatusBillType.submitPay &&
              state.statusSubmitThanhToan == StatusSubmitThanhToan.successful){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Thanh toán hóa đơn thành công!'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.fixed
            ));
            // ✅ Reset trạng thái để lần sau vẫn hiện lại được
            context.read<ChuaThanhToanBloc>().add(resetStatusNotification());
          }

          },
        child: BlocBuilder<ChuaThanhToanBloc, ChuaThanhToanState>(
          buildWhen: (pre, cur) => pre.statusBill != cur.statusBill,
          builder: (context, state) {
            if (state.statusBill == StatusChuaThanhToan.initial) {
              return Center(child: const CircularProgressIndicator());
            }
            if(state.statusBill == StatusChuaThanhToan.failure){
              return Center(child: Text("Lỗi: ${state.error}"));
            }
            return BlocBuilder<ChuaThanhToanBloc, ChuaThanhToanState>(
              buildWhen: (pre, cur) => pre.lstBillChuaThanhToan != cur.lstBillChuaThanhToan,
              builder: (context, state) {
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
                                                      billchuathanhtoan.idBillRandom,
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
                                                  text: billchuathanhtoan.nameSeller,
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
                                                  text: billchuathanhtoan.noteBill,
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
                                              Navigator.pushNamed(context, '/ChiTietHoaDon');
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
                                                if (value == true) {
                                                  print("dawdadaw  ${billchuathanhtoan.idBill}");
                                                  bloc.add(DeleteBillChuaThanhToan(billchuathanhtoan.idBill,index));
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
                                             context.read<ChuaThanhToanBloc>().add(PayBillChuaThanhToan(billchuathanhtoan.idBill ?? ''));
                                            },
                                            icon: Icon(Icons.check,
                                                size: 14.sp,
                                                color: Colors.white),
                                            label: Text('Thanh Toán',
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
),
      ],
    );
  }
}
