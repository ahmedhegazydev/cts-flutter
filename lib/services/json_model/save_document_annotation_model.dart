import 'package:cts/services/abstract_json_resource.dart';

class SaveDocumentAnnotationModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  String? Token;
  String? UserId;
  String? CorrespondenceId;
  String? TransferId;
  String? AttachmentId;
  String? IsOriginalMail;
  String? DelegateGctId;
  String? DocumentAnnotationsString;

  List<DocumentAnnotations>? documentAnnotationsString;

  SaveDocumentAnnotationModel(
      {this.errorMessage,
        this.status,
        this.Token,
        this.UserId,
        this.CorrespondenceId,
        this.TransferId,
        this.AttachmentId,
        this.IsOriginalMail,
        this.DelegateGctId,
        this.DocumentAnnotationsString,
      });

  SaveDocumentAnnotationModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['DocumentAnnotationsString'] != null) {
      documentAnnotationsString = <DocumentAnnotations>[];
      json['DocumentAnnotationsString'].forEach((v) {
        documentAnnotationsString!.add(new DocumentAnnotations.fromJson(v));
      });
    }
    // if (json['DocumentTransfers'] != null) {
    //   documentTransfers = <DocumentReceivers>[];
    //   json['DocumentTransfers'].forEach((v) {
    //     documentTransfers!.add(new DocumentReceivers.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.documentAnnotationsString != null) {
      data['DocumentReceivers'] =
          this.documentAnnotationsString!.map((v) => v.toJson()).toList();
    }
    // if (this.documentTransfers != null) {
    //   data['DocumentTransfers'] =
    //       this.documentTransfers!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  Map<String, dynamic> toMap() {
    Map <String,dynamic>data={};
    data[ 'Token']= this.Token;
    data['UserId'] = this.UserId;
    // data['Language'] = this.Language;
    data['CorrespondenceId'] = this.CorrespondenceId;
    data['TransferId'] = this.TransferId;
    data['AttachmentId'] = this.AttachmentId;
    data['IsOriginalMail'] = this.IsOriginalMail;
    data['DocumentAnnotationsString'] = this.DocumentAnnotationsString;
    data['DelegateGctId'] = this.DelegateGctId;
    return data;
  }
}

class DocumentAnnotations {
  int? Page;
  double? X;
  double? Y;
  double? Height;
  double? Width;
  double? ParentHeight;
  double? ParentWidth;
  String? Type;
  String? ForceViewers;
  String? ImageByte;
  String? IsExclusive;
  int? FontSize;
  String? ImageName;
  String? Text;
  String? Viewers;

  DocumentAnnotations(
      {
        this.Page,
        this.X,
        this.Y,
        this.Height,
        this.Width,
        this.ParentHeight,
        this.ParentWidth,
        this.Type,
        this.ForceViewers,
        this.ImageByte,
        this.IsExclusive,
        this.FontSize,
        this.ImageName,
        this.Text,
        this.Viewers,
      });

  DocumentAnnotations.fromJson(Map<String, dynamic> json) {
    Page = json['Page'];
    X = json['X'];
    Y = json['Y'];
    Height = json['Height'];
    Width = json['Width'];
    ParentHeight = json['ParentHeight'];
    ParentWidth = json['ParentWidth'];
    Type = json['Type'];
    ForceViewers = json['ForceViewers'];
    ImageByte = json['ImageByte'];
    IsExclusive = json['IsExclusive'];
    FontSize = json['FontSize'];
    ImageName = json['ImageName'];
    Text = json['Text'];
    Viewers = json['Viewers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    Page = data['Page'];
    X = data['X'];
    Y = data['Y'];
    Height = data['Height'];
    Width = data['Width'];
    ParentHeight = data['ParentHeight'];
    ParentWidth = data['ParentWidth'];
    Type = data['Type'];
    ForceViewers = data['ForceViewers'];
    ImageByte = data['ImageByte'];
    IsExclusive = data['IsExclusive'];
    FontSize = data['FontSize'];
    ImageName = data['ImageName'];
    Text = data['Text'];
    Viewers = data['Viewers'];
    return data;
  }
}


