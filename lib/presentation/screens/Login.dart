import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:cts/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Landing.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: orientation == Orientation.landscape
          ? landscapeBody(context)
          : portraitBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Image(
          image: AssetImage(
            'assets/images/palette.png',
          ),
          fit: BoxFit.contain,
          width: 25,
          height: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  portraitBody(BuildContext context) {
    return Center(
      child: loginForm(context),
    );
  }

  landscapeBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            returnImageNameBasedOnDirection(
                "assets/images/background", context, "png"),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: loginForm(context),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  loginForm(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          orientation == Orientation.portrait
              ? Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Image.asset(
                    "assets/images/arrow_left.png",
                    width: 480,
                  ),
                )
              : Container(),
          orientation == Orientation.landscape
              ? Flexible(
                  //space
                  flex: 2,
                  child: Container(),
                )
              : SizedBox(
                  height: 70,
                ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  //space
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Flexible(
                  flex: orientation == Orientation.landscape ? 5 : 2,
                  child: Container(
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                      child: Text(
                        AppLocalizations.of(context)!.appTitle,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  //space
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              width: 550,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    //space
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 5),
                            width: double.infinity,
                            // height: double.infinity,
                            child: Text(
                              AppLocalizations.of(context)!.name,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 5, bottom: 0, top: 0, right: 5),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          //space
                          flex: 1,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 5),
                            width: double.infinity,
                            // height: double.infinity,
                            child: Text(
                              AppLocalizations.of(context)!.password,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            width: double.infinity,
                            height: 50,
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 5, bottom: 0, top: 0, right: 5),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          //space
                          flex: 2,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            height: 65,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Spacer(),
                                Flexible(
                                  flex: 8,
                                  child: GestureDetector(
                                    onTap: () => _authenticate(context),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/faceid.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  //space
                                  flex: 1,
                                  child: Container(),
                                ),
                                Flexible(
                                  flex: 20,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 0, right: 0, top: 0, bottom: 0),
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    child: ElevatedButton(
                                      onPressed: loginButtonPressed,
                                      child: Text(
                                        AppLocalizations.of(context)!.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    //space
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          orientation == Orientation.landscape
              ? Spacer(flex: 3)
              : Spacer(flex: 1),
          orientation == Orientation.portrait
              ? Flexible(
                  flex: 4,
                  child: SingleChildScrollView(
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              Align(
                                alignment: FractionalOffset.bottomRight,
                                child: Image.asset(
                                  "assets/images/login_background.png",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Image.asset(
                                  "assets/images/loginShadow.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: Image.asset(
                              "assets/images/arrow_right.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Container(
            color: Colors.transparent,
            height: 60,
            width: 200,
            child: Align(
              alignment: FractionalOffset.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        height: 2,
                      ),
                    ),
                  ),
                  Container(
                    height: 23,
                  ),
                  Container(
                    height: 35,
                    child: Text(
                      AppLocalizations.of(context)!.copyrights +
                          getCurrentYearString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _authenticate(BuildContext context) async {
    bool didAuthenticate = await LocalAuthentication().authenticate(
        localizedReason: 'Please authenticate to Login', biometricOnly: true);
    if (didAuthenticate) {
      loginButtonPressed();
    }
  }

  loginButtonPressed() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LandingPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  String getCurrentYearString() {
    initializeDateFormatting();
    DateTime now = DateTime.now();
    var formatter = DateFormat("yyyy", "en");
    String date = formatter.format(now);
    return date;
  }
}
