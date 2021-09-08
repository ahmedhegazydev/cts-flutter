import 'package:flutter/material.dart';
import 'package:test_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:test_app/presentation/widgets/all_inbox_list.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key? key}) : super(key: key);

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<InboxPage> {
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
      color: Colors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          //side bar
          Container(
            width: 260,
            height: double.infinity,
            color: Colors.grey.shade300,
            child: _buildSideMenu(context),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
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
                  //inbox menu (filters with inbox type or with purpose -- depends on the configuration)
                  //and correspondences table view container
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: _buildTopInboxMenu(context),
                        ),
                        //line separator
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          height: 1,
                        )
                      ],
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

  _buildSideMenu(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 10,
            height: double.infinity,
            color: Colors.grey.shade400,
          ),
          Expanded(
            child: Column(
              children: [
                //hello container
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  width: double.infinity,
                  height: 120,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.hello,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "ربيع محمد المانع",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: createMaterialColor(
                              Color.fromRGBO(77, 77, 77, 1),
                            ),
                            fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                //empty space
                Container(
                  width: double.infinity,
                  height: 70,
                  color: Colors.transparent,
                ),
                //side menu filter (filters with inbox type or with purpose -- depends on the configuration)
                Expanded(
                  child: _buildSideMenuFilters(context),
                ),
                //department container
                Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //line separator
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      //space
                      Container(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                            image: AssetImage(
                              returnImageNameBasedOnOppositeDirection(
                                "lib/assets/arrow",
                                context,
                                "png",
                              ),
                            ),
                            fit: BoxFit.contain,
                            width: 50,
                          ),
                          Align(
                            alignment: isDirectionRTL(context)
                                ? FractionalOffset.centerRight
                                : FractionalOffset.centerLeft,
                            child: Text(
                              "إدارة الخدمات المشتركة",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: createMaterialColor(
                                          Color.fromRGBO(77, 77, 77, 1)),
                                      fontSize: 18),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
                'lib/assets/menu.png',
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

  _buildTopInboxMenu(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: DefaultTabController(
        length: 4,
        child: ContainedTabBarView(
          tabs: [
            Text(
              AppLocalizations.of(context)!.all,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.grey,
                    fontSize: 21,
                  ),
            ),
            Text(
              AppLocalizations.of(context)!.incoming,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ),
            Text(
              AppLocalizations.of(context)!.outgoing,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ),
            Text(
              AppLocalizations.of(context)!.internal,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.grey, fontSize: 21),
            ),
          ],
          tabBarProperties: TabBarProperties(
            width: 800,
            height: 70.0,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 5.0,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black87,
            alignment: TabBarAlignment.start,
          ),
          views: [
            AllInboxList(),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    height: 0.5,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    height: 0.5,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    height: 0.5,
                  ),
                ],
              ),
            )
          ],
          // onChange: (index) => print(index),
        ),
      ),
    );
  }

  _buildSideMenuFilters(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          _buildSideMenuTitleLabel(context, AppLocalizations.of(context)!.mail),
          //line separator
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            height: 1,
          ),
          _buildSideMenuInboxes(context),
          //space
          Container(
            width: double.infinity,
            height: 20,
          ),
          _buildSideMenuTitleLabel(
            context,
            AppLocalizations.of(context)!.folders,
          ),
          //line separator
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            height: 1,
          ),
          _buildSideMenuFolders(context, AppLocalizations.of(context)!.flagged,
              "lib/assets/flagged.png", true, 05),
          _buildSideMenuFolders(
              context,
              AppLocalizations.of(context)!.notifications,
              "lib/assets/notification.png",
              true,
              19)
        ],
      ),
    );
  }

  _buildSideMenuTitleLabel(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      color: Colors.transparent,
      width: double.infinity,
      height: calculateHeight(50, context),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.grey.shade500, fontSize: 15),
        textAlign: TextAlign.start,
      ),
    );
  }

  _buildSideMenuInboxes(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 0),
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          GestureDetector(
            // onTap:,
            child: Container(
              width: double.infinity,
              height: calculateHeight(80, context),
              child: Align(
                alignment: isDirectionRTL(context)
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.allInbox,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: createMaterialColor(
                          Color.fromRGBO(100, 100, 100, 1),
                        ),
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerRight
                  : FractionalOffset.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.forAction,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: createMaterialColor(
                      Color.fromRGBO(100, 100, 100, 1),
                    ),
                    fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: calculateHeight(80, context),
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerRight
                  : FractionalOffset.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.forSignature,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: createMaterialColor(
                        Color.fromRGBO(100, 100, 100, 1),
                      ),
                      fontSize: 20,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            child: Align(
              alignment: isDirectionRTL(context)
                  ? FractionalOffset.centerRight
                  : FractionalOffset.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.forInfo,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: createMaterialColor(
                        Color.fromRGBO(100, 100, 100, 1),
                      ),
                      fontSize: 20,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildSideMenuFolders(BuildContext context, String title, String iconTitle,
      bool showCount, int count) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
      width: double.infinity,
      height: calculateHeight(80, context),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.transparent,
            child: Image(
              image: AssetImage(
                iconTitle,
              ),
              fit: BoxFit.contain,
              width: 30,
              height: double.infinity,
            ),
          ),
          Container(
            width: 15,
            height: double.infinity,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.grey, fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
