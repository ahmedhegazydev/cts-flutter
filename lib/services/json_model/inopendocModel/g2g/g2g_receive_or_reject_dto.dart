import 'package:cts/services/abstract_json_resource.dart';

class G2GReceiveOrRejectDto extends AbstractJsonResource{
  String token;
  int documentId;
  String? notes;
  String language;

  G2GReceiveOrRejectDto(
      {required this.token,
      required this.documentId,
      this.notes,
      required this.language});

  Map<String, dynamic> toMap() {
    Map <String,dynamic>data={};

   data[ 'token']= this.token;
   data['documentId'] = this.documentId;
   data['notes'] = this.notes;
   data['language'] = this.language;
 return data;
  }

  factory G2GReceiveOrRejectDto.fromMap(Map<String, dynamic> map) {
    return G2GReceiveOrRejectDto(
      token: map['token'] as String,
      documentId: map['documentId'] as int,
      notes: map['notes'] as String,
      language: map['language'] as String,
    );
  }
}
