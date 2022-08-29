
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;

    String? Function(String?)? validator;
    bool obscureText;
final String label;
     CustomInputTextFiled({required this.textEditingController,required this.validator,required this.label ,this.obscureText=false});

   @override
  Widget build(BuildContext context) {

     print("Get.deviceLocale==>   ${Get.deviceLocale?.languageCode=="en"}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(    crossAxisAlignment :CrossAxisAlignment.start,
      //  mainAxisAlignment:  Get.deviceLocale?.languageCode=="en"?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(width: double.infinity,color: Colors.red,child: Text(label,textAlign: TextAlign.start)),
        ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            width: double.infinity,

            child: TextFormField(obscureText: obscureText,
              textAlign: TextAlign.start,validator:validator ,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(
                    left: 5, bottom: 0, top: 0, right: 5),
              ),
              controller: textEditingController,

            ),
          ),
        ],
      ),
    );
  }
}
