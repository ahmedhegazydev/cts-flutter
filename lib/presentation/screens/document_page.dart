import 'package:cts/constants/globals.dart';
import 'package:cts/constants/routes.dart';
import 'package:cts/data/controllers/document_controller.dart';
import 'package:cts/presentation/widgets/paint_triangle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/presentation/widgets/pdf_widget.dart';
import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends StatefulWidget {
  final String? fromStructure1;
  final String? fromStructure2;
  final String? fromUser;
  final String? transferDate;
  final String? instructionsNote;
  final String? privacy;
  final String? priority;
  DocumentPage(
      {this.fromStructure1,
      this.fromStructure2,
      this.fromUser,
      this.transferDate,
      this.instructionsNote,
      this.privacy,
      this.priority});
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  bool portraitIsActive = false;
  @override
  Widget build(BuildContext context) {
    final documentStateNotifier = ChangeNotifierProvider<DocumentController>(
        (ref) => DocumentController());
    return Consumer(
      builder: (
        BuildContext context,
        T Function<T>(ProviderBase<Object?, T>) watch,
        Widget? child,
      ) {
        final documentData = watch(documentStateNotifier);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: _buildBody(context, documentData),
        );
      },
    );
  }

  _buildBody(BuildContext context, DocumentController documentControllerRes) {
    Orientation orientation = MediaQuery.of(context).orientation;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterBar(context, documentControllerRes),
              orientation == Orientation.landscape
                  ? Container()
                  : InkWell(
                      // onTap:,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            scale: 1.9,
                            image: AssetImage(
                              'assets/images/metadata.png',
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[500],
          height: 1,
        ),
        documentControllerRes.documentModel.attachments == null
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: CircularProgressIndicator(),
              )
            : _buildDoucmentArea(documentControllerRes),
      ],
    );
  }

  Expanded _buildDoucmentArea(DocumentController documentControllerRes) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      portraitIsActive = false;
    } else {
      portraitIsActive = true;
    }
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
              PDFWidget(
                portraitIsActive,
                documentControllerRes
                    .documentModel.attachments!.attachments![0].annotations!,
                documentControllerRes
                    .documentModel.attachments!.attachments![0].uRL!,
              ),
              orientation == Orientation.landscape
                  ? Expanded(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        color: Colors.grey[700],
                                        fontSize: 18,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/metadata.png',
                                    ),
                                    width: 18,
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
                                          widget.priority ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.transparent,
                                            child: Image(
                                              image: AssetImage(
                                                'assets/images/secret.png',
                                              ),
                                              alignment: Alignment.center,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              widget.privacy ?? "",
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.fromStructure1 ?? "",
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
                              widget.fromStructure2 ?? "",
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
                              widget.fromUser ?? "",
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
                              AppLocalizations.of(context)!.referDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.transferDate ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              widget.instructionsNote ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
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
                                    AppLocalizations.of(context)!.localeName ==
                                            "en"
                                        ? 20
                                        : 0,
                                left:
                                    AppLocalizations.of(context)!.localeName ==
                                            "en"
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
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
                    )
                  : Container(),
            ],
          ),
          documentControllerRes.openExportDialog == true
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
          documentControllerRes.openExportDialog == true
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
          InkWell(
            onTap: () {
              Globals.navigatorKey.currentState?.pushNamed(LandingPageRoute);
            },
            child: Container(
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

  _buildFilterBar(
      BuildContext context, DocumentController documentControllerRes) {
    var defaultLocale = ui.window.locale.languageCode;
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
                  defaultLocale == "ar"
                      ? "assets/images/arrow_R.png"
                      : "assets/images/arrow_L.png",
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
                    child: Image(
                      image: AssetImage(
                        'assets/images/refer.png',
                      ),
                      width: 20,
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
          onTap: documentControllerRes.changeExportDialogState,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Image(
                      image: AssetImage(
                        'assets/images/up_arrow.png',
                      ),
                      width: 15,
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
                  child: Image(
                    image: AssetImage(
                      'assets/images/ending.png',
                    ),
                    width: 18,
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
                  child: Image(
                    image: AssetImage(
                      'assets/images/track.png',
                    ),
                    width: 18,
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
                  child: Image(
                    image: AssetImage(
                      'assets/images/referrals.png',
                    ),
                    width: 18,
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
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
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
              height:
                  orientation == Orientation.landscape ? height - 200 : height,
              width: orientation == Orientation.landscape ? width - 400 : width,
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
                            child: Image.asset(
                              'assets/images/refer.png',
                              width: 20,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/close_button.png',
                          width: 35,
                        ),
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
                    width: orientation == Orientation.landscape
                        ? width - 400
                        : width,
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
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(
                                          'assets/images/close_button.png',
                                          width: 25,
                                        ),
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
                                            width: orientation ==
                                                    Orientation.portrait
                                                ? (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.6)
                                                : 300,
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
