
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_view_controller.dart';

class WebViewPage extends GetWidget<WebViewPageController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebView(initialUrl:controller.url!,javascriptMode: JavascriptMode.unrestricted, ),);
  }
}
