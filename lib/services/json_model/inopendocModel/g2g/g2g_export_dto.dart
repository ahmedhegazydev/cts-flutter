class G2GExportDto {
  String? token;
  int? documentId;
  List<G2GRecipient>? recipients;
  List<int>? attachments;
  String? notes;
  String? language;

  G2GExportDto(
      {this.token,
      this.documentId,
      this.recipients,
      this.attachments,
      this.notes,
      this.language});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['token'] = this.token;
    data['documentId'] = this.documentId;
    data['recipients'] =  this.recipients?.map((e) => e.toMap()).toList() ;
    data['attachments'] = this.attachments;
    data['notes'] = this.notes;
    data['language'] = this.language;
    return data;
  }


  factory G2GExportDto.fromMap(Map<String, dynamic> map) {
    return G2GExportDto(
      token: map['token'] as String,
      documentId: map['documentId'] as int,
      recipients: map['recipients'] as List<G2GRecipient>?,
      attachments: map['attachments'] as  List<int>?,
      notes: map['notes'] as String,
      language: map['language'] as String,
    );
  }

}

// class G2GExportDto
// {
//   public string token{get;set;}
// public int documentId{get;set;}
// public List<G2GRecipient> recipients{get;set;}
// public List<number> attachments{get;set;}
// public string notes { get; set; }
// public string language { get; set; }
// }
class G2GRecipient {
  int? childId;

  int? parentId;

  bool? isCC;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    data['childId'] = this.childId;
    data['parentId'] = this.parentId;
    data['isCC'] = this.isCC;
    return data;
  }

  G2GRecipient({this.childId, this.parentId, this.isCC});
}
