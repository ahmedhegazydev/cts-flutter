// import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:test_app/main.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  double calculateHeight(double nb) {
    //the development was done on ipad 12 pro, the height in landscape is 1024
    double height = MediaQuery.of(context).size.height;
    return (height * nb) / 1024;
  }

  double calculateWidth(double nb) {
    //the development was done on ipad 12 pro, the width in landscape is 1366
    double width = MediaQuery.of(context).size.width;
    return (width * nb) / 1366;
  }

  _buildBody(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/assets/landing_background.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: _buildDataTable(context),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: _buildDashboardContainer(context)))
                  ]),
            )),
            Container(
              width: 120,
              height: double.infinity,
              color: Colors.grey.shade300,
              child: _buildSideMenu(context),
            ),
          ],
        ));
  }

  _buildSideMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            flex: 1,
            child: Container(
              height: calculateWidth(120),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Image(
                      image: AssetImage(
                        'lib/assets/signature.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "تواقيعي",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      ))
                ],
              ),
            )),
        Flexible(
            flex: 1,
            child: Container(
              height: 140,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Image(
                      image: AssetImage(
                        'lib/assets/fav_users.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: Text(
                        "المستخدمين المفضلين",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      ))
                ],
              ),
            )),
        Flexible(
            flex: 1,
            child: Container(
              height: 120,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Image(
                      image: AssetImage(
                        'lib/assets/delegation.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "تفويضاتي",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      ))
                ],
              ),
            )),
        Flexible(
            flex: 1,
            child: Container(
              height: 120,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Image(
                      image: AssetImage(
                        'lib/assets/palette_dark.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "سمات التطبيق",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      )),
                ],
              ),
            )),
        Flexible(
            flex: 1,
            child: Container(
              height: 120,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 3,
                    child: Image(
                      image: AssetImage(
                        'lib/assets/logout.png',
                      ),
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Text(
                        "تسجيل الخروج",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey.shade600),
                      ))
                ],
              ),
            ))
      ],
    );
  }

  _buildDashboardContainer(BuildContext contex) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(
            flex: 1,
          ),
          Flexible(
              flex: 2,
              child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: 60,
                          child: Text(
                            "نظام تتبع المراسلات",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.end,
                          ),
                        )),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "مرحبًا ربيع محمد المانع",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.grey),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Flexible(flex: 10, child: _buildDashboard(context)),
          Spacer(flex: 2),
          Flexible(
              flex: 1,
              child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          child: FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                height: 0.5,
                              ))),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 0, bottom: 0),
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "إدارة الخدمات المشتركة",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.grey),
                              ),
                              Image(
                                image: AssetImage(
                                  'lib/assets/arrow_left.png',
                                ),
                                fit: BoxFit.contain,
                                width: 50,
                                height: double.infinity,
                              )
                            ],
                          )),
                      Spacer(),
                    ],
                  )))
        ]);
  }

  _buildDashboard(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      // color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                padding:
                    EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    calculateDate("hh:mm", 'en'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 28),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    " " + calculateDate("a", 'en'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.grey.shade400,
                                            fontSize: 26),
                                  ),
                                )
                              ],
                            ),
                          )),
                      FractionallySizedBox(
                          heightFactor: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            width: 0.5,
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      calculateDate("dd", 'en'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(fontSize: 65),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      calculateDate("MMMM", 'ar') +
                                          " " +
                                          calculateDate("yyyy", 'en'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: Colors.grey.shade400,
                                              fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ))),
                    ],
                  ),
                ),
              )),
          Flexible(
              flex: 3,
              child: Container(
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, top: 0, bottom: 0),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
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
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "مراسلات تنتظر الإجراء",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "19",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(fontSize: 50),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 0, top: 0, bottom: 0),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
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
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "مراسلات غير مقروءة",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "05",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(fontSize: 50),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))),
                          ))
                    ],
                  ))),
          Flexible(
              flex: 3,
              child: Container(
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, top: 0, bottom: 0),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
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
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "أغلب إحالاتي ذهبت ل",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "نورا الجيدا",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(fontSize: 28),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 0, top: 0, bottom: 0),
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
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
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "إحالاتي في شهر مارس",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            "20",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(fontSize: 28),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))),
                          ))
                    ],
                  ))),
          Flexible(
              flex: 2,
              child: Container(
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, top: 0, bottom: 0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Spacer(flex: 2),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          "19",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  fontSize: 22,
                                                  color: createMaterialColor(
                                                      Color.fromRGBO(
                                                          247, 148, 29, 1))),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Spacer(flex: 1),
                                  Flexible(
                                      flex: 10,
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            "التنبيهات",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.right,
                                          ))),
                                  Flexible(
                                      flex: 2,
                                      child: Image(
                                        image: AssetImage(
                                          'lib/assets/notification.png',
                                        ),
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.grey,
                                      )),
                                  Spacer(flex: 2)
                                ],
                              ),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 0, top: 0, bottom: 0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Spacer(flex: 2),
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(
                                          "05",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  fontSize: 22,
                                                  color: createMaterialColor(
                                                      Color.fromRGBO(
                                                          247, 148, 29, 1))),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Spacer(flex: 1),
                                  Flexible(
                                      flex: 10,
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            "المحفوظات",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(color: Colors.grey),
                                            textAlign: TextAlign.right,
                                          ))),
                                  Flexible(
                                      flex: 2,
                                      child: Image(
                                        image: AssetImage(
                                          'lib/assets/flagged.png',
                                        ),
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.grey,
                                      )),
                                  Spacer(flex: 2)
                                ],
                              ),
                            ),
                          ))
                    ],
                  )))
        ],
      ),
    );
  }

  _buildDataTable(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 60,
          right: 60,
          top: calculateHeight(100),
          bottom: calculateHeight(80)),
      child: Container(
        decoration: BoxDecoration(
          color: createMaterialColor(Color.fromRGBO(255, 255, 255, 0.8)),
          borderRadius: BorderRadius.only(
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
        child: Column(
          children: [
            _buildDataLabelTitleLabel(context, "البريد"),
            Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid)),
              children: [
                TableRow(
                    children: [_buildInboxesRow(context, "لإجراء اللازم", 05)]),
                TableRow(children: [_buildInboxesRow(context, "للتوقيع", 07)]),
                TableRow(
                    children: [_buildInboxesRow(context, "لأخذ العلم", 09)]),
                TableRow(children: [_buildInboxesRow(context, "الكل", 21)])
              ],
            ),
            Container(
              height: 30,
            ),
            _buildDataLabelTitleLabel(context, "المصنفات"),
            Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid)),
              children: [
                TableRow(children: [
                  _buildOtherFoldersRows(
                      context, "المحفوظات", "lib/assets/flagged.png", true, 05)
                ]),
                TableRow(children: [
                  _buildOtherFoldersRows(context, "التنبيهات",
                      "lib/assets/notification.png", true, 19)
                ]),
              ],
            ),
            Container(
              height: 30,
            ),
            _buildDataLabelTitleLabel(context, "البحث"),
            Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                  bottom: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid)),
              children: [
                TableRow(children: [
                  _buildOtherFoldersRows(
                      context, "بحث متقدم", "lib/assets/search.png", false, 0)
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildDataLabelTitleLabel(BuildContext context, String title) {
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
        color: Colors.transparent,
        width: double.infinity,
        height: calculateHeight(50),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.grey.shade400, fontSize: 12),
          textAlign: TextAlign.right,
        ));
  }

  _buildInboxesRow(BuildContext content, String title, int count) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 2,
              child: Image(
                image: AssetImage(
                  'lib/assets/arrow_left.png',
                ),
                fit: BoxFit.contain,
                width: 50,
                height: double.infinity,
              )),
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
                  textAlign: TextAlign.left,
                )),
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
                  textAlign: TextAlign.right,
                )),
          ),
          Spacer(flex: 1),
          Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6))),
                width: 12,
                height: 12,
              ))
        ],
      ),
    );
  }

  _buildOtherFoldersRows(BuildContext context, String title, String iconTitle,
      bool showCount, int count) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              flex: 2,
              child: Image(
                image: AssetImage(
                  'lib/assets/arrow_left.png',
                ),
                fit: BoxFit.contain,
                width: 50,
                height: double.infinity,
              )),
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
                  textAlign: TextAlign.left,
                )),
          )),
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
                  textAlign: TextAlign.right,
                )),
          ),
          Spacer(flex: 1),
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
              ))
        ],
      ),
    );
  }
}

String calculateDate(String dateFormat, String locale) {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  var formatter = DateFormat(dateFormat, locale);
  String date = formatter.format(now);
  return date;
}
