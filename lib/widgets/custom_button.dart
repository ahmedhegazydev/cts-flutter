import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onPressed;
  String name;

  CustomButton({
    required this.onPressed,
    // required this.onPressed,
    required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
