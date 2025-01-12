import 'package:cts/utility/storage.dart';

class SettingsApp {
  static SecureStorage secureStorage = new SecureStorage();

  // static const String baseUrl = 'http://139.99.149.12:9091/EverSuite.CTS.Mobile/CMS.svc';
  static const String baseUrl =
      'http://ecm-mob.mofa.gov.qa:9091/Eversuite.CTS.Mobile2/CMS.svc';

  // SettingsApp() {}

  static const String loginUrl = baseUrl + "/Login?";
  static const String FindRecipientUrl = baseUrl + "/FindRecipient?";

  static const String GetCorrespondencesUrl =
      baseUrl + "/GetCorrespondencesWithTreeNodeId?";
  static const String CanOpenDocumentUrl = baseUrl + "/CanOpenDocument?";
  static const String ReplyWithVoiceNoteUrl =
      baseUrl + "/ReplyWithVoiceNote"; //

  static const String MultipleTransfersUrl = baseUrl + "/MultipleTransfers?"; //
  static const String SaveDocumentAnnotationsUrl =
      baseUrl + "/SaveDocumentAnnotations?"; //
  static const String GetLookupsUrl = baseUrl +
      "/GetLookups?"; //http://ecm-mob.mofa.gov.qa:9091/Eversuite.CTS.Mobile2/CMS.svc/GetLookups?Token=vDVPA43sENTpfmLujnJO&language=ar
  static const String SearchCorrespondencesUrl = baseUrl +
      "/SearchCorrespondences"; //http://ecm-mob.mofa.gov.qa:9091/Eversuite.CTS.Mobile2/CMS.svc/SearchCorrespondences
  static const String GetCorrespondencesAllUrl = baseUrl +
      "/GetCorrespondencesAll?"; // /GetCorrespondencesAll?Token=vDVPA43sENTpfmLujnJO&inboxId=5&pageNumber=0&pageSize=100&language=ar&showThumbnails=false
  static const String GetSummariesUrl = baseUrl + "/GetSummaries"; //
  static const String ExecuteCustomActionsUrl =
      baseUrl + "/ExecuteCustomActions?"; //
  static const String GetDocumentTransfersUrl =
      baseUrl + "/GetDocumentTransfers?"; //
  static const String GetDocumentLogsUrl = baseUrl + "/GetDocumentLogs?"; //
  static const String GetDocumentLinksUrl = baseUrl + "/GetDocumentLinks?"; //
  static const String GetDocumentReceiversUrl =
      baseUrl + "/GetDocumentReceivers?"; //
  static const String GetFetchBasketListUrl = baseUrl + "/FetchBasketList?"; //
  static const String PostAddEditBasketFlagUrl =
      baseUrl + "/AddEditBasketFlag"; //
  static const String PostReorderBasketsUrl = baseUrl + "/ReOrderBasket"; //
  static const String PostAddDocumentsToBasketUrl =
      baseUrl + "/AddDocumentsToBasket"; //
  static const String PostRemoveItemsFromBasketUrl =
      baseUrl + "/RemoveItemsFromBasket"; //
  static const String PostRemoveBasketUrl = baseUrl + "/RemoveBasket"; //
  static const String PostPrepareOfficeFile = baseUrl + "/PrepareOfficeFile";
  static const String PostRefreshOfficeFile = baseUrl + "/RefreshOfficeFile";
  static const String GetBasketInboxUrl = baseUrl + "/GetBasketInbox?";
  static const String GetIsAlreadyExportedAsPaperworkUrl = baseUrl +
      "/IsAlreadyExportedAsPaperwork?"; //?Token={Token}&exportAction={exportAction}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}&&exportAction=

  static const String GetCanExportAsPaperworkUrl = baseUrl +
      "/CanExportAsPaperwork?"; //?Token={Token}&exportAction={exportAction}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}
  static const String GetIsAlreadyExportedAsTransferUrl = baseUrl +
      "/IsAlreadyExportedAsTransfer?"; //?Token={Token}&exportAction={exportAction}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}

  static const String GetCheckForEmptyStructureRecipientsUrl = baseUrl +
      "/CheckForEmptyStructureRecipients?"; //?Token={Token}&exportAction={exportAction}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}

  static const String GetAutoSendToRecepientsAndCCUrl = baseUrl +
      "/AutoSendToRecepientsAndCC?"; //? Token={Token}&exportAction={exportAction}&correspondenceId={correspondenceId}&transferId={transferId}&language={language}

  static const String GetGetUserRoutingUrl =
      baseUrl + "/GetUserRouting?"; //Token={Token}&GctId={GctId}")
  static const String GetAttachmentItemUrl =
      baseUrl + "/GetAttachmentItem?"; //Token={Token}&GctId={GctId}")

  static const String GetAttachmentsUrl = baseUrl + "/GetAttachments?";

  //////// #region G2G

  static const String GetG2GInfoForExportUrl = baseUrl +
      "/G2GInfoForExport?"; //token={token}&documentId={documentId}&language={language}"
  static const String PostExportUsingG2GUrl = baseUrl + "/ExportUsingG2G";
  static const String PostCanReceiveG2GDocumentUrl =
      baseUrl + "/CanReceiveG2GDocument";
  static const String PostReceiveDocumentUsingG2GUrl =
      baseUrl + "/ReceiveDocumentUsingG2G";
  static const String PostReturnDocumentUsingG2GUrl =
      baseUrl + "/ReturnDocumentUsingG2G";

//Before can open document.

  static const String PostUpdateSignatureUrl = baseUrl + "/UpdateSignature";
  static const String PostUploadAttachmentUrl = baseUrl + "/UploadAttachment";

  static const String CheckAttendanceUrl = baseUrl + "/CheckAttendance";

  //mofa-favorite-recipients-api
  static const String ListFavoriteRecipientsUrl =
      baseUrl + "/ListFavoriteRecipients?"; //
  static const String RemoveFavoriteRecipientsUrl =
      baseUrl + "/RemoveFavoriteRecipients?"; //
  static const String AddFavoriteRecipientsUrl =
      baseUrl + "/AddFavoriteRecipients?"; //

  //==========================================

  static const String GetMyRoutingSettingsUrl =
      baseUrl + "/GetMyRoutingSettings?"; //Token={Token}&GctId={GctId}")

  static const String SaveMyRoutingSettingsUrl =
      baseUrl + "/SaveMyRoutingSettings"; //Token={Token}&GctId={GctId}")

  static const String RemoveMyRoutingSettingsUrl =
      baseUrl + "/RemoveMyRoutingSettings"; //Token={Token}&GctId={GctId}")

  static const String DashboardHomeUrl =
      baseUrl + "/DashboardHome?"; //Token={Token}&GctId={GctId}")

}
