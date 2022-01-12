import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cts/caching/app_cache.dart';
import 'package:cts/constants/globals.dart';
import 'package:cts/data/models/CorrespondencesModel.dart';
import 'package:cts/services/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';


class InboxController extends ChangeNotifier {
  Http http = new Http();
  CorrespondencesModel correspondencesModel = new CorrespondencesModel();

  InboxController() {
    getInboxList(Globals.inboxIdForCorrespondencesList);
  }

  Future getInboxList(int inboxId) async {
    var defaultLocale = ui.window.locale.languageCode;
    String token = await AppCache.getSavedUserToken();
    try {
      var response = await http.getRequest(Globals.url +
          'GetCorrespondences?Token=$token&inboxId=$inboxId&index=0&pageSize=20&language=${defaultLocale == "en" ? "en" : "ar"}&showThumbnails=false');
      var data = jsonDecode(response.body);
      correspondencesModel = CorrespondencesModel.fromJson(data);
      notifyListeners();
      return correspondencesModel;
    } catch (error) {
      Exception(error);
    }
  }

  String returnPrivacyType(BuildContext context, String privacyNumber) {
    // secret
    switch (privacyNumber) {
      case "1":
        return "normal".tr;//AppLocalizations.of(context)!.normal;
      case "2":
        return "confidential".tr;//AppLocalizations.of(context)!.confidential;
      case "3":
        return "highConfidential".tr;//AppLocalizations.of(context)!.highConfidential;
      default:
        return "No privacy";
    }
  }

  String returnPriorityType(BuildContext context, String priorityNumber) {
    // urgent
    switch (priorityNumber) {
      case "1":
        return "low".tr;//AppLocalizations.of(context)!.low;
      case "2":
        return "medium".tr;// AppLocalizations.of(context)!.medium;
      case "3":
        return "urgent".tr;//AppLocalizations.of(context)!.urgent;
      case "4":
        return "topUrgent".tr;//AppLocalizations.of(context)!.topUrgent;
      default:
        return "empty priority";
    }
  }
}
