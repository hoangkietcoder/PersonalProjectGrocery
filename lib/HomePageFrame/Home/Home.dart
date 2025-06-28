import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Repository/Firebase_Database/Product/product_repository.dart';
import '../../Routes/argument/GioHangArgument.dart';
import 'ChiTietSanPham/ChiTietSanPham.dart';
import 'bloc_home/home_bloc.dart';

class Home extends StatelessWidget {
  final ProductRepository productRepository;

  const Home({
    super.key,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomepageframeViewState();
}

class _HomepageframeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart_sharp, color: Colors.white, size: 25.sp),
                onPressed: () {
                  // Navigator.pushNamed(context, '/GioHang');
                },
              ),
              Positioned(
                right: 8,
                top: 5,
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '9+', //Số lượng sản phẩm
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(right: 7.0, left: 7.0, top: 6.0),
            child: TextField(
              onChanged: (value) => context.read<HomeBloc>().add(SearchProductHomeEventChange(value)), // lưu thay đổi vào state, để tìm kiếm sản phẩm
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(icon: Icon(Icons.keyboard_voice) , onPressed: () {

                },),
                contentPadding: REdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm sản phẩm ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 7.h),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (pre, cur) => pre.statusHome != cur.statusHome,
              builder: (context, state) {
                if (state.statusHome == StatusHome.initial) {
                  return Center(child: const CircularProgressIndicator());
                }
                return BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (pre, cur) => pre.lsProduct != cur.lsProduct,
                  builder: (context, state) {
                    return Scrollbar(
                      controller: _scrollController,
                      thumbVisibility:
                          false, // khi người dùng kéo xuống mới hiện thanh cuộn
                      thickness: 3.0,
                      radius: Radius.circular(10.r),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.lsProduct.length,
                        itemBuilder: (context, index) {
                          final product = state.lsProduct[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChitietsanphamPage(
                                            productRepository:
                                                ProductRepository(),
                                            productId: product.id,
                                          )));
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      // ảnh
                                      Expanded(
                                        flex: 1,
                                        child: Image(
                                          image: AssetImage("assets/images/img.png"),
                                          width: 65.w,
                                          height: 65.h,
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
                                              ),
                                            ),
                                            Padding(
                                              padding: REdgeInsets.only(right: 6.0),
                                              child: Divider(),
                                            ),
                                            Row(
                                              children: [
                                                Column(
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
                                                            text: product.priceProduct,
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
                                                            text: product.quantityProduct,
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
                                                Spacer(),
                                                Padding(
                                                  padding: REdgeInsets.only(right: 6.0),
                                                  child: ElevatedButton.icon(
                                                    onPressed: () {
                                                      final argument = GioHangArgument(product: product);
                                                      Navigator.pushNamed(context, "/GioHang", arguments: argument);
                                                      // context.read<HomeBloc>().add(getProduct(product.id));
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
                                                      minimumSize: Size(100, 35), // Chiều rộng: 150, Chiều cao: 50
                                                      padding: REdgeInsets.symmetric(), // Maintain existing button padding
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.r),
                                                      ),
                                                      backgroundColor: Colors.blueAccent,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
