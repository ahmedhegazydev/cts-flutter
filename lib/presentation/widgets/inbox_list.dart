import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:cts/data/controllers/inbox_controller.dart';
import 'package:cts/data/models/CorrespondencesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cts/main.dart';
import 'package:cts/presentation/screens/document_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InboxList extends StatefulWidget {
  const InboxList({Key? key}) : super(key: key);

  @override
  _InboxListstate createState() => _InboxListstate();
}

class _InboxListstate extends State<InboxList> {
  bool filterUnread = false;
  bool bottomMenuFolderIsActive = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    // get inbox based on inboxId
    final inboxStateNotifier =
        ChangeNotifierProvider<InboxController>((ref) => InboxController());

    return Consumer(
      builder: (
        BuildContext context,
        T Function<T>(ProviderBase<Object?, T>) watch,
        Widget? child,
      ) {
        final inboxDataList = watch(inboxStateNotifier);
        return inboxDataList.correspondencesModel.inbox == null
            ? FractionallySizedBox(
                heightFactor: orientation == Orientation.portrait ? 0.04 : 0.07,
                widthFactor: 0.05,
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                    inboxDataList.correspondencesModel.inbox!.correspondences!
                                .length ==
                            0
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 4,
                              bottom: MediaQuery.of(context).size.width / 1.7,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.emptyInboxList,
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        : Container(
                            height: orientation == Orientation.portrait
                                ? (MediaQuery.of(context).size.height - 380)
                                : (MediaQuery.of(context).size.height - 300),
                            color: Colors.transparent,
                            child: _buildMailsList(inboxDataList
                                .correspondencesModel.inbox!.correspondences!),
                          ),
                    orientation == Orientation.portrait
                        ? Material(
                            elevation: 5,
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade200,
                              child: portraitMenuInboxes(context),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
      },
    );
  }

  portraitMenuInboxes(BuildContext context) {
    var appLocale = Localizations.localeOf(context).languageCode;
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: DefaultTabController(
        length: 4,
        child: ContainedTabBarView(
          tabs: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: double.infinity,
                ),
                Text(
                  AppLocalizations.of(context)!.allInbox,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: appLocale == "en" ? 0 : 50,
                    right: appLocale == "en" ? 50 : 0,
                  ),
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
                Text(
                  AppLocalizations.of(context)!.forAction,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: appLocale == "en" ? 0 : 50,
                    right: appLocale == "en" ? 50 : 0,
                  ),
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
                Text(
                  AppLocalizations.of(context)!.forSignature,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: appLocale == "en" ? 0 : 75,
                    left: appLocale == "en" ? 35 : 0,
                  ),
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
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: appLocale == "en" ? 0 : 15,
                    left: appLocale == "en" ? 15 : 0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.forInfo,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: appLocale == "en" ? 0 : 45,
                    left: appLocale == "en" ? 45 : 0,
                  ),
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
                Container(
                  width: 9,
                  height: double.infinity,
                ),
                InkWell(
                  //onTap:,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Image(
                      image: AssetImage(
                        returnImageNameBasedOnOppositeDirection(
                            "assets/images/arrow", context, "png"),
                      ),
                      fit: BoxFit.contain,
                      width: 40,
                      height: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ],
          tabBarProperties: TabBarProperties(
            width: 800,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey.shade600,
            alignment: TabBarAlignment.start,
          ),
          views: [
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
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

  ListView _buildMailsList(List<Correspondences> correspondencesModel) {
    return new ListView.builder(
      itemCount: correspondencesModel.length,
      shrinkWrap: true,
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
                            correspondencesModel[index].metadata![2].value ??
                                "",
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
                              AppLocalizations.of(context)!.sender +
                                  ": " +
                                  (correspondencesModel[index].fromUser ?? ""),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    color: Colors.grey[400],
                                    fontSize: 13,
                                  ),
                            ),
                            Text(
                              correspondencesModel[index].tsfDueDate ?? "",
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
                                      InboxController().returnPriorityType(
                                          context,
                                          correspondencesModel[index]
                                              .priorityId!),
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
                                          InboxController().returnPrivacyType(
                                              context,
                                              correspondencesModel[index]
                                                  .privacyId!),
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
                            correspondencesModel[index].isLocked == true
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8.0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              child: Image(
                                                image: AssetImage(
                                                  'assets/images/closed.png',
                                                ),
                                                width: 15,
                                                alignment: Alignment.center,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                      .closed +
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
                                  )
                                : Container(),
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
            flex: 3,
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
                  EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
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
