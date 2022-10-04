import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_page_result_controller.dart';
import '../viewer/controllers/viewerController.dart';
import '../widgets/custom_listview.dart';

class SearchPageResult extends GetWidget<SearchPageResultController> {
  const SearchPageResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomListView(
              //allCorrespondences: controller.correspondences,
              customActions: controller.customActions,
              functionComplet: () {},
              functionReply: () {},
              functionSummary: () {},
              functionTrunsfer: () {},
              function: controller.onRefresh(),
              correspondences: controller.correspondences,
              haveMoreData: false,
              onClickItem: () {
                ///
                ///
                Get.toNamed("/DocumentPage");
              },
              scrollController: controller.scrollController),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        "appTitle".tr,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        SizedBox(
          width: 100,
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'back',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
