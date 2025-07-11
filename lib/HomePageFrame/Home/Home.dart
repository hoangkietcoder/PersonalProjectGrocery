import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personalprojectgrocery/ObjectBox/ObjectBox.dart';
import 'package:personalprojectgrocery/ObjectBox/model/ModelProductLocal.dart';
import 'package:personalprojectgrocery/Repository/DataLocal/data_local_repository.dart';
import 'package:personalprojectgrocery/Routes/argument/GioHangArgument.dart';
import '../../Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import '../../Compoents/Dialog/dialog_addProductLocal.dart';
import '../../Compoents/Dialog/dialog_loading_login.dart';
import '../../Compoents/speech_to_text/SpeechToTextService.dart';
import '../../Main_Bloc/main_bloc.dart';
import '../../Models/Product/getData_ProductFromFirebase.dart';
import '../../ObjectBox/bloc_ModelProductLocal/model_product_local_bloc.dart';
import '../../Repository/Firebase_Database/Product/product_repository.dart';
import 'ChiTietSanPham/ChiTietSanPham.dart';
import 'bloc_home/home_bloc.dart';

class Home extends StatelessWidget {

  const Home({
    super.key, required this.productRepository, required this.dataLocalRepository, });

  final ProductRepository productRepository;
  final DataLocalRepository dataLocalRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModelProductLocalBloc(DataLocalRepository: dataLocalRepository),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomepageframeViewState();
}

class _HomepageframeViewState extends State<HomeView> {


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
      context.read<HomeBloc>().add(SearchProductHomeEventChange(text));
      setState(() => _isListening = false);

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }





  // khai báo làm phân trang
  final ScrollController _scrollControllerPage = ScrollController();




  @override
  void initState() {
    super.initState();
    // Reset pagination để đảm bảo không lặp lại
    context.read<ProductRepository>().resetPagination(); //

    // // Load trang đầu tiên
    // context.read<HomeBloc>().add(FetchPage());


    // // gọi lần 2 khi scroll đến cuối trang
    // _scrollControllerPage.addListener(() {
    //   final state = context.read<HomeBloc>().state;
    //   if (_scrollControllerPage.position.pixels >= _scrollControllerPage.position.maxScrollExtent &&
    //       !context.read<HomeBloc>().state.hasReachedEnd &&  state.statusLoadPage != StatusLoadPage.loading) {
    //     context.read<HomeBloc>().add(FetchPage());
    //   }
    // });
  }
  


  @override
  Widget build(BuildContext context) {
    final statusTheme = context.select((MainBloc bloc) => bloc.state.statusTheme);
    final backgroundColorAppBar = statusTheme ? Colors.black : Colors.blueAccent;
    final backgroundColorBody = statusTheme ? Colors.black : Colors.white;

    final cardSearchColor = statusTheme ? Colors.grey[900] : Colors.white;
    final textColor = statusTheme ? Colors.black : Colors.black;


    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor:backgroundColorBody,
        appBar: AppBar(
          backgroundColor: backgroundColorAppBar,
          centerTitle: true,
          title: Text(
            "CỬA HÀNG TẠP HÓA",
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            // Nút giỏ hàng với số lượng sản phẩm
            BlocBuilder<ModelProductLocalBloc, ModelProductLocalState>(
              builder: (context, state) {
                final product = state.lstModelProductLocal.length;
                return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_sharp, color: Colors.white, size: 25.sp),
                  onPressed: () {
                    final arg = GioHangArgument();
                    Navigator.pushNamed(context, '/GioHang', arguments: arg);
                  },
                ),
                // nếu trong objectbox có số lượng mới hiện cái container này , còn nhỏ hơn ẩn đi
                if(product>0)
                  Positioned(
                    right: 8,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text( product > 9 ? '9+' : product.toString(), //Số lượng sản phẩm
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )


              ],
            );
        },
      ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: REdgeInsets.only(right: 7.0, left: 7.0, top: 6.0),
              child: TextField(
                onChanged: (value) => context.read<HomeBloc>().add(SearchProductHomeEventChange(value)), // lưu thay đổi vào state, để tìm kiếm sản phẩm
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: cardSearchColor,
                  suffixIcon: IconButton(icon: Icon(Icons.keyboard_voice) , onPressed: () {_handleVoiceInput();},),
                  contentPadding: REdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Tìm kiếm theo tên sản phẩm ...',
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (pre, cur) => pre.statusHome != cur.statusHome || pre.lsProduct != cur.lsProduct,
                builder: (context, state) {
                  if (state.statusHome == StatusHome.initial) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  return Scrollbar(
                    controller: _scrollControllerPage,
                    thumbVisibility: false, // khi người dùng kéo xuống mới hiện thanh cuộn
                    thickness: 3.0,
                    radius: Radius.circular(10.r),
                    child: ListView.builder(
                      controller: _scrollControllerPage,
                      itemCount: state.hasReachedEnd
                          ? state.lsProduct.length
                          : state.lsProduct.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.lsProduct.length) {
                          if(state.statusLoadPage == StatusLoadPage.loading && !state.hasReachedEnd){
                            return const Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const SizedBox.shrink(); // Tránh lỗi và không hiển thị gì cả
                          }
                        }
                        final product = state.lsProduct[index];
                        // tại đây khỏi cần format product.priceProduct ( String ) và product.quantityProduct (String -> thành int
                        final formattedPriceProduct = formatCurrencyVN(product.priceProduct);
                        final formattedQuantityProduct = formatCurrencyUS(product.quantityProduct);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChitietsanphamPage(productRepository: ProductRepository(), productId: product.id,)));
                              },
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    // ảnh
                                    Expanded(
                                      flex: 1,
                                      child: product.img_url.isNotEmpty ? Image.network(
                                        product.img_url,
                                        height: 65.h,
                                        width: 65.w,
                                      ) : Image.asset("assets/images/avamacdinhsanpham.jpg", // ảnh mặc định local
                                        height: 65.h,
                                        width: 65.w,
                                      ),
                                    ),
                                    // thông tin
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5.h),
                                          Text(
                                            product.nameProduct,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: textColor
                                            ),
                                            maxLines: 1, //
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: REdgeInsets.only(right: 6.0),
                                            child: Divider(),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 6,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: 'Giá: ',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.sp,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: formattedPriceProduct,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.sp,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: ' VNĐ',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.sp,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 3.h),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: 'Số lượng: ',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.sp,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: formattedQuantityProduct,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 14.sp,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Flexible(
                                                flex: 4,
                                                child: Padding(
                                                  padding: REdgeInsets.only(right: 6.0),
                                                  child: BlocListener<ModelProductLocalBloc, ModelProductLocalState>(
                                                    listenWhen: (pre, cur) => pre.statusSaveDataLocal != cur.statusSaveDataLocal,
                                                    listener: (context, state) {
                                                        if (state.statusSaveDataLocal == StatusSaveDataLocal.failure) {
                                                          Navigator.pop(context);
                                                          ScaffoldMessenger.of(context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(SnackBar(
                                                                duration: const Duration(seconds: 2),
                                                                content: Text(
                                                                  state.error,
                                                                )));
                                                        } else {
                                                          if(state.statusSaveDataLocal == StatusSaveDataLocal.success){
                                                            showDialog(
                                                              context: context,
                                                              builder: (_) => const DialogAddproductlocal(),
                                                            );
                                                            Future.delayed(const Duration(seconds: 1), () {
                                                              if (Navigator.of(context).canPop()) {
                                                                Navigator.of(context).pop(); // Tự động đóng sau 3s
                                                              }
                                                            });
                                                          }
                                                        }
                                                      },
                                                      child: ElevatedButton.icon(
                                                    onPressed: () async {
                                                      final bloc = BlocProvider.of<ModelProductLocalBloc>(context);
                                                      final data = ModelProductLocal(fireBaseId: product.id, img_url: product.img_url, nameProduct: product.nameProduct, quantityProduct: "1", priceProduct: product.priceProduct, supplierName: product.supplierName, phoneSupplier: product.phoneSupplier, noteProduct: product.noteProduct);
                                                      print("dwadwadawd ${data.noteProduct}");
                                                      bloc.add(SaveProductLocalEvent(data));
                                                    },
                                                    label: Padding(
                                                      padding: REdgeInsets.only(right: 3), // Adjust the left padding as needed
                                                      child: Text(
                                                        "Lấy",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    icon: Icon(
                                                      Icons.shopping_cart_rounded,
                                                      color: Colors.white,
                                                      size: 17.sp,
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      minimumSize: Size(85, 35), // Chiều rộng: 150, Chiều cao: 50
                                                      padding: REdgeInsets.symmetric(), // Maintain existing button padding
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.r),
                                                      ),
                                                      backgroundColor: Colors.blueAccent,
                                                    ),
                                                  ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 7.h),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
