import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personalprojectgrocery/Models/Product/getData_ProductFromFirebase.dart';
import 'package:personalprojectgrocery/ObjectBox/bloc_ModelProductLocal/model_product_local_bloc.dart';
import 'package:personalprojectgrocery/Repository/DataLocal/data_local_repository.dart';

import '../../Compoents/CurrencyInputFormatterPrice/CurrencyInputFormatterPrice.dart';
import '../../Compoents/Dialog/dialog_deleteAllProductLocal.dart';
import '../../Compoents/Dialog/dialog_delete_all_product_cart.dart';
import '../../Main_Bloc/main_bloc.dart';
import '../../ObjectBox/ObjectBox.dart';

class GioHangPage extends StatelessWidget {
  const GioHangPage({
    super.key,
    required this.dataProduct,
  });

  final getDataProduct dataProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModelProductLocalBloc(
          DataLocalRepository: context.read<DataLocalRepository>())
        ..add(RefreshListProDuctLocalCartEvent()),
      child: GioHangView(product: dataProduct),
    );
  }
}

class GioHangView extends StatefulWidget {
  final getDataProduct product;
  const GioHangView({super.key, required this.product});

  @override
  State<GioHangView> createState() => _GioHangViewState();
}

class _GioHangViewState extends State<GioHangView> {
  @override
  void initState() {
    super.initState();
    // Không cần gọi event ở đây nữa nếu đã gọi ở BlocProvider
    // context.read<ModelProductLocalBloc>().add(GetProductLocalEvent());
  }

  @override
  Widget build(BuildContext context) {
    final statusTheme =
        context.select((MainBloc bloc) => bloc.state.statusTheme);
    final backgroundAppbarColor =
        statusTheme ? Colors.black : Colors.blueAccent;
    final textColor = statusTheme ? Colors.white : Colors.white;
    final textDeleteAllColor = statusTheme ? Colors.red : Colors.red;
    final textQuantityColor = statusTheme ? Colors.white : Colors.black;
    final textNameProductColor = statusTheme ? Colors.black : Colors.black;
    final textQuantityProductColor = statusTheme ? Colors.black : Colors.black;
    final backgroundColor = statusTheme ? Colors.black : Colors.white;
    final textTongCongColor = statusTheme ? Colors.black : Colors.black;
    final textGiaTongCongColor = statusTheme ? Colors.black : Colors.green;
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ Hàng', style: TextStyle(color: textColor)),
        centerTitle: true,
        backgroundColor: backgroundAppbarColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: BlocConsumer<ModelProductLocalBloc, ModelProductLocalState>(
        listenWhen: (pre, cur) =>
            pre.statusDeleteDataLocal != cur.statusDeleteDataLocal,
        listener: (context, state) {
          if (state.statusDeleteDataLocal == StatusDeleteDataLocal.success) {
            showDialog(
              context: context,
              builder: (_) => const DialogDeleteAllProductLocal(),
            );
            Future.delayed(const Duration(seconds: 1), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(); // Tự động đóng sau 1s
              }
            });
          } else if (state.statusDeleteDataLocal ==
              StatusDeleteDataLocal.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text("❌ Lỗi: ${state.error ?? "Không xác định"}")),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<ModelProductLocalBloc, ModelProductLocalState>(
            builder: (context, state) {
              if (state.statusGetDataLocal == StatusGetDataLocal.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.statusGetDataLocal ==
                  StatusGetDataLocal.failure) {
                // trả về view lỗi
                return Center(
                    child: SingleChildScrollView(child: Text(state.error)));
              }
              return Container(
                color: backgroundColor,
                child: Padding(
                  padding: REdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        spacing: 7.w,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Text(
                              "Sản phẩm đã lấy:  ${state.lstModelProductLocal.length} ",
                              style: TextStyle(
                                  color: textQuantityColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const DialogDeleteAllProductCart();
                                  },
                                ).then((value) {
                                  if (value == true) {
                                    // Gửi sự kiện xóa dữ liệu ObjectBox qua Bloc
                                    context
                                        .read<ModelProductLocalBloc>()
                                        .add(DeleteAllLocalProductCartEvent());
                                  }
                                });
                              },
                              child: Text(
                                "Xóa tất cả",
                                style: TextStyle(
                                    color: textDeleteAllColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: state.lstModelProductLocal.length,
                        itemBuilder: (context, index) {
                          final item = state.lstModelProductLocal[index];
                          final formattedPriceProduct = formatCurrencyVN(item.priceProduct);
                          final formattedQuantityProduct = formatCurrencyUS(item.quantityProduct);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      context.read<ModelProductLocalBloc>().add(
                                            DeleteLocalProductEvent(item.id),
                                          );
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Xóa',
                                  ),
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.blue[50],
                                elevation: 2,
                                child: ListTile(
                                  leading: item.img_url.isNotEmpty
                                      ? Image.network(
                                         item.img_url,
                                          height: 50.h,
                                          width: 50.w,
                                          fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image,
                                        size: 65.w,
                                        color: Colors.grey.shade400,
                                      );
                                    },
                                        )
                                      : Image.asset(
                                          "assets/images/avamacdinhsanpham.jpg", // ảnh mặc định local
                                          height: 50.h,
                                          width: 50.w,
                                          fit: BoxFit.cover,
                                        ),
                                  title: Text(item.nameProduct,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // dài quá sẽ hiện ...
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textNameProductColor)),
                                  subtitle: Text('${formattedPriceProduct} đ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // dài quá sẽ hiện ...
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12.sp
                                      )),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.blueAccent),
                                        onPressed: () {
                                          context
                                              .read<ModelProductLocalBloc>()
                                              .add(
                                                UpdateQuantityProductLocalEvent(
                                                    product: item, change: -1),
                                              );
                                        },
                                      ),
                                      Text(formattedQuantityProduct,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis, // dài quá sẽ hiện ...
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: textQuantityProductColor)),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.blueAccent),
                                        onPressed: () {
                                          context
                                              .read<ModelProductLocalBloc>()
                                              .add(
                                                UpdateQuantityProductLocalEvent(
                                                    product: item, change: 1),
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: BlocBuilder<ModelProductLocalBloc, ModelProductLocalState>(
                          builder: (context, state) {
                            final formatter = NumberFormat("#,###", "vi_VN"); // định dạng tổng tiền
                            final total = state.totalPriceInCart;
                            final formattedTotal = formatter.format(total);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tổng cộng:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textTongCongColor)),
                                Text('$formattedTotal đ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textGiaTongCongColor)),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                        ),
                        child: const Text('Thanh Toán',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
