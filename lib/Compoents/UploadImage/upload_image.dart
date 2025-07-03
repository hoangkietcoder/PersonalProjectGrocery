

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showImagePickerOptions(BuildContext context, String productId) {
  return showModalBottomSheet<bool>(
    isDismissible: true, // Cho phép bấm ra ngoài để đóng
    enableDrag: true,    // Cho phép kéo xuống để đóng
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn từ thư viện"),
              onTap: () => Navigator.pop(context, false), // false = thư viện
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("Chọn từ camera"),
              onTap: () => Navigator.pop(context, true), // true = camera
            ),
          ],
        ),
      );
    },
  );
}
