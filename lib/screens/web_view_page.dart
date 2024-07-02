import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_view_controller.dart';

class WebViewPage extends GetWidget<WebViewPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(
          context,
          controller.title,
        ),
        //AppBar(title: Text(controller.title),
        // iconTheme: IconThemeData(
        //   color: Colors.white, //change your color here
        // ),
        // actions: <Widget>[]),
        body: //controller.isPdf
            //? SfPdfViewer.network(controller.url!)
            // :
            WebView(
          initialUrl: controller.url!,
          javascriptMode: JavascriptMode.unrestricted,
          allowsInlineMediaPlayback: true,
          gestureNavigationEnabled: true,
          zoomEnabled: true,
          onWebResourceError: (error) {
            log(error.description);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      //leadingWidth: 90,
      leading: SizedBox(
        width: 30,
      ),
      toolbarHeight: 100,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: 25),
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
