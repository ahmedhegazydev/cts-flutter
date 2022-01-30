import 'package:cts/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class LogIn_InputFiled extends StatelessWidget {
  TextEditingController textEditingController;
  final String title;
  String? Function(String?) validator;
  bool obscureText;

  LogIn_InputFiled(
      {required this.textEditingController,
      required this.title,
      required this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: AppColor),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: title,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: AppColor),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            fillColor: Colors.grey,
            focusColor: Colors.grey),
        controller: textEditingController,
      ),
    );
  }
} 