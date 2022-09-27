import 'dart:ui';

class AnnotationObject {
  double x;
  double y;
  int width;
  int height;
  int page;
  String type;
  String uuid;
  Image? image;
  int? parentWidth;
  int? parentHeight;

  String? imagebase64str;
  String? value;

  AnnotationObject(
      this.x, this.y, this.width, this.height, this.type, this.page, this.uuid);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['X'] = this.x;
    data['Y'] = this.y;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Page'] = this.page + 1;
    data['Type'] = this.type;

    data['ParentWidth'] = this.parentWidth;
    data['ParentHeight'] = this.parentHeight;

    data['ImageByte'] = this.imagebase64str;
    data['ImageName'] = "";
    data['Text'] = "";

    //  data['height'] = this.height;
    return data;
  }
}
