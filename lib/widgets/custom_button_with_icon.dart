
import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {

final IconData icon;
final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClick,
      child: Container(width: 50, height: 50,
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primary,
            borderRadius:
            const BorderRadius.all(Radius.circular(6))),
      child: Center(child: Icon(icon)),),
    );
  }

CustomButtonWithIcon({required this.icon,required this.onClick});
}
