class AddDocumentsToBasketRequest {
  String token;

  List<int> documentIds;

  int basketId;

  String language;

  AddDocumentsToBasketRequest(
      {required this.token,
      required this.documentIds,
      required this.basketId,
      required this.language});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data['documentIds'] = this.documentIds;
    data['basketId'] = this.basketId;
    data['language'] = this.language;
    return data;
  }

  factory AddDocumentsToBasketRequest.fromMap(Map<String, dynamic> map) {
    return AddDocumentsToBasketRequest(
      token: map['token'] as String,
      documentIds: map['documentIds'] as List<int>,
      basketId: map['basketId'] as int,
      language: map['language'] as String,
    );
  }
}
