import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/Sua/bloc/sua_bloc.dart';

import '../../../../Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import '../../../../Repository/DanhMuc/sua/SuaRepository.dart';
import '../../../../Repository/Firebase_Database/Product/product_repository.dart';
import '../../../Home/ChiTietSanPham/ChiTietSanPham.dart';


class DanhMucNuocGiatXaPage extends StatelessWidget {

  final SuaRepository suaRepository;

  const DanhMucNuocGiatXaPage({super.key, required this.suaRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ..add(DetailProductEventChange(productId)), initial vừa vô trang sẽ lấy dữ liệu về
      create: (context) => SuaBloc(suaRepo: suaRepository),
      child: const DanhMucNuocGiatXaView(),
    );
  }
}


class DanhMucNuocGiatXaView extends StatefulWidget {
  const DanhMucNuocGiatXaView({super.key});

  @override
  State<DanhMucNuocGiatXaView> createState() => _DanhMucNuocGiatXaViewState();
}

class _DanhMucNuocGiatXaViewState extends State<DanhMucNuocGiatXaView> {
  final TextEditingController _searchController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser?.uid ?? "";


  @override
  void initState() {
    super.initState();

    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null){
      final userId = currentUser.uid;
      // Gọi sự kiện để lấy dữ liệu danh sách sữa
      context.read<SuaBloc>().add(FetchSuaEvent(
        userId: userId, // hoặc FirebaseAuth.instance.currentUser!.uid
        typeProduct: 4,
      ));
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    // Thực tế bạn cần dùng url_launcher để launchUrl(launchUri)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Danh Mục Giặt Xả',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.only(right: 7.0, left: 7.0, top: 6.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => context.read<SuaBloc>().add(SearchProductDanhMuc(value.trim(),4,userId)), // lưu thay đổi vào state, để tìm kiếm sản phẩm
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(icon: Icon(Icons.keyboard_voice) , onPressed: () {},),
                contentPadding: REdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm theo sản phẩm theo nước giặt xả ...',
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SuaBloc, SuaState>(
              buildWhen: (pre ,cur ) => pre.lstDanhMucSua != cur.lstDanhMucSua,
              builder: (context, state) {
                final isSearching = _searchController.text.trim().isNotEmpty;

                if (isSearching) {
                  // ĐANG TÌM KIẾM
                  if (state.statusSearch == StatusSearch.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.statusSearch == StatusSearch.failure) {
                    return Center(child: Text('Lỗi tìm kiếm: ${state.error ?? 'Không xác định'}'));
                  } else if (state.lstDanhMucSua.isEmpty) {
                    return const Center(child: Text('Không tìm thấy nước giặt xả.'));
                  }
                } else {
                  // LOAD BAN ĐẦU
                  if (state.statusLoadSua == StatusLoadSua.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.statusLoadSua == StatusLoadSua.failure) {
                    return Center(child: Text('Lỗi tải dữ liệu: ${state.error ?? 'Không xác định'}'));
                  } else if (state.lstDanhMucSua.isEmpty) {
                    return const Center(child: Text('Không có nước giặt xả nào.'));
                  }
                }
                return ListView.builder(
                  itemCount: state.lstDanhMucSua.length,
                  itemBuilder: (context, index) {
                    final sua = state.lstDanhMucSua[index];
                    // tại đây khỏi cần format product.priceProduct ( String ) và product.quantityProduct (String -> thành int
                    final formattedPriceProduct = formatCurrencyVN(sua.priceProduct);
                    final formattedQuantityProduct = formatCurrencyUS(sua.quantityProduct);
                    return Stack(
                        children: [
                          Card(
                            margin: REdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChitietsanphamPage(productRepository: ProductRepository(), productId:sua.id,)));
                              },
                              borderRadius: BorderRadius.circular(20.r),
                              child: Padding(
                                padding: REdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: sua.img_url.isNotEmpty ? Image.network(sua.img_url,
                                        width: 100.w,
                                        height: 125.w,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Icon(
                                          Icons.broken_image,
                                          size: 100.w,
                                          color: Colors.grey.shade300,
                                        ),
                                      ) : Image.asset(
                                        "assets/images/nuocgiatxa.png",
                                        width: 100.w,
                                        height: 100.w,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Icon(
                                          Icons.broken_image,
                                          size: 100.w,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sua.nameProduct,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey.shade900,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            children: [
                                              Icon(Icons.payments, size: 16.sp, color: Colors.green),
                                              SizedBox(width: 6.w),
                                              Text(
                                                "Giá: ${formattedPriceProduct}",
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h),
                                          Row(
                                            children: [
                                              Icon(Icons.inventory_2, size: 16.sp, color: Colors.grey.shade600),
                                              SizedBox(width: 6.w),
                                              Text(
                                                'Số lượng: ${formattedQuantityProduct}',
                                                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            children: [
                                              Icon(Icons.store, size: 16.sp, color: Colors.indigo),
                                              SizedBox(width: 6.w),
                                              Expanded(
                                                child: Text(
                                                  "NCC:${sua.supplierName}",
                                                  style: TextStyle(fontSize: 14.sp, fontStyle: FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h),
                                          GestureDetector(
                                            // onTap: () => _makePhoneCall(product.supplierPhone),
                                            child: Row(
                                              children: [
                                                Icon(Icons.phone, size: 16.sp, color: Colors.blue.shade700),
                                                SizedBox(width: 6.w),
                                                Expanded(
                                                  child: Text(
                                                    'SĐT: ${sua.phoneSupplier}',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Colors.blue.shade700,
                                                      decoration: TextDecoration.underline,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 15,
                              left: 15,
                              child: Container(
                                child: Text("${index +1}.",style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              ))
                        ]

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
