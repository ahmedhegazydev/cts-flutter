import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_page_result_controller.dart';
import '../widgets/custom_listview.dart';

class SearchPageResult extends GetWidget<SearchPageResultController> {
  const SearchPageResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:


        CustomListView(
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
    );
  }
}
