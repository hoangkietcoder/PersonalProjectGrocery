import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Authentication/bloc/authentication_bloc.dart';
import 'Config/responsive_widget.dart';
import 'Main_Bloc/main_bloc.dart';
import 'Repository/Authentication/authentication_repository.dart';
import 'Repository/Bill/bill_repository.dart';
import 'Repository/Firebase_Database/Register/register_repository.dart';
import 'Repository/NavigatorKey/navigatorkey.dart';
import 'Repository/Notification/notification_repository.dart';
import 'Routes/route.dart';
import 'my_bloc_observer.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;



Future<void> main() async {
  tz.initializeTimeZones(); // khởi tạo để dùng thư viện timezone để bắt time
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  // Cấu hình ScreenUtil
  Bloc.observer = const MyBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // khóa màn hình
    DeviceOrientation.portraitDown, // khóa màn hình
  ]);

  final Navigatorkey navigatorkey = Navigatorkey();


  // ham khoi tao repo
  final NotificationRepository notificationRepository = NotificationRepository();

  await notificationRepository.initNotification(selectNotification: (String payload){
    navigatorkey.selectNotification();
  },onDidReceiveLocalNotification: (int? id,String? title, String? body, String? payload){
    navigatorkey.onDidReceiveLocalNotification();
  });


// lúc chạy app thì xác nhận xem có cho phép thông báo hay không
//   await NotificationRepository().requestPermissionNotification();

  runApp( GroceryStore(navigatorkey: navigatorkey,));
}

class GroceryStore extends StatefulWidget {

  const GroceryStore({super.key, required this.navigatorkey});
  final Navigatorkey navigatorkey;
  @override
  State<GroceryStore> createState() => _GroceryStoreState();
}

class _GroceryStoreState extends State<GroceryStore> {

  // repo dùng cho toàn app
  late final AuthenticationRepository _authenticationRepository;
  late final BillRepository _billRepository;

  // late final FirebaseDatabase _firebaseDatabase;


  //   dau _ xai rieng cho class đó thôi
  late final RegisterRepository _registerRepository;




  // khởi tạo các repo
  @override
  void initState() {
    super.initState();
    _registerRepository = RegisterRepository();
    _authenticationRepository = AuthenticationRepository(
        // firebaseDatabase: _firebaseDatabase,
        registerRepository: _registerRepository,
    );
    _billRepository = BillRepository();

  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // dùng cho toàn app
        providers: [
          RepositoryProvider<AuthenticationRepository>.value(
              value: _authenticationRepository),
          RepositoryProvider<RegisterRepository>.value(
              value: _registerRepository),
          RepositoryProvider<NotificationRepository>.value(
              value: NotificationRepository()),
          RepositoryProvider<Navigatorkey>.value(
              value: widget.navigatorkey),
          RepositoryProvider<BillRepository>.value(
              value: _billRepository),

        ],
        // tạo bloc provider cho toàn app
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => MainBloc(),),
          BlocProvider(
            create: (context) => AuthenticationBloc(authenticationRepository: _authenticationRepository)),


        ], child: const GroceryStoreView()));
  }
}



class GroceryStoreView extends StatefulWidget {
  const GroceryStoreView({super.key});

  @override
  State<GroceryStoreView> createState() => GroceryStoreViewState();
}

class GroceryStoreViewState extends State<GroceryStoreView> {
    final _navigatorKey = Navigatorkey();
  final _route = RouteGenerator();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      responsiveWidgets: ResponsiveWidget.responsiveWidget,
      designSize: const Size(360, 640),
      builder: (context, _) =>
          BlocBuilder<MainBloc, MainState>(buildWhen: (current, prev) {
            return current.statusTheme != prev.statusTheme;
          }, builder: (context, state) {
            return MaterialApp(
              onGenerateRoute: _route.generateRoute,
              navigatorKey: _navigatorKey.navigatorKey,
              theme: state.statusTheme ? ThemeData.dark() : ThemeData.light(),
              debugShowCheckedModeBanner: false,
              title: 'Tạp Hóa Thông Minh',
              builder: (context, child) {
                // bắt trạng thái authen để chuyển trang
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listenWhen: (pre, cur) {
                    return pre.status != cur.status;
                  },
                  listener: (context, state) {
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                      // login phải dùng pushNamedAndRemoveUntil để nó xóa sạch dữ liệu
                        _navigatorKey.navigatorKey.currentState!.pushNamedAndRemoveUntil("/HomeScreenPage", (route) => false);
                      case AuthenticationStatus.unauthenticated:
                        _navigatorKey.navigatorKey.currentState!.pushNamedAndRemoveUntil("/Login", (route) => false);
                      case AuthenticationStatus.unknown:
                        break;
                    }
                  },
                  child: child,
                );
              },

            );
          }),
    );
  }
}
