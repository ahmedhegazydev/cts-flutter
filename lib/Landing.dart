import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Inbox.dart';

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

  _buildBody(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 120,
              height: double.infinity,
              color: Colors.grey.shade300,
              child: _buildSideMenu(context),
            ),
            Flexible(
                child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(returnImageNameBasedOnDirection(
                      "lib/assets/landing_background", context, "png")),
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
                            child: _buildDashboardContainer(context))),
                    Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: _buildDataTable(context),
                        )),
                  ]),
            )),
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
              height: calculateWidth(120, context),
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
                        AppLocalizations.of(context)!.mySignatures,
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
                        AppLocalizations.of(context)!.favoritesUsers,
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
                        AppLocalizations.of(context)!.myDelegations,
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
                        AppLocalizations.of(context)!.appTheme,
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
                        AppLocalizations.of(context)!.logout,
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
                            AppLocalizations.of(context)!.appTitle,
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.start,
                          ),
                        )),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          AppLocalizations.of(context)!.hello +
                              " ربيع محمد المانع",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.grey),
                          textAlign: TextAlign.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                image: AssetImage(
                                    returnImageNameBasedOnOppositeDirection(
                                        "lib/assets/arrow", context, "png")),
                                fit: BoxFit.contain,
                                width: 50,
                                height: double.infinity,
                              ),
                              Text(
                                "إدارة الخدمات المشتركة",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.grey),
                                textAlign: TextAlign.start,
                              ),
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
                                          .copyWith(
                                              fontSize: calculateFontSize(
                                                  65, context)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      calculateDate(
                                              "MMMM", getLocaleCode(context)) +
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
                          ))
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
                                            AppLocalizations.of(context)!
                                                .unreadCorrespondences,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
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
                                            AppLocalizations.of(context)!
                                                .pendingCorrespondences,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
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
                                            AppLocalizations.of(context)!
                                                    .myTransfersInMonth +
                                                " " +
                                                calculateDate('MMMM',
                                                    getLocaleCode(context)),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
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
                                            AppLocalizations.of(context)!
                                                .mostMyTransferWentTo,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
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
                                  Spacer(flex: 1),
                                  Flexible(
                                      flex: 10,
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .flagged,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
                                            textAlign: TextAlign.start,
                                          ))),
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
                                  Spacer(flex: 1),
                                  Flexible(
                                      flex: 10,
                                      child: Container(
                                          width: double.infinity,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .notifications,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize: calculateFontSize(
                                                        16, context)),
                                            textAlign: TextAlign.start,
                                          ))),
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
          top: calculateHeight(100, context),
          bottom: calculateHeight(80, context)),
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
            _buildDataLabelTitleLabel(
                context, AppLocalizations.of(context)!.mail),
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
                  _buildInboxesRow(
                      context, AppLocalizations.of(context)!.forAction, 05)
                ]),
                TableRow(children: [
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(context,
                          AppLocalizations.of(context)!.forSignature, 07))
                ]),
                TableRow(children: [
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                          context, AppLocalizations.of(context)!.forInfo, 09))
                ]),
                TableRow(children: [
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildInboxesRow(
                          context, AppLocalizations.of(context)!.all, 21))
                ])
              ],
            ),
            Container(
              height: 30,
            ),
            _buildDataLabelTitleLabel(
                context, AppLocalizations.of(context)!.folders),
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
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          AppLocalizations.of(context)!.flagged,
                          "lib/assets/flagged.png",
                          true,
                          05))
                ]),
                TableRow(children: [
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          AppLocalizations.of(context)!.notifications,
                          "lib/assets/notification.png",
                          true,
                          19))
                ]),
              ],
            ),
            Container(
              height: 30,
            ),
            _buildDataLabelTitleLabel(
                context, AppLocalizations.of(context)!.search),
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
                  TableRowInkWell(
                      onTap: () {
                        openInbox();
                      },
                      child: _buildOtherFoldersRows(
                          context,
                          AppLocalizations.of(context)!.advancedSearch,
                          "lib/assets/search.png",
                          false,
                          0))
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
        height: calculateHeight(50, context),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.grey.shade400, fontSize: 12),
          textAlign: TextAlign.start,
        ));
  }

  _buildInboxesRow(BuildContext content, String title, int count) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80, context),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
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
                  textAlign: TextAlign.start,
                )),
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
                )),
          ),
          Flexible(
              flex: 2,
              child: Image(
                image: AssetImage(returnImageNameBasedOnOppositeDirection(
                    "lib/assets/arrow", context, "png")),
                fit: BoxFit.contain,
                width: 50,
                height: double.infinity,
              )),
        ],
      ),
    );
  }

  _buildOtherFoldersRows(BuildContext context, String title, String iconTitle,
      bool showCount, int count) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80, context),
      color: Colors.transparent,
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
                  textAlign: TextAlign.start,
                )),
          ),
          Spacer(flex: 1),
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
                )),
          )),
          Flexible(
              flex: 2,
              child: Image(
                image: AssetImage(returnImageNameBasedOnOppositeDirection(
                    "lib/assets/arrow", context, "png")),
                fit: BoxFit.contain,
                width: 50,
                height: double.infinity,
              )),
        ],
      ),
    );
  }

  openInbox() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => InboxPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
}
