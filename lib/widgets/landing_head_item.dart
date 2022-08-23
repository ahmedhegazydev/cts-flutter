import 'package:flutter/material.dart';


class LandingHeadItem extends StatelessWidget {
  final String title;
  final String value;


    LandingHeadItem({required this.title, required this.value });

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(
         5),
      child: Container(width: MediaQuery.of(context).size.width*.18,

        decoration:   BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 6,
              blurRadius: 6,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Container(
          color: Colors.transparent,

          child: FittedBox(fit: BoxFit.fill,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                  title,maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(
                        color: Colors.grey,
                        fontSize:16
                       // calculateFontSize(25, context)

                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                   value,maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
