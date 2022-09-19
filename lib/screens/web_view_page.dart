import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_view_controller.dart';

class WebViewPage extends GetWidget<WebViewPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: <Widget>[
        // Padding(
        //     padding: EdgeInsets.all(5),
        //     child: InkWell(
        //         onTap: () {
        //           Get.back();
        //         },
        //         child: Icon(
        //           Icons.close,
        //           color: Colors.white,
        //           size: 30,
        //         ))
        // ),
      ]),
      body: controller.isPdf
          ? SfPdfViewer.network(controller.url!)
          : WebView(
              initialUrl: controller.url!,
              javascriptMode: JavascriptMode.unrestricted,
              allowsInlineMediaPlayback: true,
              gestureNavigationEnabled: true,
              zoomEnabled: true,
            ),
    );
  }
}
