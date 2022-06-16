class SettingsApp {
  static const String baseUrl = 'http://192.168.1.2:9091/Mobility/CMS.svc/';
  static const String loginUrl =baseUrl;
  static const String FindRecipientUrl =baseUrl+"FindRecipient?typeId=&criteria=*&";//Token=oeXQq9ZIRfxAu8ixipXg&language=en";

  static const String GetCorrespondencesUrl =baseUrl+"GetCorrespondences?";//http://192.168.1.4:9091/Mobility/CMS.svc/GetCorrespondences?Token=oeXQq9ZIRfxAu8ixipXg&inboxId=1&index=0&pageSize=20&language=ar&showThumbnails=false
  static const String CanOpenDocumentUrl =baseUrl+"CanOpenDocument?";//192.168.1.4:9091/Mobility/CMS.svc/CanOpenDocument?Token=vDVPA43sENTpfmLujnJO&correspondenceId=2966766&transferId=5688958&language=ar
  static const String ReplyWithVoiceNoteUrl =baseUrl+"ReplyWithVoiceNote";//

  static const String MultipleTransfersUrl =baseUrl+"MultipleTransfers?";//
  static const String SaveDocumentAnnotationsUrl =baseUrl+"SaveDocumentAnnotations?";//
  static const String GetLookupsUrl =baseUrl+"GetLookups?";//http://192.168.20.237:89/Eversuite.CTS.Mobile/CMS.svc/GetLookups?Token=vDVPA43sENTpfmLujnJO&language=ar
  static const String SearchCorrespondencesUrl =baseUrl+"SearchCorrespondences";//http://192.168.20.237:89/Eversuite.CTS.Mobile/CMS.svc/SearchCorrespondences
  static const String GetCorrespondencesAllUrl =baseUrl+"GetCorrespondencesAll?";// /GetCorrespondencesAll?Token=vDVPA43sENTpfmLujnJO&inboxId=5&pageNumber=0&pageSize=100&language=ar&showThumbnails=false
  static const String GetSummariesUrl =baseUrl+"GetSummaries";//
  static const String ExecuteCustomActionsUrl =baseUrl+"ExecuteCustomActions?";//
  static const String GetDocumentTransfersUrl =baseUrl+"GetDocumentTransfers?";//
  static const String GetDocumentLogsUrl =baseUrl+"GetDocumentLogs?";//
  static const String GetDocumentLinksUrl =baseUrl+"GetDocumentLinks?";//
  static const String GetDocumentReceiversUrl =baseUrl+"GetDocumentReceivers?";//
}
