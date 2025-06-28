import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personalprojectgrocery/Models/Product/getData_ProductFromFirebase.dart';

class GioHangPage extends StatelessWidget {
  final getDataProduct product;
  const GioHangPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CartView(product: product),
    );
  }
}

class CartView extends StatefulWidget {
  final getDataProduct product;

  const CartView({super.key, required this.product});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Map<String, dynamic>> cartItems = [
    {'name': 'Táo', 'price': 15000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'Chuối', 'price': 12000, 'quantity': 2, 'image': 'assets/images/milk.png'},
    {'name': 'Sữa', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'bánh', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'kẹo', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'bột giặt', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'đường', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'muối', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'sữa chua', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'Sữa', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'Sữa', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},
    {'name': 'Sữa', 'price': 19000, 'quantity': 1, 'image': 'assets/images/milk.png'},

  ];

  int get totalPrice => cartItems.fold(
    0,
        (total, item) => total + (item['price'] as int) * (item['quantity'] as int),
  );

  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]['quantity'] += change;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            spacing: 7.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Flexible(
              flex: 5,
              child: Text("Đơn hàng của bạn ",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ),
            Flexible(
              flex: 5,
              child: Text("Xóa tất cả",style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,

              ),),
            )
          ],),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => setState(() => cartItems.removeAt(index)),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Xóa',
                        ),
                      ],
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.blue[50],
                      elevation: 2,
                      child: ListTile(
                        leading: Image.asset(item['image'], width: 50, height: 50),
                        title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${item['price']} đ', style: const TextStyle(color: Colors.blueAccent)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.blueAccent),
                              onPressed: () => updateQuantity(index, -1),
                            ),
                            Text('${item['quantity']}', style: const TextStyle(fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.blueAccent),
                              onPressed: () => updateQuantity(index, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng cộng:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('$totalPrice đ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            ),
            child: const Text('Thanh Toán', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}