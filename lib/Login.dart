import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'Landing.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Image(
          image: AssetImage(
            'lib/assets/palette.png',
          ),
          fit: BoxFit.contain,
          width: 25,
          height: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .startFloat, //by default should be endFlot but this is for arabic demo purposes
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'lib/assets/background.png',
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
                color: Colors.transparent,
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: _buildLoginForm(context),
              ))
        ],
      ),
    );
  }

  _buildLoginForm(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                //space
                flex: 2,
                child: Container(),
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
                          flex: 3,
                          child: Container(
                              child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: double.infinity,
                            child: Text(
                              "نظام تتبع المراسلات",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.end,
                            ),
                          )),
                        ),
                        Flexible(
                          //space
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ])),
              Flexible(
                flex: 3,
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
                        flex: 3,
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
                                    "الاسم",
                                    textAlign: TextAlign.right,
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
                                            Radius.circular(6))),
                                    width: double.infinity,
                                    height: 50,
                                    child: TextField(
                                        textAlign: TextAlign
                                            .end, //should be start by default, end is for arabic demo purpose
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 5,
                                              bottom: 0,
                                              top: 0,
                                              right: 5),
                                        )),
                                  )),
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
                                    "كلمة المرور",
                                    textAlign: TextAlign.right,
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
                                            Radius.circular(6))),
                                    width: double.infinity,
                                    height: 50,
                                    child: TextField(
                                        textAlign: TextAlign
                                            .end, //should be start by default, end is for arabic demo purpose
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 5,
                                              bottom: 0,
                                              top: 0,
                                              right: 5),
                                        )),
                                  )),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          flex: 20,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 0,
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0),
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),
                                              child: ElevatedButton(
                                                onPressed: loginButtonPressed,
                                                child: Text(
                                                  "تسجيل الدخول",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                          color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                        ),
                                        Flexible(
                                          //space
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Flexible(
                                            flex: 8,
                                            child: ElevatedButton(
                                              onPressed: authenticate(),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                6))),
                                                child: Image(
                                                  image: AssetImage(
                                                      'lib/assets/faceid.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )),
                                        Spacer()
                                      ],
                                    ),
                                  )),
                            ])),
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
              Spacer(flex: 3),
              Container(
                  color: Colors.transparent,
                  height: 60,
                  child: Align(
                      alignment: FractionalOffset.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    height: 2,
                                  ))),
                          Container(
                            height: 23,
                          ),
                          Container(
                              height: 35,
                              child: Text(
                                "وزارة الخارجية © 2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.grey),
                              ))
                        ],
                      )))
            ],
          ),
        ));
  }

  authenticate() async {
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
}
