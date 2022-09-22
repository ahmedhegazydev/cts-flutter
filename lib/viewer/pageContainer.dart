import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/viewerController.dart';
import 'signaturecanvas/signature.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.image,
    required this.pageNumber,
  }) : super(key: key);

  final Image image;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    final control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.65,
      velocityRange: 4.0,
    );

    final theme = Theme.of(context);
    return GetX<ViewerController>(builder: (s) => buildPage(s, control, theme));
    //  return
  }

  Widget buildPage(
      ViewerController s, HandSignatureControl control, ThemeData theme) {
    // return SizedBox(
    //   width: s.screenWidth.value,
    //   height: s.screenHeight.value,
    //   child: image,
    // );
    // return SizedBox(
    //   width: s.screenWidth.value,
    //   height: s.screenHeight.value,
    //   child: Stack(children: [
    //     image,
    //     // ...s.annotations[pageNumber],
    //     // GetX<ViewerController>(
    //     //   builder: (s) => Stack(
    //     //     children: s.annotations[pageNumber],
    //     //   ),
    //     // ),
    //   ]),
    // );
    return GestureDetector(
      onTapDown: (details) {},
      onTapCancel: () {
        print("Cancel tap");
      },
      onTapUp: (details) {
        if (ViewerController.to.checkIfAddingAnnotation()) {
          var x = details.localPosition.dx;
          var y = details.localPosition.dy;
          ViewerController.to
              .creatAndAddAnnotationOnTap(120, 60, x, y, pageNumber);
        }
      },
      child: SizedBox(
        width: s.screenWidth.value,
        height: s.screenHeight.value,
        child: Stack(children: [
          image,
          ...s.annotations[pageNumber],
          // GetX<ViewerController>(
          //   builder: (s) => Stack(
          //     children: s.annotations[pageNumber],
          //   ),
          // ),
        ]),
      ),
    );
  }

  void ExportCanvasToImage(HandSignatureControl control) {
    // var svg = control.toSvg(wrapSignature: true);
    var bounds = control.getBounds();
    control
        .toImage(
      maxSize: 6.0,
      width: bounds.width.toInt() * 4,
      height: bounds.height.toInt() * 4,
    )
        .then((value) {
      ViewerController.to.creatAndAddAnnotationOnDraw(
          bounds.width,
          bounds.height,
          bounds.left,
          bounds.top,
          "aa",
          pageNumber,
          value!.buffer.asUint8List());
      control.clear();
    });
  }
}
