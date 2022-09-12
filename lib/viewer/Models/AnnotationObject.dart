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

  AnnotationObject(
      this.x, this.y, this.width, this.height, this.type, this.page, this.uuid);
}
