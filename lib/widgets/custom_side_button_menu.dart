
import 'package:flutter/material.dart';

import '../utility/utilitie.dart';

class CustomSideButtonMenu extends StatelessWidget {
  CustomSideButtonMenu(
      {Key? key,
        required this.onClick,
        required this.image,
        required this.label})
      : super(key: key);
  VoidCallback onClick;
  String image;
  String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(onTap: onClick,
      child: SizedBox(
        width: size.width * .15,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Image.asset(
              image
              //
              ,
              height: 30,
              width:30,fit: BoxFit.fill,
            ),const SizedBox(width: 8,),
            Text(
              label,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                color: createMaterialColor(
                  const Color.fromRGBO(77, 77, 77, 1),
                ),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,

              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
      ),
    );
  }
}
