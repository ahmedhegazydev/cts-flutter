import '../../models/CorrespondencesModel.dart';
import '../abstract_json_resource.dart';

class GetCorrespondencesAllModel extends AbstractJsonResource{
  String? errorMessage;
  int? status;
  Inbox? inbox;
  // List<Priorities>? priorities;
  // List<Privacies>? privacies;
  // List<Purposes>? purposes;
  //
  GetCorrespondencesAllModel({this.errorMessage, this.status, this.inbox,
    // this.priorities,
    // this.privacies,
    // this.purposes,
  });

  GetCorrespondencesAllModel.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    inbox = json['Inbox'] != null ? new Inbox.fromJson(json['Inbox']) : null;
    // if (json['priorities'] != null) {
    //   priorities = <Priorities>[];
    //   json['Correspondences'].forEach((v) {
    //     priorities!.add(Priorities.fromJson(v));
    //   });
    // }
    // if (json['privacies'] != null) {
    //   privacies = <Privacies>[];
    //   json['privacies'].forEach((v) {
    //     privacies!.add(Privacies.fromJson(v));
    //   });
    // }
    // if (json['purposes'] != null) {
    //   purposes = <Purposes>[];
    //   json['Correspondences'].forEach((v) {
    //     purposes!.add(Purposes.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    if (this.inbox != null) {
      data['Inbox'] = this.inbox!.toJson();
    }
    // if (this.priorities != null) {
    //   data['priorities'] =
    //       this.priorities!.map((v) => v.toJson()).toList();
    // }
    // if (this.privacies != null) {
    //   data['privacies'] =
    //       this.privacies!.map((v) => v.toJson()).toList();
    // }
    // if (this.purposes != null) {
    //   data['purposes'] =
    //       this.purposes!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Inbox {
  List<Correspondences>? correspondences;
  String? id;
  int? total;

  Inbox({this.correspondences, this.id, this.total});

  Inbox.fromJson(Map<String, dynamic> json) {
    if (json['Correspondences'] != null) {
      correspondences = <Correspondences>[];
      json['Correspondences'].forEach((v) {
        correspondences!.add(Correspondences.fromJson(v));
      });
    }
    id = json['Id'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.correspondences != null) {
      data['Correspondences'] =
          this.correspondences!.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Total'] = this.total;
    return data;
  }
}


// class Priorities {
//   String? Text;
//   String? TextAr;
//   int? Value;
//
//   Priorities({
//     this.Text,
//     this.TextAr,
//     this.Value,
//   });
//
//   Priorities.fromJson(Map<String, dynamic> json) {
//     Text = json['Text'];
//     TextAr = json['TextAr'];
//     Value = json['Value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Text'] = this.Text;
//     data['TextAr'] = this.TextAr;
//     data['Value'] = this.Value;
//     return data;
//   }
// }
//
// class Privacies {
//   String? Text;
//   String? TextAr;
//   int? Value;
//
//   Privacies({
//     this.Text,
//     this.TextAr,
//     this.Value,
//   });
//
//   Privacies.fromJson(Map<String, dynamic> json) {
//     Text = json['Text'];
//     TextAr = json['TextAr'];
//     Value = json['Value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Text'] = this.Text;
//     data['TextAr'] = this.TextAr;
//     data['Value'] = this.Value;
//     return data;
//   }
// }
//
// class Purposes {
//   String? Text;
//   String? TextAr;
//   int? Value;
//
//   Purposes({
//     this.Text,
//     this.TextAr,
//     this.Value,
//   });
//
//   Purposes.fromJson(Map<String, dynamic> json) {
//     Text = json['Text'];
//     TextAr = json['TextAr'];
//     Value = json['Value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Text'] = this.Text;
//     data['TextAr'] = this.TextAr;
//     data['Value'] = this.Value;
//     return data;
//   }
// }