import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_view_controller.dart';

class WebViewPage extends GetWidget<WebViewPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       controller.isPdf? SfPdfViewer.network(controller.url!):
      WebView(
        initialUrl: controller.url!,
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,
        zoomEnabled: true,
      ),
    );
  }
}
