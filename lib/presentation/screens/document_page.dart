import 'package:cts/presentation/widgets/paint_triangle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/presentation/widgets/pdf_page.dart';

class DocumentPage extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  bool openExportDialog = false;
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
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 65,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[200],
                child: _buildSideMenu(context),
              ),
              PDFPage(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.data,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.grey[700],
                                      fontSize: 18,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 10, left: 5, right: 5),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Image(
                                    alignment: Alignment.center,
                                    image: AssetImage(
                                      'assets/images/urgent.png',
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.urgent,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Container(
                              height: 30,
                              width: 120,
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/secret.png',
                                        ),
                                        alignment: Alignment.center,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.secret,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 12),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        AppLocalizations.of(context)!.sender1,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "اقتراح تعديل السقف السنوي لموازنات الاقسام التابعة لادارة الخدمات المشتركة",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.black, fontSize: 13),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.sender1,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context)!
                            .sharedServicesAdministration,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.black, fontSize: 13),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.sender1,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "شفيق عبةالرحمن",
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.black, fontSize: 13),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.assignedFrom,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "12/03/2021",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.assignmentNotes,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "الرجاء قراءه الكتاب والتفضل بالتوقيع اذا آمكن",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 40,
                        width: 100,
                        margin: EdgeInsets.only(
                          right:
                              AppLocalizations.of(context)!.localeName == "en"
                                  ? 20
                                  : 0,
                          left: AppLocalizations.of(context)!.localeName == "en"
                              ? 0
                              : 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                child: Divider(
                                  color: Colors.grey[400],
                                  thickness: 2,
                                ),
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.play_arrow,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          openExportDialog == true
              ? AppLocalizations.of(context)!.localeName == "en"
                  ? Positioned(
                      top: 20,
                      left: 180,
                      child: _openExportDialog(),
                    )
                  : Positioned(
                      top: 20,
                      right: 180,
                      child: _openExportDialog(),
                    )
              : Container(),
          openExportDialog == true
              ? AppLocalizations.of(context)!.localeName == "ar"
                  ? Positioned(
                      top: -20,
                      right: 200,
                      child: CustomPaint(
                        size: Size(40, 40),
                        painter: PaintTriangle(
                          backgroundColor: Colors.grey[200] ?? Colors.grey,
                        ),
                      ),
                    )
                  : Positioned(
                      top: -20,
                      left: 200,
                      child: CustomPaint(
                        size: Size(40, 40),
                        painter: PaintTriangle(
                          backgroundColor: Colors.grey[200] ?? Colors.grey,
                        ),
                      ),
                    )
              : Container(),
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
            AppLocalizations.of(context)!.comment,
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
            AppLocalizations.of(context)!.signature,
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
              AppLocalizations.of(context)!.marking,
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
            AppLocalizations.of(context)!.save,
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
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: Colors.grey[350],
            height: 500,
            width: 65,
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
        ),
        InkWell(
          onTap: _openReferDialog,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Icon(
                      Icons.send_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.refer,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        FractionallySizedBox(
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
        InkWell(
          onTap: changeExportDialogState,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Icon(
                      Icons.send_sharp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.export,
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        FractionallySizedBox(
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
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Icon(
                    Icons.send_sharp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.ending,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        FractionallySizedBox(
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
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Icon(
                    Icons.send_sharp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.tracking,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        FractionallySizedBox(
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
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Icon(
                    Icons.send_sharp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.referrals,
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

  _openReferDialog() {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              height: height - 200,
              width: width - 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Icon(
                              Icons.send_sharp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.refer,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                          ),
                        ],
                      ),
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        fillColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15,
                        ),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      AppLocalizations.of(context)!.referTo,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 350,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/unknown_user.png',
                                    ),
                                    fit: BoxFit.fitHeight),
                                border: Border.all(
                                  width: 4,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/unknown_user.png',
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                                border: Border.all(
                                  width: 4,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/unknown_user.png',
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                                border: Border.all(
                                  width: 4,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
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
                        Flexible(
                          flex: 1,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/unknown_user.png',
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                                border: Border.all(
                                  width: 4,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 0,
                          fillColor: Colors.grey[300],
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 20,
                          ),
                          padding: EdgeInsets.all(14),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[400],
                  ),
                  Container(
                    width: width - 400,
                    height: height - 450,
                    child: ListView(
                      children: [
                        Container(
                          width: 1000,
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/unknown_user.png',
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                                border: Border.all(
                                                  width: 4,
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "شفيق عبدالرحمن",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                    color: Colors.grey[600],
                                                    fontSize: 15,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        fillColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        shape: CircleBorder(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.action,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                color: Colors.grey[600],
                                                fontSize: 15,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
                                            height: 40,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[350],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey[400],
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .audioNotes,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                color: Colors.grey[600],
                                                fontSize: 15,
                                              ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
                                            height: 40,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[350],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Icon(
                                                    Icons.mic_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 20,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 10,
                                                      left: 10,
                                                    ),
                                                    child: Divider(
                                                      color: Colors.grey[400],
                                                      thickness: 2,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  child: Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    right: 10,
                                    left: 10,
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: 900,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            right: 5,
                                            left: 5,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .writtenNote,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  changeExportDialogState() {
    setState(() {
      openExportDialog = !openExportDialog;
    });
  }

  Container _openExportDialog() {
    List<String> titles = [
      AppLocalizations.of(context)!.paperExport,
      AppLocalizations.of(context)!.electronicExport,
      AppLocalizations.of(context)!.paperAndElectronicExport,
    ];

    return Container(
      height: 168,
      width: 230,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 170,
            color: Colors.grey[400],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                titles.length,
                (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              titles[index],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
