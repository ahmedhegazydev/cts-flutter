import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_cart/create_basket_controller.dart';

Widget buildHorizontalListViewCircleColors(BuildContext context) {
  List<Color> colorArray = [
    Color(0xFFFF6633),
    Color(0xFFFFB399),
    Color(0xFFFF33FF),
    Color(0xFFFFFF99),
    Color(0xFF00B3E6),
    Color(0xFFE6B333),
    Color(0xFF3366E6),
    Color(0xFF999966),
    Color(0xFF99FF99),
    Color(0xFFB34D4D),
    Color(0xFF80B300),
    Color(0xFF809900),
    Color(0xFFE6B3B3),
    Color(0xFF6680B3),
    Color(0xFF66991A),
    Color(0xFFFF99E6),
    Color(0xFFCCFF1A),
    Color(0xFFFF1A66),
    Color(0xFFE6331A),
    Color(0xFF33FFCC),
    Color(0xFF66994D),
    Color(0xFFB366CC),
    Color(0xFF4D8000),
    Color(0xFFB33300),
    Color(0xFFCC80CC),
    Color(0xFF66664D),
    Color(0xFF991AFF),
    Color(0xFFE666FF),
    Color(0xFF4DB3FF),
    Color(0xFF1AB399),
    Color(0xFFE666B3),
    Color(0xFF33991A),
    Color(0xFFCC9999),
    Color(0xFFB3B31A),
    Color(0xFF00E680),
    Color(0xFF4D8066),
    Color(0xFF809980),
    Color(0xFFE6FF80),
    Color(0xFF1AFF33),
    Color(0xFF999933),
    Color(0xFFFF3380),
    Color(0xFFCCCC00),
    Color(0xFF66E64D),
    Color(0xFF4D80CC),
    Color(0xFF9900B3),
    Color(0xFFE64D66),
    Color(0xFF4DB380),
    Color(0xFFFF4D4D),
    Color(0xFF99E6E6),
    Color(0xFF6666FF)
  ];
  return Container(
      width: MediaQuery.of(context).size.width * .3,
      height: MediaQuery.of(context).size.height * .5,
      // height: 100,
      child:
          // ListView(
          //   scrollDirection: Axis.horizontal,
          //   children: <Widget>[
          //     Container(
          //       width: 60,
          //       height: 60,
          //       // child: Icon(CustomIcons.option, size: 20,),
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Color(0xFFe0f2f1)),
          //     ),
          //
          //   ],
          // ),
          GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
        itemBuilder: (_, index) => Center(
            child: GestureDetector(
          child: Container(
            width: 60,
            height: 60,
            // child: Icon(CustomIcons.option, size: 20,),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: colorArray[index]),
          ),
          onTap: () {
            var selectedColor = colorArray[index];
            Get.find<CreateBasketController>().setPickerColor(selectedColor);
            Navigator.pop(context);
          },
        )),
        itemCount: colorArray.length,
      ));
}
