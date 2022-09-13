import 'package:cts/services/abstract_json_resource.dart';

class SaveDocumentAnnotationModel extends AbstractJsonResource {
  String? errorMessage;
  int? status;
  String? Token;
  String? UserId;
  String? CorrespondenceId;
  String? TransferId;
  String? AttachmentId;
  bool? IsOriginalMail;
  String? DelegateGctId;

  List<DocumentAnnotations>? documentAnnotationsString;

  var DocumentUrl;

  var Language;

  SaveDocumentAnnotationModel(
      {this.errorMessage,
      this.status,
      required this.DocumentUrl,
      required this.Token,
      required this.Language,
      required this.UserId,
      required this.CorrespondenceId,
      required this.TransferId,
      required this.AttachmentId,
      required this.IsOriginalMail,
      required this.DelegateGctId,
      required this.documentAnnotationsString});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.Token;
    data['DocumentUrl'] = this.DocumentUrl;
    data['errorMessage'] = this.errorMessage;
    data['status'] = this.status;
    data['Language'] = this.Language;
    data['UserId'] = this.UserId;
    data['CorrespondenceId'] = this.CorrespondenceId;
    data['TransferId'] = this.TransferId;
    data['AttachmentId'] = this.AttachmentId;
    data['IsOriginalMail'] = this.IsOriginalMail;
    data['DelegateGctId'] = this.DelegateGctId;
    if (this.documentAnnotationsString != null) {
      data['DocumentAnnotationsString'] =
          this.documentAnnotationsString!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  factory SaveDocumentAnnotationModel.fromMap(Map<String, dynamic> map) {
    return SaveDocumentAnnotationModel(
      Language: map['Language'] as String,
      DocumentUrl: map['DocumentUrl'] as String,
      errorMessage: map['errorMessage'] as String,
      status: map['status'] as int,
      Token: map['Token'] as String,
      UserId: map['UserId'] as String,
      CorrespondenceId: map['CorrespondenceId'] as String,
      TransferId: map['TransferId'] as String,
      AttachmentId: map['AttachmentId'] as String,
      IsOriginalMail: map['IsOriginalMail'] as bool,
      DelegateGctId: map['DelegateGctId'] as String,
      documentAnnotationsString:
          map['documentAnnotationsString'] as List<DocumentAnnotations>,
    );
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

  DocumentAnnotations({
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
    final Map<String, dynamic> data = {};
    data['Page'] = Page;
    data['X'] = X;
    data['Y'] = Y;
    data['Height'] = Height;
    data['Width'] = Width;
    data['ParentHeight'] = ParentHeight;
    data['ParentWidth'] = ParentWidth;
    data['Type'] = Type;
    data['ForceViewers'] = ForceViewers;
    data['ImageByte'] = ImageByte;
    data['IsExclusive'] = IsExclusive;
    data['FontSize'] = FontSize;
    data['ImageName'] = ImageName;
    data['Text'] = Text;
    data['Viewers'] = Viewers;
    return data;
  }
}
