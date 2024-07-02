class AddEditBasketFlagModel {
  BasketDto? basketFlag;
  // String? Color = "";
  // int? ID = 0;
  // bool? isDeleted = false;
  // String? Name = "";
  // String? NameAr = "";
  // int? OrderBy = 0;
  // int? UserGctId = 0;
  // bool? CanBeReOrder = false;
  String? token;
  String? language;

  AddEditBasketFlagModel(
      {this.token,
      this.language,
      this.basketFlag,
      // this.Color,
      // this.ID,
      // this.isDeleted,
      // this.Name,
      // this.NameAr,
      // this.OrderBy,
      // this.UserGctId,
      // this.CanBeReOrder
      });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['language'] = this.language;
    data['basketFlag'] = this.basketFlag?.toMap();
    return data;
  }

  factory AddEditBasketFlagModel.fromMap(Map<String, dynamic> map) {
    return AddEditBasketFlagModel(
      token: map['token'] as String,
      language: map['language'] as String,
      basketFlag: map['basketFlag'] as BasketDto,
      // Color: map['Color'] as String,
      // ID: map['ID'] as int,
      // isDeleted: map['isDeleted'] as bool,
      // Name: map['Name'] as String,
      // NameAr: map['NameAr'] as String,
      // OrderBy: map['OrderBy'] as int,
      // UserGctId: map['UserGctId'] as int,
      // CanBeReOrder: map['CanBeReOrder'] as bool,
    );
  }
}

class BasketDto {
  bool? AdminIsDeleted = false;
  String? Color = "";
  int? ID = 0;
  bool? isDeleted = false;
  String? Name = "";
  String? NameAr = "";
  int? OrderBy = 0;
  int? UserGctId = 0;
  bool? CanBeReOrder = false;

  BasketDto(
      {
        this.AdminIsDeleted,
        this.Color,
        this.ID,
        this.isDeleted,
        this.Name,
        this.NameAr,
        this.OrderBy,
        this.UserGctId,
        this.CanBeReOrder});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['token'] = this.token;
    // data['language'] = this.language;
    data['AdminIsDeleted'] = this.AdminIsDeleted;
    data['Color'] = this.Color;
    data['ID'] = this.ID;
    data['isDeleted'] = this.isDeleted;
    data['Name'] = this.Name;
    data['NameAr'] = this.NameAr;
    data['OrderBy'] = this.OrderBy;
    data['UserGctId'] = this.UserGctId;
    data['CanBeReOrder'] = this.CanBeReOrder;
    return data;
  }

  factory BasketDto.fromMap(Map<String, dynamic> map) {
    return BasketDto(
      // token: map['token'] as String,
      // language: map['language'] as String,
      AdminIsDeleted: map['AdminIsDeleted'] as bool,
      Color: map['Color'] as String,
      ID: map['ID'] as int,
      isDeleted: map['isDeleted'] as bool,
      Name: map['Name'] as String,
      NameAr: map['NameAr'] as String,
      OrderBy: map['OrderBy'] as int,
      UserGctId: map['UserGctId'] as int,
      CanBeReOrder: map['CanBeReOrder'] as bool,
    );
  }
}
