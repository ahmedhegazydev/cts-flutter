


import 'package:get/get.dart';

import '../controllers/document_controller.dart';
import '../controllers/inbox_controller.dart';
import '../controllers/landing_page_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/search_page_result_controller.dart';
import '../controllers/web_view_controller.dart';
import '../utility/storage.dart';

class AllBindings extends Bindings{
  @override
  void dependencies()async {

    Get. lazyPut(() => SecureStorage()  );
    Get.put( LoginController()  );
    Get.put( InboxController()  );
    Get.lazyPut(()=>  LandingPageController()  );
    Get.lazyPut(()=>  SearchController()  );
    Get.put(  DocumentController()  ,permanent: true );

    Get.lazyPut(()=>  WebViewPageController()  );
    Get.lazyPut(()=>  SearchPageResultController()  );
    // Get.putAsync<SecureStorage>(()async => await SecureStorage());

  }

}