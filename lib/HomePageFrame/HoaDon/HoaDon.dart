import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../Compoents/Dialog/dialog_loading_login.dart';
import '../../Constant/enum.dart';
import '../../Repository/Bill/bill_repository.dart';
import '../../Routes/argument/ThemHoaDonArgument.dart';
import 'HoaDonChuaThanhToan/HoaDonChuaThanhToan.dart';
import 'HoaDonChuaThanhToan/bloc/chua_thanh_toan_bloc.dart';
import 'HoaDonDaThanhToan/HoaDonDaThanhToan.dart';
import 'HoaDonDaThanhToan/bloc/hoa_don_da_thanh_toan_bloc.dart';
import 'HuyDon/HuyDon.dart';

class HoaDonPage extends StatelessWidget {
  const HoaDonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final billRepo = RepositoryProvider.of<BillRepository>(context);
    return MultiBlocProvider(providers: [
      BlocProvider<ChuaThanhToanBloc>(
        create: (BuildContext context) => ChuaThanhToanBloc(billrepo: billRepo)..add(CreateBillChange()),
      ),
      BlocProvider<HoaDonDaThanhToanBloc>(
        create: (BuildContext context) => HoaDonDaThanhToanBloc(billRepository: billRepo)..add(HoaDonDaThanhToanSubscriptionRequested()),
      ),
    ],
    child: const HoaDonView());
  }
}

class HoaDonView extends StatefulWidget {
  const HoaDonView({super.key});

  @override
  State<HoaDonView> createState() => _LichSuHoaDonViewState();
}

class _LichSuHoaDonViewState extends State<HoaDonView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.blueAccent,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            toolbarHeight: 55.h,
            centerTitle: true,
            title: Text(
              "HÓA ĐƠN",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueAccent,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(child: Text("Chưa Thanh Toán",style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                ),),),
                Tab(child: Text("Đã Thanh Toán",style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),),
                Tab(child: Text("Hủy Đơn",style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),),
              ],
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<HoaDonDaThanhToanBloc, HoaDonDaThanhToanState>(
                listenWhen: (pre, cur) => pre.statusThanhToan != cur.statusThanhToan,
                listener: (context, state) {
                  if(state.statusThanhToan == StatusSubmit.isProcessing){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const DialogLoadingLogin(); // khi đang xử lí sẽ hiện nút loading
                      },
                    );
                  }else if(state.statusThanhToan == StatusSubmit.failure){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            state.msg,
                          )));
                  }else if(state.statusThanhToan == StatusSubmit.success){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            state.msg,
                          )));
                  }
                },
              ),
            ],
            child: TabBarView(
              children: [
                // vì đã tạo repo Bill cho toàn app nên chỉ cần RepositoryProvider.of<BillRepository>(context) lấy ra xài
                HoaDonChuaThanhToanPage(),
                HoaDonDaThanhToanPage(),
                HuyDonPage(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[300],
            onPressed: () {
              final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
              final argument = ThemHoaDonArgument(BillRepository(), date: date,);
              Navigator.pushNamed(context, '/ThemHoaDon', arguments: argument);
            },
            shape: const CircleBorder(),
            tooltip: 'Thêm hóa đơn mới',
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

}


