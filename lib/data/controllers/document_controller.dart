import 'dart:convert';
import 'package:cts/caching/app_cache.dart';
import 'package:cts/constants/globals.dart';
import 'package:cts/data/models/DocumentModel.dart';
import 'package:cts/services/http.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class DocumentController extends ChangeNotifier {
  Http http = new Http();
  DocumentModel documentModel = new DocumentModel();

  DocumentController() {
    getDocument(Globals.documentCorrespondenceId, Globals.documentTansferId);
  }

  Future getDocument(String correspondenceId, String transferId) async {
    var defaultLocale = ui.window.locale.languageCode;
    String token = await AppCache.getSavedUserToken();
    try {
      var response = await http.getRequest(Globals.url +
          'CanOpenDocument?Token=$token&correspondenceId=$correspondenceId&transferId=$transferId&language=${defaultLocale == "en" ? "en" : "ar"}');
      var data = jsonDecode(response.body);
      documentModel = DocumentModel.fromJson(data);
      notifyListeners();
      return documentModel;
    } catch (error) {
      Exception(error);
    }
  }
}
