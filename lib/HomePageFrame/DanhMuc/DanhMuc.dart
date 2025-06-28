import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Compoents/DanhMuc/Item.dart';
import '../../Repository/DanhMuc/danhmuc_repository.dart';
import '../HoaDon/ThemHoaDon/bloc/themhoadon_bloc.dart';
import 'bloc/danhmuc_bloc.dart';

class DanhMucPage extends StatelessWidget {
  const DanhMucPage({super.key, required this.danhMucRepository});

  // truyền repo qua
  final DanhMucRepository danhMucRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ..add(DetailProductEventChange(productId)), initial vừa vô trang sẽ lấy dữ liệu về
      create: (context) => DanhmucBloc( danhmucRepository: danhMucRepository)..add(FetchDanhMucEvent()),
      child: const DanhMucView(),
    );;
  }


}

class DanhMucView extends StatefulWidget {
  const DanhMucView({super.key});

  @override
  State<DanhMucView> createState() => _DanhMucViewState();
}

class _DanhMucViewState extends State<DanhMucView> {






  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 55.h,
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    "DANH MỤC",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Flexible(
              flex: 9,
              child: BlocBuilder<DanhmucBloc, DanhmucState>(
                buildWhen: (cur, pre){
                  return cur.danhmucStatus != pre.danhmucStatus;
                },
                builder: (context, state) {
                 if(state.danhmucStatus == DanhMucStatus.initial){
                   return Center(child: const CircularProgressIndicator());
                 }
                 else if (state.danhmucStatus == DanhMucStatus.failure){
                   // trả về view lỗi
                      return Center(child: SingleChildScrollView(child: Text(state.error)));
                 }
                 return GridView.builder(
                   padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
                   itemCount: state.lstDanhMuc.length,
                   shrinkWrap: true, // để ko bị overflow , canh đúng khoảng đó ,
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       crossAxisSpacing: 12,
                       mainAxisSpacing: 12
                   ),
                   itemBuilder: (BuildContext context, int index) {
                     final  category = state.lstDanhMuc[index];
                     return CategoryCard(name: category.category, image:category.img_url);
                   },
                 );
                },
              ),
            ),
          ],
        ));
  }
}
