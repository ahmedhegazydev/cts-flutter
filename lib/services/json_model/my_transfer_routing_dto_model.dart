  import 'package:cts/services/abstract_json_resource.dart';

class MyTransferRoutingDtoSend extends AbstractJsonResource
{
    int? CrtId ;
  int? GctId ;
  String? CrtFromDate ;
  String? CrtToDate ;
  String? CrtComments ;
  String? Name ;
  String? NameAr ;
  int? CrtToGctid ;
  bool? DoRouting ;

    MyTransferRoutingDtoSend(
      {this.CrtId,
      this.GctId,
      this.CrtFromDate,
      this.CrtToDate,
      this.CrtComments,
      this.Name,
      this.NameAr,
      this.CrtToGctid,
      this.DoRouting});

    Map<String, dynamic> toMap() {
    Map<String,dynamic>data={};
    data['CrtId'] = this.CrtId;
    data['GctId'] = this.GctId;
    data['CrtFromDate'] = this.CrtFromDate;
    data['CrtToDate'] = this.CrtToDate;
    data['CrtComments'] = this.CrtComments;
    data[ 'Name']= this.Name;
    data[ 'NameAr']= this.NameAr;
    data['CrtToGctid'] =this.CrtToGctid;
    data['DoRouting'] = this.DoRouting;


      return data;

  }

  factory MyTransferRoutingDtoSend.fromMap(Map<String, dynamic> map) {
    return MyTransferRoutingDtoSend(
      CrtId: map['crtId'] ,
      GctId: map['gctId']  ,
      CrtFromDate: map['crtFromDate']  ,
      CrtToDate: map['crtToDate']  ,
      CrtComments: map['crtComments'] ,
      Name: map['name']  ,
      NameAr: map['nameAr'] ,
      CrtToGctid: map['crtToGctid']  ,
      DoRouting: map['doRouting']  ,
    );
  }
}

  class MyTransferRoutingRequestDto  extends AbstractJsonResource
{
    String Token;
  MyTransferRoutingDtoSend? routing ;

    MyTransferRoutingRequestDto({required this.Token, this.routing});

    Map<String, dynamic> toMap() {
   Map<String,dynamic>data={};
    data['Token']  = this.Token;
      data['Routing'] = this.routing?.toMap();
  return data;
  }

  factory MyTransferRoutingRequestDto.fromMap(Map<String, dynamic> map) {
    return MyTransferRoutingRequestDto(
      Token: map['token'] as String,
      routing: map['routing'] as MyTransferRoutingDtoSend,
    );
  }
}
