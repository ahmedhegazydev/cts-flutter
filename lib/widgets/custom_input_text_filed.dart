
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CustomInputTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;

    String? Function(String?)? validator;
final String label;
     CustomInputTextFiled({required this.textEditingController,required this.validator,required this.label });

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(label),
        ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            width: double.infinity,

            child: TextFormField(
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
