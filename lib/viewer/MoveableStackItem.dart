import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:uuid/uuid.dart';
import './controllers/viewerController.dart';
import './static/AnnotationTypes.dart';

import 'DottedBorder.dart';

class MoveableStackItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }

  MoveableStackItem(this.initailWidth, this.initailHeight, this.initailx,
      this.initaily, this.uuid, this.type);

  MoveableStackItem.withImage(this.initailWidth, this.initailHeight,
      this.initailx, this.initaily, this.uuid, this.image, this.type);

  MoveableStackItem.withUIImage(this.initailWidth, this.initailHeight,
      this.initailx, this.initaily, this.uuid, this.uiimage, this.type);

  final String uuid;
  final double initailWidth;
  final double initailHeight;
  final double initailx;
  final double initaily;
  final AnnotationBaseTypes type;
  Uint8List? image;
  Image? uiimage;
  void printSampleP() {
    print("Sample text");
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;

  double width = 100;
  double height = 100;

  double minWidth = 40;
  double minHeight = 40;
  double resizeButtonSize = 18;

  bool isEditing = false;

  Color color = Colors.red;

  void printSample() {
    print("Sample text");
  }

  @override
  void initState() {
    color = Colors.transparent;
    width = widget.initailWidth;
    height = widget.initailHeight;
    xPosition = widget.initailx;
    yPosition = widget.initaily;
    super.initState();
  }

  Widget CloseButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          print("closeeeee ");
        },
        child: Container(
          width: 20,
          height: 20,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget dragableNode() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      width: resizeButtonSize,
      height: resizeButtonSize,
      // color: Colors.white,
    );
  }

  Widget dragButtonBR() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width += tapInfo.delta.dx;
            height += tapInfo.delta.dy;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  void validateConstraints() {
    if (height < minHeight) height = minHeight;
    if (width < minWidth) width = minWidth;
  }

  Widget dragButtonTR() {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width += tapInfo.delta.dx;
            // xPosition -= tapInfo.delta.dx;
            height -= tapInfo.delta.dy;
            yPosition += tapInfo.delta.dy;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonTL() {
    return Positioned(
      top: 0,
      left: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width -= tapInfo.delta.dx;
            xPosition += tapInfo.delta.dx;
            height -= tapInfo.delta.dy;
            yPosition += tapInfo.delta.dy;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonBL() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width -= tapInfo.delta.dx;
            xPosition += tapInfo.delta.dx;
            height += tapInfo.delta.dy;
            validateConstraints();
            // yPosition += tapInfo.delta.dy;
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonTC() {
    return Positioned(
      top: 0,
      left: width / 2,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            height -= tapInfo.delta.dy;
            yPosition += tapInfo.delta.dy;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonBC() {
    return Positioned(
      bottom: 0,
      left: width / 2,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            height += tapInfo.delta.dy;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonCR() {
    return Positioned(
      bottom: height / 2,
      right: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width += tapInfo.delta.dx;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  Widget dragButtonCL() {
    return Positioned(
      bottom: height / 2,
      left: 0,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            width -= tapInfo.delta.dx;
            xPosition += tapInfo.delta.dx;
            validateConstraints();
          });
        },
        child: dragableNode(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ViewerController>(
      builder: (s) => Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
          onTapDown: (details) {},
          onTapUp: (details) {
            setState(() {
              isEditing = !isEditing;
            });
          },
          onLongPress: () {
            setState(() {
              isEditing = !isEditing;
            });
          },
          onPanUpdate: (tapInfo) {
            if (!s.viewerIsEditable.value) return;
            setState(() {
              var xd = tapInfo.delta.dx;
              var yd = tapInfo.delta.dy;
              var minX = xd + xPosition;
              var minY = yd + yPosition;
              var maxX = xPosition + xd + width;
              var maxY = yPosition + yd + height;

              if (minX < 0) {
                xPosition = 0;
              } else if (maxX < ViewerController.to.screenWidth.value) {
                xPosition += tapInfo.delta.dx;
              } else {
                xPosition = ViewerController.to.screenWidth.value - width;
              }
              if (minY < 0) {
                yPosition = 0;
              } else if (maxY < ViewerController.to.screenHeight.value) {
                yPosition += tapInfo.delta.dy;
              } else {
                yPosition = ViewerController.to.screenHeight.value - height;
              }
            });
          },
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: DottedBorder(
                color:
                    s.viewerIsEditable.value ? Colors.grey : Colors.transparent,
                strokeWidth: s.viewerIsEditable.value ? 3 : 0,
                child: drawAnnotationContent(),
              ),
              // ),
            ),
            //isEditing ? CloseButton() : Text(""),

            s.viewerIsEditable.value ? dragButtonBL() : Text(""),
            s.viewerIsEditable.value ? dragButtonBR() : Text(""),
            s.viewerIsEditable.value ? dragButtonTL() : Text(""),
            s.viewerIsEditable.value ? dragButtonTR() : Text(""),

            s.viewerIsEditable.value ? dragButtonBC() : Text(""),
            s.viewerIsEditable.value ? dragButtonTC() : Text(""),

            s.viewerIsEditable.value ? dragButtonCR() : Text(""),
            s.viewerIsEditable.value ? dragButtonCL() : Text(""),
            // isEditing ? dragButton() : Text("ss"),
            // CloseButton(),
          ]),
        ),
      ),
    );
  }

  Container drawAnnotationContent() {
    switch (widget.type) {
      case AnnotationBaseTypes.handWrite:
        return Container(
          width: width,
          height: height,
          color: color,
          child: widget.image != null
              ? Image(image: MemoryImage(widget.image!))
              : Icon(Icons.add),
        );

      case AnnotationBaseTypes.signature:
        return Container(
          width: width,
          height: height,
          color: color,
          child: widget.uiimage,
        );
      case AnnotationBaseTypes.text:
        return Container(
            width: width, height: height, color: color, child: Text("aaaaaaa"));

      default:
        return Container(
          width: width,
          height: height,
          color: color,
          child: widget.image != null
              ? Image(image: MemoryImage(widget.image!))
              : Icon(Icons.add),
        );
    }
    return Container(
      width: width,
      height: height,
      color: color,
      child: widget.image != null
          ? Image(image: MemoryImage(widget.image!))
          : Icon(Icons.add),
    );
  }
}
