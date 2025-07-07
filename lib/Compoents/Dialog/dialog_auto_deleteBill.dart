import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogAutoDeletebill extends StatelessWidget {
  const DialogAutoDeletebill({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Xóa hóa đơn thành công !',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sản phẩm đã được xóa .',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}