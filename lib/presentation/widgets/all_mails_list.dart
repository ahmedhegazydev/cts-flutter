import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/main.dart';
import 'package:cts/presentation/screens/document_page.dart';

class AllMailsList extends StatefulWidget {
  const AllMailsList({Key? key}) : super(key: key);

  @override
  _AAllMailsListstate createState() => _AAllMailsListstate();
}

class _AAllMailsListstate extends State<AllMailsList> {
  bool filterUnread = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          //filter bar
          Container(
            width: width,
            height: 85,
            color: Colors.grey.shade100,
            child: _buildFilterBar(context),
          ),
          Container(
            width: width,
            height: 600,
            color: Colors.transparent,
            child: _buildMailsList(),
          ),
        ],
      ),
    );
  }

  openPDFPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => DocumentPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  ListView _buildMailsList() {
    return new ListView.builder(
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: openPDFPage,
          child: SizedBox(
            height: 150,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300] ?? Colors.transparent,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                ),
                              ),
                              width: 12,
                              height: 12,
                            ),
                          ),
                          Text(
                            'اقتراح تعديل السقف السنوي',
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      color: Colors.grey[700],
                                      fontSize: 19,
                                    ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding:
                            const EdgeInsets.only(right: 40, left: 40, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'المرسل: شفيق عبدالرحمن',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.grey[400],
                                    fontSize: 13,
                                  ),
                            ),
                            Text(
                              '08/09/2021',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.grey[400],
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: SizedBox(
                        height: 50,
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Container(
                                height: 30,
                                color: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      Text(
                                        AppLocalizations.of(context)!.closed +
                                            " / " +
                                            "محمد الجابر",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 12),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
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
            ),
          ),
        );
      },
    );
  }

  _buildFilterBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //read / unread container
          Flexible(
            flex: 2,
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: filterUnread,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      checkColor: Theme.of(context).colorScheme.primary,
                      activeColor: Colors.grey.shade300,
                      fillColor:
                          MaterialStateProperty.all(Colors.grey.shade300),
                      onChanged: (bool? value) {
                        setState(() {
                          this.filterUnread = value ?? false;
                        });
                      },
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.unread,
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
              heightFactor: 0.7,
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
          //fav users container
          Flexible(
            flex: 7,
            child: _buildFilterSenders(context),
          ),
          FractionallySizedBox(
            heightFactor: 0.7,
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
          //urgnet / secret filter container
          Flexible(
            flex: 5,
            child: Container(
              color: Colors.transparent,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 40,
                              height: double.infinity,
                              color: Colors.transparent,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/urgent.png',
                                ),
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.urgent,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 40,
                              height: double.infinity,
                              color: Colors.transparent,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/secret.png',
                                ),
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                color: createMaterialColor(
                                  Color.fromRGBO(77, 77, 77, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.secret,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: createMaterialColor(
                                            Color.fromRGBO(77, 77, 77, 1),
                                          ),
                                          fontSize: 14),
                                  textAlign: TextAlign.start,
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
          ),
          FractionallySizedBox(
            heightFactor: 0.7,
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
          //clear button container
          Container(
            width: 90,
            height: 40,
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
                'assets/images/clear_filter.png',
              ),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }

  _buildFilterSenders(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              AppLocalizations.of(context)!.sender,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: FractionallySizedBox(
                    heightFactor: 0.65,
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
                    heightFactor: 0.65,
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
                    heightFactor: 0.65,
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
                    heightFactor: 0.65,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
