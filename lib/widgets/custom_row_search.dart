

import 'package:flutter/material.dart';

import 'custom_button_with_icon.dart';

class CustomRowSearch extends StatelessWidget {

   TextEditingController textEditingController;
   IconData icon1;
   VoidCallback onClick1;
   IconData icon2;
   VoidCallback onClick2;
   IconData icon3;
    VoidCallback onClick3;
String hint;

   CustomRowSearch(
      {
 required   this.textEditingController,this.hint="",
 required this.icon1,
 required this.onClick1,
 required this.icon2,
 required this.onClick2,
 required this.icon3, required     this.onClick3
     });

  @override
  Widget build(BuildContext context) {
    return    Row(
      children: [
        Expanded(
            child: Container(padding: EdgeInsets.only(right: 8,left: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(6))),
                child: TextField(   controller: textEditingController,
                  decoration:   InputDecoration(hintText:hint ,
                    border: UnderlineInputBorder(),
                    labelText: hint,
                  ),

                ))),
        const SizedBox(
          width: 8,
        ),
        InkWell(onTap: onClick1,
    child: Container(width: 50, height: 50,
    decoration: BoxDecoration(
    color: Theme
        .of(context)
        .colorScheme
        .primary,
    borderRadius:
    const BorderRadius.all(Radius.circular(6))),
    child: Center(child: Icon(icon1)),),
    ),
        const SizedBox(
          width: 2,
        ),
        CustomButtonWithIcon(
            icon:icon2 ,
            onClick: onClick2),
        const SizedBox(
          width: 2,
        ),
        CustomButtonWithIcon(
            icon: icon3,
            onClick:onClick3),
      ],
    );
  }


}
