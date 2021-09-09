import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/presentation/widgets/pdf_page.dart';

class DocumentPage extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //top bar
        Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: _buildTopBar(context),
        ),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: _buildFilterBar(context),
        ),
        Divider(
          color: Colors.grey[500],
          height: 1,
        ),
        _buildDoucmentArea(),
      ],
    );
  }

  Expanded _buildDoucmentArea() {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 60,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            child: _buildSideMenu(context),
          ),
          PDFPage(),
        ],
      ),
    );
  }

  _buildTopBar(BuildContext context) {
    return Container(
      child: Row(
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
                      EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
                  child: Text(
                    AppLocalizations.of(context)!.appTitle,
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
          Container(
            width: 120,
            height: double.infinity,
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
                'assets/images/menu.png',
              ),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  _buildSideMenu(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              'assets/images/comment.png',
            ),
            width: 30,
          ),
          Text(
            "تعليق",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey.shade600),
          ),
          SizedBox(height: 20),
          Image(
            image: AssetImage(
              'assets/images/signature.png',
            ),
            width: 50,
          ),
          Text(
            "توقيع",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey.shade600),
          ),
          SizedBox(height: 30),
          Image(
            image: AssetImage(
              'assets/images/font.png',
            ),
            width: 30,
          ),
          Flexible(
            child: Text(
              "وسم",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.grey.shade600),
            ),
          ),
          SizedBox(height: 30),
          Image(
            image: AssetImage(
              'assets/images/save.png',
            ),
            width: 30,
          ),
          Text(
            "حفظ",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  _buildFilterBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[350],
          height: 500,
          width: 60,
          child: Center(
            child: Image(
              image: AssetImage(
                "assets/images/arrow_R.png",
              ),
              color: Colors.white,
              width: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            Icons.send_sharp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "احاله",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        //separator
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              width: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            Icons.send_sharp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "تصدير",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        //separator
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              width: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            Icons.send_sharp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "انهاء",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        //separator
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              width: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            Icons.send_sharp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "تتبع",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        //separator
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FractionallySizedBox(
            heightFactor: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              width: 0.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Icon(
            Icons.send_sharp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Text(
                  "الاحالات",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
