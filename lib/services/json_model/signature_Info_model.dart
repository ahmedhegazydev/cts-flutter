import 'package:cts/services/abstract_json_resource.dart';

class SignatureInfoModel extends AbstractJsonResource{
  String? Token;

  String? SignatureId;

  String? signature;

  SignatureInfoModel(
      {  this.Token,
        this.SignatureId,
        this.signature});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['Token'] = this.Token;
    data['SignatureId'] = this.SignatureId;
    data['signature'] = this.signature;
    return data;
  }

  factory SignatureInfoModel.fromMap(Map<String, dynamic> map) {
    return SignatureInfoModel(
      Token: map['Token'] ,
      SignatureId: map['SignatureId'] ,
      signature: map['signature'] ,
    );
  }
}
