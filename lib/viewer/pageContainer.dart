import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/viewerController.dart';
import 'signaturecanvas/signature.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.image,
    required this.pageNumber,
    // required this.width,
    // required this.height,
    // required this.screenHeight,
    // required this.screenWidth,
  }) : super(key: key);

  // final List<Widget> movableItems;
  // final double width;
  // final double height;
  final MemoryImage image;
  final int pageNumber;

  // final double screenWidth;
  // final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final control = HandSignatureControl(
      threshold: 3.0,
      smoothRatio: 0.65,
      velocityRange: 4.0,
    );

    //final signature =
    // return Container(
    //   color: Colors.red,
    //   // child: HandSignature(
    //   //   control: control,
    //   //   color: Colors.blueGrey,
    //   //   width: 1.0,
    //   //   maxWidth: 10.0,
    //   //   type: SignatureDrawType.shape,
    //   // ),
    // );
    final theme = Theme.of(context);
    return GetX<ViewerController>(
        builder: (s) => GestureDetector(
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
                  SizedBox(
                    child: Image(
                      image: image,
                    ),
                  ),
                  GetX<ViewerController>(
                    builder: (s) => Stack(
                      children: s.annotations[pageNumber],
                    ),
                  ),
                  GetX<ViewerController>(
                    builder: (s) => s.selectedActionIndex.value == 99
                        ? HandSignature(
                            control: control,
                            color: Colors.blue,
                            width: 1.0,
                            maxWidth: 5.0,
                            type: SignatureDrawType.arc,
                            onPointerDown: () {
                              print("pt down");
                            },
                            onPointerUp: () {
                              // ExportCanvasToImage(control);
                            },
                            viewWidth: s.screenWidth.value,
                            viewHeight: s.screenHeight.value,
                          )
                        : Container(),
                  ),
                  GetX<ViewerController>(
                    builder: (s) => s.selectedActionIndex.value == 99
                        ? Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            color: theme.colorScheme.secondary,
                            elevation: 4.0,
                            child: IconButton(
                              onPressed: () {
                                ExportCanvasToImage(control);
                              },
                              icon: Icon(
                                Icons.save,
                                // color: Colors.black,
                                //size: 32,
                              ),
                            ),
                            //  color: theme.colorScheme.onSecondary,
                          )
                        : const Text(""),
                  ),
                ]),
              ),
            ));
    //  return
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
