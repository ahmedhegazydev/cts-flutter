
import 'package:flutter/material.dart';

class CustomImageButton extends StatelessWidget {
VoidCallback onClick;
String imagePath;


CustomImageButton({required this.onClick, required this.imagePath});

@override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child:   Image(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
