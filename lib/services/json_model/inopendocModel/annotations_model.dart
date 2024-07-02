
class Annotation {
String? id;
String? page;
String? x;
String? y;
String? type;
String? width;
String? height;
String? imageByte;
String? imageName;
String? text;
bool? readonly;
String? userId;
bool? hidden;
int? parentHeight;
int? parentWidth;

Annotation({this.id, this.page, this.x, this.y, this.type, this.width, this.height, this.imageByte, this.imageName, this.text, this.readonly, this.userId, this.hidden, this.parentHeight, this.parentWidth});

Annotation.fromJson(Map<String, dynamic> json) {
id = json['Id'];
page = json['Page'];
x = json['X'];
y = json['Y'];
type = json['Type'];
width = json['Width'];
height = json['Height'];
imageByte = json['ImageByte'];
imageName = json['ImageName'];
text = json['Text'];
readonly = json['Readonly'];
userId = json['UserId'];
hidden = json['Hidden'];
parentHeight = json['ParentHeight'];
parentWidth = json['ParentWidth'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['Id'] = this.id;
data['Page'] = this.page;
data['X'] = this.x;
data['Y'] = this.y;
data['Type'] = this.type;
data['Width'] = this.width;
data['Height'] = this.height;
data['ImageByte'] = this.imageByte;
data['ImageName'] = this.imageName;
data['Text'] = this.text;
data['Readonly'] = this.readonly;
data['UserId'] = this.userId;
data['Hidden'] = this.hidden;
data['ParentHeight'] = this.parentHeight;
data['ParentWidth'] = this.parentWidth;
return data;
}
}
