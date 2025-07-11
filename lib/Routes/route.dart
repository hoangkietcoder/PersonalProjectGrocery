import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/ObjectBox/ObjectBox.dart';
import '../ForgotPassword/ForgotPassword.dart';
import '../HomePageFrame/GioHang/GioHang.dart';
import '../HomePageFrame/HoaDon/ChiTietHoaDon/ChiTietHoaDon.dart';
import '../HomePageFrame/HoaDon/HoaDon.dart';
import '../HomePageFrame/Home/ChiTietSanPham/ChiTietSanPham.dart';
import '../HomePageFrame/Home/ThemSanPham/ThemSanPham.dart';
import '../HomePageFrame/HomePage/HomePage.dart';
import '../HomePageFrame/ThongTin/CaiDat/CaiDat.dart';
import '../HomePageFrame/ThongTin/CapNhapThongTin/CapNhatThongTin.dart';
import '../HomePageFrame/ThongTin/DoiMatKhau/DoiMatKhau.dart';
import '../HomePageFrame/ThongTin/FeedBack/FeedBack.dart';
import '../Login/loginApp.dart';
import '../Register/register.dart';
import '../Splash/splash_screen.dart';
import 'argument/CapNhatThongTinArgument.dart';
import 'argument/ChiTietSanPhamArgument.dart';
import 'argument/DangKiArgument.dart';
import 'argument/FeedBackArgument.dart';
import 'argument/GioHangArgument.dart';
import 'argument/ThemHoaDonArgument.dart';
import 'argument/ThemSanPhamArgument.dart';
import 'custom_page_route.dart';


class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CustomPageRoute(
            settings: const RouteSettings(name: '/'),
            child: const SplashScreen());
      case '/Login':
        // LoginArgument argument = args as LoginArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/Login'),
            child: const Login());
      // case '/Home':
      // // LoginArgument argument = args as LoginArgument;
      //   return CustomPageRoute(
      //       settings: const RouteSettings(name: '/Home'),
      //       child: const Home());
      case '/HomeScreenPage':
        // HomeArgument argument = args as HomeArgument; // khi cần truyền mới cần tạo argument
        return CustomPageRoute(
            settings: const RouteSettings(name: '/HomeScreenPage'),
            child:  const HomeScreenPage());
      case '/ForgotPassword':
      // LoginArgument argument = args as LoginArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/ForgotPassword'),
            child: const ForgotpasswordPage());
      case '/Register':
        DangKiArgument argument = args as DangKiArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/Register'),
            child:  RegisterPage(date: argument.date  ,));
      case '/DoiMatKhau':
      // LoginArgument argument = args as LoginArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/DoiMatKhau'),
            child: const DoiMatKhauPage());
      case '/GioHang':
        GioHangArgument argument = args as GioHangArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/GioHang'),
            child: GioHangPage(dataProduct: argument.product));
      case '/ThemSanPham':
        ThemSanPhamArgument argument = args as ThemSanPhamArgument; // khi cần truyền mới cần tạo argument
        return CustomPageRoute(
            settings: const RouteSettings(name: '/ThemSanPham'),
            child:  ThemSanPhamPage(productRepository: argument.productRepository,));
      case '/ChiTietSanPham':
        ChiTietSanPhamArgument argument = args as ChiTietSanPhamArgument; // khi cần truyền mới cần tạo argument
        return CustomPageRoute(
            settings: const RouteSettings(name: '/ChiTietSanPham'),
            child:  ChitietsanphamPage(productId: argument.productID, productRepository: argument.productRepository,));
      case '/HoaDon':
      return CustomPageRoute(
          settings: const RouteSettings(name: '/HoaDon'),
          child:  HoaDonPage());
      case '/ChiTietHoaDon':
        return CustomPageRoute(
            settings: const RouteSettings(name: '/ChiTietHoaDon'),
            child:  ChiTietHoaDonPage());
      case '/FeedBack':
        FeedBackArgument argument = args as FeedBackArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/FeedBack'),
            child:  Send_Feedback_Page(feedbackRepository: argument.feedbackRepository,));
      case '/DoiMatKhau':
        return CustomPageRoute(
            settings: const RouteSettings(name: '/DoiMatKhau'),
            child:  DoiMatKhauPage());
      case '/CapNhatThongTin':
        CapNhatThongTinArgument argument = args as CapNhatThongTinArgument;
        return CustomPageRoute(
            settings: const RouteSettings(name: '/CapNhatThongTin'),
            child:  CapNhatThongTinPage(capnhatthongtinRepository: argument.capnhatthongtinRepository,));
      case '/CaiDat':
        return CustomPageRoute(
            settings: const RouteSettings(name: '/CaiDat'),
            child:  CaiDatPage());
      // case '/RegisterPage':
      //   RegisterArgument argument = args as RegisterArgument;
      //   return CustomPageRoute(
      //       settings: const RouteSettings(name: '/RegisterPage'),
      //       child: RegisterPage(registerRepository: argument.registerRepository));
      // case '/VerifyPage':
      //   VerifyArgument argument = args as VerifyArgument;
      //   return CustomPageRoute(
      //       settings: const RouteSettings(name: '/VerifyPage'),
      //       child: VerifyPage(registerRepository: argument.registerRepository, registerEmailRequest: argument.registerEmailRequest,));

      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return CustomPageRoute(child: const NotFoundPage());
  }
}

// trang lỗi khi không tìm thấy
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotFoundView();
  }
}
class NotFoundView extends StatelessWidget {
  const NotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 20.sp,
          color: Colors.white,
          onPressed: () {
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        titleSpacing: 0.0,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Lỗi",
          style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Text("Không tìm thấy trang",style: TextStyle(fontSize: 15.sp,color: Colors.black),
        ),
      ),
    );
  }
}

