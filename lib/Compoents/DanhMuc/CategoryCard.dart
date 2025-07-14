import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/BanhKeo/DanhMucBanhKeoPage.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/DoKho/DanhMucDoKhoPage.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/Hat/DanhMucHatPage.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/NuocGiatXa/NuocGiatXaPage.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/NuocNgot/DanhMucNuocNgotPage.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/SuaTam/DanhMucSuaTamPage.dart';

import '../../HomePageFrame/DanhMuc/DanhMuc.dart';
import '../../HomePageFrame/DanhMuc/DanhMucFrame/DoGiaVi/DanhMucDoGiaVi.dart';
import '../../HomePageFrame/DanhMuc/DanhMucFrame/Kem/DanhMucKemPage.dart';
import '../../HomePageFrame/DanhMuc/DanhMucFrame/Sua/DanhMucSuaPage.dart';
import '../../Repository/DanhMuc/sua/SuaRepository.dart';




// khung sườn các chức năng
class CategoryCard extends StatelessWidget {
  final String name;
  final String image;
  final SuaRepository suaRepo;
  final int idType;

  const CategoryCard({super.key, required this.name, required this.image, required this.suaRepo, required this.idType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      // 👉 Điều hướng theo idType
      switch (idType) {
        case 1:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucSuaPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 2:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucHatPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 3:
        Navigator.push(context,
          MaterialPageRoute(builder: (_) => DanhMucBanhKeoPage(
            suaRepository: suaRepo,
          )),
        );
        break;
        case 4:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucNuocGiatXaPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 5:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucKemPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 6:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucNuocNgotPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 7:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucDoGiaViPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 8:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucSuaTamPage(
              suaRepository: suaRepo,
            )),
          );
          break;
        case 9:
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => DanhMucDoKhoPage(
              suaRepository: suaRepo,
            )),
          );
          break;
      };},
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          // tô viền
          side: BorderSide(
            color: Colors.blueAccent,
            width: 0.8 // độ dày của viền
          )
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: REdgeInsets.symmetric(vertical:22, horizontal: 22),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding:  REdgeInsets.all(8.0),
              child: Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}