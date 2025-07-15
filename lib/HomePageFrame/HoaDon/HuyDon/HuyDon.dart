import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Compoents/speech_to_text/SpeechToTextService.dart';
import '../../../Main_Bloc/main_bloc.dart';
import 'bloc/huy_don_bloc.dart';


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
      context.read<HuyDonBloc>().add(SearchBillDaHuyEventChange(text));
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
                  onChanged: (value) => context.read<HuyDonBloc>().add(SearchBillDaHuyEventChange(value)),
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
                    hintText: 'Tìm hủy đơn theo tên ...',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                    ),
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
        BlocBuilder<HuyDonBloc, HuyDonState>(
        buildWhen: (pre , cur ){
          return pre.statusBillDaHuy != cur.statusBillDaHuy ||
              pre.statusBillSearch != cur.statusBillSearch ||
              pre.lsBillDaHuy != cur.lsBillDaHuy;
        },
        builder: (context, state) {
          //  Hiển thị loading khi đang load danh sách ban đầu
          if (state.statusBillDaHuy == StatusBillDaHuy.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          // Hiển thị loading riêng khi đang search
          if (state.statusBillSearch == StatusBillSearch.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          //  Nếu không có dữ liệu
          if (state.lsBillDaHuy.isEmpty) {
            return const Center(child: Text("Không có hóa đơn bị hủy nào."));
          }

          return Expanded(
          child: ListView.builder(
            itemCount: state.lsBillDaHuy.length,
            itemBuilder: (context, index) {
              final item = state.lsBillDaHuy[index];
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
                                text: item.nameBill,
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
                                text: item.nameBuyer,
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
                                text: item.totalPriceBill,
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
        ),
      ],
    );
  }
}





