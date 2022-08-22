class RemoveItemsFromBasketRequest {
  String token;
  List<BasketDocumentDto> basketDocuments;
  int basketId;
  String language;

  RemoveItemsFromBasketRequest(
      {required this.token,
      required this.basketDocuments,
      required this.basketId,
      required this.language});
}

class BasketDocumentDto {
  int DOC_ID;

  int ID;

  DateTime? RegDate;

  int TSF_ID;

  int UserGctId;

  BasketDocumentDto(
      {required this.DOC_ID,
      required this.ID,
      this.RegDate,
      required this.TSF_ID,
      required this.UserGctId});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['DOC_ID'] = this.DOC_ID;
    data['ID'] = this.ID;
    data['RegDate'] = this.RegDate;
    data['TSF_ID'] = this.TSF_ID;
    data['UserGctId'] = this.UserGctId;
    return data;
  }

  factory BasketDocumentDto.fromMap(Map<String, dynamic> map) {
    return BasketDocumentDto(
      DOC_ID: map['DOC_ID'] as int,
      ID: map['ID'] as int,
      RegDate: map['RegDate'] as DateTime,
      TSF_ID: map['TSF_ID'] as int,
      UserGctId: map['UserGctId'] as int,
    );
  }
}
