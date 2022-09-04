import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;

  String? Function(String?)? validator;
  final String label;
  bool obscureText;

  CustomInputTextFiled(
      {required this.textEditingController,
      required this.validator,
        this.obscureText=false,
        required this.label});

  @override
  Widget build(BuildContext context) {

     print("Get.deviceLocale==>   ${Get.deviceLocale?.languageCode=="en"}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            // color: Colors.red,
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
            ),
            child: Text(  label,style: TextStyle(fontSize: 14),

              textDirection: Get.locale?.languageCode=="en"?
              TextDirection.ltr: TextDirection.rtl ,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              // color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            width: double.infinity,
            child: TextFormField(
              obscureText: obscureText,
              textAlign: TextAlign.center,
              validator: validator,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 5, bottom: 0, top: 0, right: 5),
              ),
              controller: textEditingController,
            ),
          ),
        ],
      ),
    );
  }
}
