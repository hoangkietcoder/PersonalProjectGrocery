import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import '../../../Compoents/Dialog/dialog_delete_product.dart';
import '../../../Compoents/UploadImage/upload_image.dart';
import '../../../Repository/Firebase_Database/Product/product_repository.dart';
import 'bloc/chitietsanpham_bloc.dart';

class ChitietsanphamPage extends StatelessWidget {
  const ChitietsanphamPage(
      {super.key, required this.productRepository, required this.productId});

  final String productId;

  // truyền repo qua
  final ProductRepository productRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: productRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ChitietsanphamBloc>(
            // ..add(DetailProductEventChange(productId)), initial vừa vô trang sẽ lấy dữ liệu về
            create: (BuildContext context) =>
                ChitietsanphamBloc(producRepo: productRepository)
                  ..add(DetailProductEventChange(productId)),
          ),
        ],
        child: ChitietsanphamView(),
      ),
    );
  }
}

class ChitietsanphamView extends StatefulWidget {
  const ChitietsanphamView({super.key});

  @override
  State<ChitietsanphamView> createState() => _ChitietsanphamViewState();
}

class _ChitietsanphamViewState extends State<ChitietsanphamView> {


  Map<int, String> productTypeLabels = {
    1: 'Sữa',
    2: 'Hạt',
    3: 'Bánh Kẹo',
    4: 'Nước Giặt Xả',
    5: 'Kem',
    6: 'Nước Ngọt',
    7: 'Đồ Gia Vị',
    8: 'Sữa Tắm',
    9: 'Đồ Khô',
  };

  String getProductTypeLabel(int type) {
    return productTypeLabels[type] ?? 'Không xác định';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.blueAccent,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        // chỉnh màu cho dấu back
        title: const Text(
          "Chi Tiết Sản Phẩm",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<ChitietsanphamBloc, ChitietsanphamState>(
        buildWhen: (pre, cur) {
          return pre.detailStatusInitial != cur.detailStatusInitial;
        },
        builder: (context, state) {
          if (state.detailStatusInitial == DetailStatusInitial.initial) {
            return Center(child: const CircularProgressIndicator());
          } else if (state.detailStatusInitial == DetailStatusInitial.failure) {
            // trả về view lỗi
            return Center(child: Text(state.error));
          }
          final product = state.detailProduct;
          // tại đây khỏi cần format product.priceProduct ( String ) và product.quantityProduct (String -> thành int
          final formattedPriceProduct = formatCurrencyVN(product.priceProduct);
          final formattedQuantityProduct = formatCurrencyUS(product.quantityProduct);
          return SingleChildScrollView(
            padding: REdgeInsets.only(top: 20, right: 18, left: 20),
            child: Column(children: [
                    // Hình ảnh chính
                    product.img_url.isNotEmpty ? Image.network(
                      product.img_url,
                      height: 200.h,
                      width: 150.w,
                      fit: BoxFit.cover,
                    ) : Image.asset("assets/images/avamacdinhsanpham.jpg", // ảnh mặc định local
                          height: 200.h,
                          width: 150.w,
                          fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.h,),
                    // Nút camera ở góc dưới phải
              GestureDetector(
                          onTap: () async {
                            final productId = state.detailProduct!.id;
                            final bool? fromCamera = await showImagePickerOptions(context, productId);
                            if (fromCamera != null) {
                              final XFile? pickedFile = await ImagePicker().pickImage(
                                source: fromCamera ? ImageSource.camera : ImageSource.gallery,
                              );

                              if (pickedFile != null) {
                                final File imageFile = File(pickedFile.path);

                                context.read<ChitietsanphamBloc>().add(
                                  UploadImageEvent(
                                    imageFile: imageFile,
                                    ProductId: productId,
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),

              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/box-open.png"), size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Tên: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: product.nameProduct,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/box-open.png"), size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Loại: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: getProductTypeLabel(product.typeProduct ?? 0),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/donvi.png"),
                        size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Số lượng: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: formattedQuantityProduct,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/tags.png"),
                        size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Giá: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: formattedPriceProduct,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/truck-moving.png"),
                        size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Nhà cung cấp: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: product.supplierName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/phone-call.png"),
                        size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Số điện thoại nhà cung cấp: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: product.phoneSupplier,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ImageIcon(
                        const AssetImage("assets/images/description-alt.png"),
                        size: 15.sp,
                      )),
                  Expanded(
                    flex: 9,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Mô tả ( nếu có ): ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: Colors.black)),
                          TextSpan(
                              text: product.noteProduct,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final bloc = context.read<ChitietsanphamBloc>();
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogDeleteProduct();
                            },
                          ).then((value) {
                            if (value != null && value) {
                              bloc.add(DeleteDetailProduct(product.id, state.lstData.length));
                              // Hiện thông báo
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Đã xóa sản phẩm thành công')),
                              );
                              Navigator.pushNamedAndRemoveUntil(context, "/HomeScreenPage", (route) => false); // false là xóa , true là k xóa
                            }
                          });
                        },
                        label: Text(
                          "Xóa",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          backgroundColor: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // final bloc = context.read<LogoutCubit>();
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) => DialogLogout(
                          //         onPress: () {
                          //           bloc.logOut();
                          //         })
                          // );
                        },
                        label: Text(
                          "Sửa",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
