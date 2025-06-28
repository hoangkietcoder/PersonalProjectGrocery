import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText; // check show/hide password
  final VoidCallback onPress;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54), // màu bo viền ô textfield
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          fillColor: Colors.grey.shade200,// màu trong ô textfield
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.blueAccent,
          ),
          suffixIcon: obscureText
              ? IconButton(
            icon: Icon(
              obscureText
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: onPress,
          )
              : null,
        ),
      ),
    );
  }
}
