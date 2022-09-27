import 'package:cts/services/abstract_json_resource.dart';

class SaveDocumentAnnotationModel extends AbstractJsonResource {
  // String? errorMessage;
  // int? status;
  String Token;
  String UserId;
  String CorrespondenceId;
  String TransferId;
  String AttachmentId;
  String IsOriginalMail;
  String DelegateGctId;
  String DocumentAnnotationsString;
  String Language;

  String DocumentPagesString;
  String DocumentUrl;
  List PagesOrderString = [];
  String UnSign;

  SaveDocumentAnnotationModel(
      {required this.Token,
      required this.UserId,
      required this.CorrespondenceId,
      required this.TransferId,
      required this.AttachmentId,
      required this.IsOriginalMail,
      required this.DelegateGctId,
      required this.DocumentAnnotationsString,
      required this.DocumentPagesString,
      required this.DocumentUrl,
      required this.Language,
      required this.UnSign});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['Token'] = this.Token;
    data['UserId'] = this.UserId;
    data['Language'] = this.Language;
    data['CorrespondenceId'] = this.CorrespondenceId;
    data['TransferId'] = this.TransferId;
    data['AttachmentId'] = this.AttachmentId;
    data['IsOriginalMail'] = this.IsOriginalMail;
    data['DocumentAnnotationsString'] = this.DocumentAnnotationsString;
    data['DelegateGctId'] = this.DelegateGctId;

    data['DocumentPagesString'] = this.DocumentPagesString;
    data['DocumentUrl'] = this.DocumentUrl;
    data['UnSign'] = this.UnSign;

    data['PagesOrderString'] = this.PagesOrderString;

    return data;
  }
}
