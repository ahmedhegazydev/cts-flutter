import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/open_pdf_file_controller.dart';
import '../utility/utilitie.dart';

class OpenPDFFile extends GetWidget<OpenPdfFileController> {
  const OpenPDFFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size _size = MediaQuery.of(context).size;
    return Row(
      children: [
        //side bar
        orientation == Orientation.landscape
            ? Container(
                width: _size.width * .2,
                height: _size.height,
                color: Colors.grey.shade300,
                child: _buildSideMenu(context),
              )
            : Container(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.max,
            children: [
              //top bar
              Container(
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
      ],
    );
  }

  _buildTopInboxMenu(BuildContext context) {
    return Container();
  }
}

_buildSideMenuInboxes(BuildContext context) {
  return Column(
    children: [
      _buildSideMenuFolders(
        context,
        "comment".tr,
        "assets/images/comment.png",
      ),
      SizedBox(
        height: calculateHeight(80, context),
        child: Align(
          alignment: isDirectionRTL(context)
              ? FractionalOffset.centerRight
              : FractionalOffset.centerLeft,
          child: Text(
            "signature".tr,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: createMaterialColor(
                    const Color.fromRGBO(100, 100, 100, 1),
                  ),
                  fontSize: 20,
                ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      SizedBox(
        height: 80,
        child: Align(
          alignment: isDirectionRTL(context)
              ? FractionalOffset.centerRight
              : FractionalOffset.centerLeft,
          child: Text(
            "marking".tr,
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
      SizedBox(
        width: 100,
        height: 80,
        child: Align(
          alignment: isDirectionRTL(context)
              ? FractionalOffset.centerRight
              : FractionalOffset.centerLeft,
          child: Text(
            "save".tr,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: createMaterialColor(
                  const Color.fromRGBO(100, 100, 100, 1),
                ),
                fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    ],
  );
}

_buildSideMenuFolders(BuildContext context, String title, String iconTitle) {
  return Column(
    children: [
      SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          iconTitle,
          fit: BoxFit.fill,
          height: 50,
          width: 50,
        ),
      ),
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.grey, fontSize: 20),
        textAlign: TextAlign.start,
      ),
    ],
  );
}

_buildSideMenu(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Expanded(
        child: Column(
          children: [_buildSideMenuInboxes(context)],
        ),
      )
    ],
  );
}

_buildTopBar(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    // crossAxisAlignment: CrossAxisAlignment.stretch,
    // mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
              child: Text(
                "appTitle".tr,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
      InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
            width: 120,
            // height: double.infinity,
            color: Colors.transparent,
            child: Image.asset('assets/images/menu.png')

            // Image(
            //   image: AssetImage(
            //     ,
            //   ),
            //   fit: BoxFit.contain,
            //   width: double.infinity,
            //   height: double.infinity,
            // ),
            ),
      ),
    ],
  );
}
//
//
// _buildSideMenuFilters(BuildContext context) {
//   return Container(
//     width: double.infinity,
//     height: double.infinity,
//     color: Colors.transparent,
//     child: SingleChildScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       child: Column(
//         children: [
//         //  _buildSideMenuTitleLabel(context, "mail".tr),
//           //line separator
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade400,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(4),
//               ),
//             ),
//             height: 1,
//           ),
//          // _buildSideMenuInboxes(context),
//           //space
//           Container(
//             width: double.infinity,
//             height: 20,
//           ),
//           // _buildSideMenuTitleLabel(
//           //   context,
//           //   "folders".tr,
//           // ),
//           //line separator
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade400,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(4),
//               ),
//             ),
//             height: 1,
//           ),
//           // _buildSideMenuFolders(
//           //     context, "flagged".tr, "assets/images/flagged.png", true, 05),
//           // _buildSideMenuFolders(context, "notifications".tr,
//           //     "assets/images/notification.png", true, 19)
//         ],
//       ),
//     ),
//   );
//
//
// }



