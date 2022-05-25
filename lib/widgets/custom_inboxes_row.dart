import 'package:flutter/material.dart';

import '../utility/utilitie.dart';

class CustomInboxesRow extends StatelessWidget {

  String title;
  int count;
double  height;

  CustomInboxesRow({required this.title, required this.count,required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: height,//calculateHeight(80, context),
      color: Colors.transparent,
      child: Directionality(textDirection:TextDirection.rtl ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(6),
                  //   topRight: Radius.circular(6),
                  //   bottomLeft: Radius.circular(6),
                  //   bottomRight: Radius.circular(6),
                  // ),
                ),
                width: 12,
                height: 12,
              ),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 15,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Spacer(flex: 1),
            Flexible(
              child: Container(
                color: Colors.transparent,
                width: 40,
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 17),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Image(
                image: AssetImage(
                  returnImageNameBasedOnOppositeDirection(
                      "assets/images/arrow", context, "png"),
                ),
                fit: BoxFit.contain,
                width: 50,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
