import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/utilitie.dart';

class CustomLandingRow extends StatelessWidget {
  String title;
  String iconTitle;

  bool showCount;
  int count;
double height;
  CustomLandingRow({required this.title, required this.iconTitle, required this.showCount, required this.count,required this.height});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: orientation == Orientation.landscape ? 20 : 0,
            bottom: 0),
        width: double.infinity,
        height: height,
          // calculateHeight(
          //   orientation == Orientation.landscape ? 80 : 60, context),
        color: Colors.transparent,
        child: Directionality(textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  child: Image(
                         image: AssetImage(

                      iconTitle,
                    ),
                    fit: BoxFit.contain,
                    width: 50,
                    height: double.infinity,
                  ),
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
              const Spacer(flex: 1),
              Flexible(
                child: Visibility(
                  visible: showCount,
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
              ),
              Flexible(
                flex: 2,
                child: Image(
                  image: AssetImage(
                  // Get.locale=="en"?
                  // "assets/images/arrow_R.png":
                  // "assets/images/arrow_L.png"

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
      ),
    );
  }
}
