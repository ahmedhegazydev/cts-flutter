import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cts/caching/app_cache.dart';
import 'package:cts/constants/globals.dart';
import 'package:cts/data/models/CorrespondencesModel.dart';
import 'package:cts/services/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return AppLocalizations.of(context)!.normal;
      case "2":
        return AppLocalizations.of(context)!.confidential;
      case "3":
        return AppLocalizations.of(context)!.highConfidential;
      default:
        return "No privay";
    }
  }

  String returnPiriorityType(BuildContext context, String piriorityNumber) {
    // urgent
    switch (piriorityNumber) {
      case "1":
        return AppLocalizations.of(context)!.low;
      case "2":
        return AppLocalizations.of(context)!.medium;
      case "3":
        return AppLocalizations.of(context)!.urgent;
      case "4":
        return AppLocalizations.of(context)!.topUrgent;
      default:
        return "empty priority";
    }
  }
}
