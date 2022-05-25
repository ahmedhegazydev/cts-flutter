import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {

String appTitle;
VoidCallback onTap;
String path;
CustomTopBar({required this.appTitle, required this.onTap,this.path=   'assets/images/menu.png'});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding:
                const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
                child: Text(
                 appTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 120,
            height: double.infinity,
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
             path,
              ),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ],
    );
  }


}
