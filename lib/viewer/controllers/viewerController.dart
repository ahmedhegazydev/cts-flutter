import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../static/AnnotationTypes.dart';
import '../Models/AnnotationObject.dart';
import '../MoveableStackItem.dart';

class ViewerController extends GetxController {
  static ViewerController get to => Get.find<ViewerController>();

  RxBool viewerIsEditable = false.obs;
  var selectedActionIndex = 0.obs;

  RxDouble screenWidth = 0.0.obs;
  RxDouble screenHeight = 0.0.obs;

  setScreenWidthAndHeight(double screenWidthNew, double screenHeightNew) {
    screenWidth.value = screenWidthNew;
    screenWidth.refresh();
    screenHeight.value = screenHeightNew;
    //  update();
  }

  bool checkIfAddingAnnotation() {
    if (annotationToAdd != AnnotationBaseTypes.none) return true;
    return false;
  }

  AnnotationBaseTypes getAnnotationToAdd() {
    return annotationToAdd;
  }

  RxList<Widget> movableItems = <Widget>[].obs;
  List<RxList<MoveableStackItem>> annotations = [];

  RxList<AnnotationObject> allAnnotations = <AnnotationObject>[].obs;

  setupLists(int pageCount) {
    annotations = [];
    for (int i = 0; i < pageCount; i++) {
      annotations.add(<MoveableStackItem>[].obs);
    }
  }

  setEditable(bool canEdit) {
    viewerIsEditable.value = canEdit;
  }

  addItem(item) {
    movableItems.add(item);
    //update();
  }

  AnnotationBaseTypes annotationToAdd = AnnotationBaseTypes.none;

  prepareToAddAnnotationOnTap(AnnotationBaseTypes type) {
    annotationToAdd = type;
  }

  creatAndAddAnnotationOnDraw(double width, double height, double originX,
      double originY, String type, int page, Uint8List img) {
    var uuid = const Uuid();
    var v1 = uuid.v1();
    var x = originX;
    var y = originY;
    var annotation = AnnotationObject(x, y, 100, 40, "ann", page, v1);
    // ViewerController.to.annotations[page].add(MoveableStackItem(100, 50, x, y));
    allAnnotations.add(annotation);
    var annotationWidget = MoveableStackItem.withImage(
        width, height, x, y, v1, img, AnnotationBaseTypes.handWrite);
    annotations[page].add(annotationWidget);
  }

  creatAndAddAnnotationOnTap(
      double width, double height, double originX, double originY, int page) {
    var uuid = const Uuid();
    var v1 = uuid.v1();
    var x = originX - width / 2;
    var y = originY - height / 2;
    var annotation = AnnotationObject(x, y, 100, 40, "ann", page, v1);
    // ViewerController.to.annotations[page].add(MoveableStackItem(100, 50, x, y));
    allAnnotations.add(annotation);
    var annotationWidget =
        MoveableStackItem(width, height, x, y, v1, annotationToAdd);
    annotations[page].add(annotationWidget);
    annotationToAdd = AnnotationBaseTypes.none;
  }
}
