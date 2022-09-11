import 'package:cts/services/abstract_json_resource.dart';

class FetchBasketListModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  List<Baskets>? baskets;

  FetchBasketListModel({this.errorMessage, this.status, this.baskets});

  FetchBasketListModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    if (json['baskets'] != null) {
      baskets = <Baskets>[];
      json['baskets'].forEach((v) {
        baskets!.add(new Baskets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.baskets != null) {
      data['baskets'] = this.baskets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Baskets extends AbstractJsonResource implements Comparable{
  bool? adminIsDeleted;
  String? color;
  int? iD;
  String? name;
  String? nameAr;
  int? orderBy;
  int? userGctId;
  bool? isDeleted;
  bool? canBeReOrder;

  Baskets(
      {this.adminIsDeleted,
        this.color,
        this.iD,
        this.name,
        this.nameAr,
        this.orderBy,
        this.userGctId,
        this.isDeleted,
        this.canBeReOrder});


  @override
  int compareTo(otherPerson){
    // if(this.orderBy! > otherPerson.orderBy){
    //   return 1;
    // }
    //
    // if(this.orderBy! < otherPerson.orderBy){
    //   return 0;
    // }
    //
    // if(this.orderBy == otherPerson.orderBy){
    //   return 0;
    // }

    return 0;
  }

  Baskets.fromJson(Map<String, dynamic> json) {
    adminIsDeleted = json['AdminIsDeleted'];
    color = json['Color'];
    iD = json['ID'];
    name = json['Name'];
    nameAr = json['NameAr'];
    orderBy = json['OrderBy'];
    userGctId = json['UserGctId'];
    isDeleted = json['isDeleted'];
    canBeReOrder = json['CanBeReOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminIsDeleted'] = this.adminIsDeleted;
    data['Color'] = this.color;
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['NameAr'] = this.nameAr;
    data['OrderBy'] = this.orderBy;
    data['UserGctId'] = this.userGctId;
    data['isDeleted'] = this.isDeleted;
    data['CanBeReOrder'] = this.canBeReOrder;
    return data;
  }
}
