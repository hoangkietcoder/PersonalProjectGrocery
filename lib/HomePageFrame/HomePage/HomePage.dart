import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/ObjectBox/ObjectBox.dart';
import 'package:personalprojectgrocery/Repository/DataLocal/data_local_repository.dart';
import '../../ObjectBox/bloc_ModelProductLocal/model_product_local_bloc.dart';
import '../../Repository/DanhMuc/danhmuc_repository.dart';
import '../../Repository/Firebase_Database/Product/product_repository.dart';
import '../../Repository/Notification/notification_repository.dart';
import '../DanhMuc/DanhMuc.dart';
import '../DanhMuc/bloc/danhmuc_bloc.dart';
import '../HoaDon/HoaDon.dart';
import '../Home/Home.dart';
import '../Home/ThemSanPham/ThemSanPham.dart';
import '../Home/bloc_home/home_bloc.dart';
import '../ThongTin/ThongTin.dart';
import 'cubit/navbottom_cubit.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // thêm bloc cubit vào, RepositoryProvider
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider(
          create: (context) => DanhMucRepository(),
        ),

      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => NavbottomCubit(
                notificationRepository:
                    RepositoryProvider.of<NotificationRepository>(context))),
        BlocProvider(
            create: (context) =>
                HomeBloc(productRepository: context.read<ProductRepository>())),
        BlocProvider(
            create: (context) =>
                DanhmucBloc(danhmucRepository: context.read<DanhMucRepository>())),
        BlocProvider(
            create: (context) =>
                ModelProductLocalBloc(DataLocalRepository: context.read<DataLocalRepository>())),
      ], child: const HomeScreenView()),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // đổi màu status bar khi không có app bar
        statusBarColor: Colors.blueAccent,
        statusBarIconBrightness: Brightness.light, // android
        statusBarBrightness: Brightness.dark, //IOS ( bên IOS thì ngược statusbar )
      ),
      child: Scaffold(
        floatingActionButton: BlocBuilder<NavbottomCubit, NavbottomState>(
          buildWhen: (pre, cur) {
            return pre.index != cur.index;
          },
          builder: (context, state) {
            return state.index != 0
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.blue[300],
                    onPressed: () {
                      final productRepo = RepositoryProvider.of<ProductRepository>(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThemSanPhamPage(productRepository: productRepo)),
                      );
                    },
                    shape: const CircleBorder(),
                    tooltip: 'Thêm hàng',
                    child: const Icon(Icons.add, color: Colors.white),
                  );
          },
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<NavbottomCubit, NavbottomState>(
          buildWhen: (pre, cur) {
            return pre.index != cur.index;
          },
          builder: (context, state) {
            return SafeArea(
                child: [
              Home(productRepository: RepositoryProvider.of<ProductRepository>(context), dataLocalRepository: RepositoryProvider.of<DataLocalRepository>(context),),
              DanhMucPage(danhMucRepository: RepositoryProvider.of<DanhMucRepository>(context)),
              const HoaDonPage(),
              const ThongTinPage()
            ][state.index]);
          },
        ),
        bottomNavigationBar: BlocBuilder<NavbottomCubit, NavbottomState>(
          buildWhen: (pre, cur) {
            return pre.index != cur.index;
          },
          builder: (context, state) {
            return CurvedNavigationBar(
              backgroundColor: Colors.grey.shade100, // Tùy chỉnh màu nền của navigation bar
              color: Colors.blueAccent, // Màu của item được chọn
              buttonBackgroundColor:
                  Colors.blueAccent, // Màu của nút tròn ở giữa (nếu có)
              height: 50.h, // Chiều cao của navigation bar
              items: [
                CurvedNavigationBarItem(
                    child: Icon(
                      CupertinoIcons.home,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    label: 'Trang Chủ',
                    labelStyle: TextStyle(
                        fontSize: 12.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                CurvedNavigationBarItem(
                    child: const ImageIcon(
                      AssetImage("assets/images/category.png"),
                      color: Colors.white,
                    ),
                    label: 'Danh Mục',
                    labelStyle: TextStyle(
                        fontSize: 12.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                CurvedNavigationBarItem(
                    child: const ImageIcon(
                      AssetImage("assets/images/bill.png"),
                      color: Colors.white,
                    ),
                    label: 'Hóa Đơn',
                    labelStyle: TextStyle(
                        fontSize: 12.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
                CurvedNavigationBarItem(
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    label: 'Thông Tin',
                    labelStyle: TextStyle(
                        fontSize: 12.w,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ],
              index: state.index,
              onTap: context.read<NavbottomCubit>().changeTab,
            );
          },
        ),
      ),
    );
  }
}
