import 'package:flutter/material.dart';

import '../utility/utilitie.dart';

class CustomButtonWithImage extends StatelessWidget {
  CustomButtonWithImage(
      {Key? key,
    //  required this.onClick,
      required this.image,
      required this.label})
      : super(key: key);
//  VoidCallback onClick;
  String image;
  String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
         width: 150,//size.width * .13,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Image.asset(
            image
            //
            ,
            height: 30,
            width: 30,color: Theme.of(context)
              .colorScheme
              .primary,
          ),SizedBox(width: 16,),
          Text(
            label,
            style: Theme.of(context).textTheme.headline3!.copyWith(
              color: createMaterialColor(
                const Color.fromRGBO(77, 77, 77, 1),
              ),
              fontSize: 20,fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,

            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
    );
  }
}
