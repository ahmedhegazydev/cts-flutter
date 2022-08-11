class AddEditBasketFlagModel {
  bool? AdminIsDeleted;
  String? Color;
  int? ID;
  bool? isDeleted;
  String? Name;
  String? NameAr;
  int? OrderBy;
  int? UserGctId;
  bool? CanBeReOrder;

  AddEditBasketFlagModel(
      {this.AdminIsDeleted,
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

  factory AddEditBasketFlagModel.fromMap(Map<String, dynamic> map) {
    return AddEditBasketFlagModel(
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
