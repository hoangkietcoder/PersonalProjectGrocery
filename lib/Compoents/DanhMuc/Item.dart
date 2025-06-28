import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



// khung sườn các chức năng
class CategoryCard extends StatelessWidget {
  final String name;
  final String image;

  const CategoryCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}