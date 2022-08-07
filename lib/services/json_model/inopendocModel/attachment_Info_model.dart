  import 'package:cts/services/abstract_json_resource.dart';

class AttachmentInfoModel extends AbstractJsonResource
  {
    String token ;
    String correspondenceId ;
    String fileName ;
    String fileContent ;
    String language ;

    AttachmentInfoModel({required this.token,required this.correspondenceId,required this.fileName,
     required this.fileContent,required this.language});

    Map<String, dynamic> toMap() {
    Map<String,dynamic>data={};
    data['token']  = this.token;
    data['correspondenceId']  = this.correspondenceId;
    data['fileName']  =this.fileName;
    data['fileContent']  =this.fileContent;
    data['language']  = this.language;
     return data;
    }

    factory AttachmentInfoModel.fromMap(Map<String, dynamic> map) {
      return AttachmentInfoModel(
        token: map['token'] ,
        correspondenceId: map['correspondenceId'] ,
        fileName: map['fileName']  ,
        fileContent: map['fileContent']  ,
        language: map['language']  ,
      );
    }

  }