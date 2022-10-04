import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import '../controllers/document_controller.dart';
import '../utility/utilitie.dart';
import './controllers/viewerController.dart';
import './pageContainer.dart';
import './static/AnnotationTypes.dart';

class PDFView extends StatefulWidget {
  PDFView({
    Key? key,
    // required this.screenWidth,
    // required this.screenHeight,
    required this.originalAnnotations,
    required this.url,
    required this.color,
    required this.size,
  }) : super(key: key);

  final List<ViewerAnnotation> originalAnnotations;
  final Size size;
  final String url;
  final Color color;
  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ViewerController.to.themeColor = widget.color;
    Future.delayed(const Duration(milliseconds: 200), () {
      preparePDF().then((data) {
        widget.originalAnnotations.forEach((element) {
          double width = double.tryParse(element.width!) ?? 0;
          double height = double.tryParse(element.height!) ?? 0;
          double x = double.tryParse(element.X!) ?? 0;
          double y = double.tryParse(element.Y!) ?? 0;
          int page = int.tryParse(element.page!) ?? 1;
          page = page - 1;
          //
          String imageBytes =
              element.imageByte.replaceAll("data:image/png;base64,", "");
          ViewerController.to.creatAndAddAnnotationOnLoad(
              width: width,
              height: height,
              image: Image.memory(
                dataFromBase64String(imageBytes),
                fit: BoxFit.fill,
              ),
              originX: x,
              originY: y,
              page: page,
              base64: element.imageByte,
              type: element.type);
        });

        setState(() {
          pages = data;
        });
      });
    });
  }

  List<PdfPageImage> pages = [];
  double dpageWidth = 0;
  double dpageHeigt = 0;
  Size myChildSize = Size.zero;

  preparePDF() async {
    pages = [];

    final document = await PdfDocument.openData(
      await InternetFile.get(
        widget.url,
      ),
    );
    for (int i = 1; i <= document.pagesCount; i++) {
      final page = await document.getPage(i);

      dpageHeigt = page.height.toDouble();
      dpageWidth = page.width.toDouble();
      ViewerController.to.pageheight = dpageHeigt;
      ViewerController.to.pagewidth = dpageWidth;
      var aspect = dpageWidth / widget.size.width;
      final pageImage = await page.render(
          width: widget.size.width, height: dpageHeigt / aspect);
      pages.add(pageImage!);
      ViewerController.to
          .setScreenWidthAndHeight(widget.size.width, dpageHeigt / aspect);

      // ViewerController.to.screenHeight.value = widget.size.height / aspect;
    }
    ViewerController.to.setupLists(document.pagesCount);
    return pages;
  }

  List<Widget> movableItems = [];

  // Size myChildSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return Container(
        child: CircularProgressIndicator.adaptive(),
        color: Colors.grey[100],
      );
    } else {
      // return SingleChildScrollView(
      //   child: PDFColumn(
      //     pages: pages,
      //   ),
      // );
      return Scaffold(
        body: GetX<ViewerController>(
          builder: (s) => InteractiveViewer(
            scaleEnabled: s.selectedActionIndex.value == 0,
            panEnabled: s.selectedActionIndex.value == 0,
            minScale: 1.0,
            maxScale: 4.0,
            child: SingleChildScrollView(
              physics: s.selectedActionIndex.value != 0
                  ? const NeverScrollableScrollPhysics()
                  : const ScrollPhysics(),
              child: PDFColumn(
                pages: pages,
                size: widget.size,
              ),
            ),
          ),
        ),
      );
    }
  }
}

class PDFColumn extends StatelessWidget {
  const PDFColumn({
    Key? key,
    required this.pages,
    required this.size,
  }) : super(key: key);
  final Size size;
  final List<PdfPageImage> pages;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.green,
      child: Column(
        children: List.generate(
          pages.length,
          (index) {
            return Container(
              child: GestureDetector(
                onPanStart: ((details) => print(details)),
                onTap: () {
                  print('On Tap ');
                },
                onDoubleTap: () {
                  ViewerController.to.selectedActionIndex.value = 0;
                  ViewerController.to.setEditable(false);
                },
                onTapUp: (details) {
                  print('On Tap Up');
                  print(details);
                },
                onTapCancel: () => print('On Tap Cancel'),
                onTapDown: (details) {
                  print(details);
                },
                child: Container(
                  child: SizedBox(
                    // width: size.width,
                    child: Container(
                      //  color: Colors.pink,
                      child: PageContainer(
                        image: Image.memory(
                          pages[index].bytes,
                          //  width: 2100,
                        ),
                        pageNumber: index,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// class PDFColumn extends StatelessWidget {
//   const PDFColumn({
//     Key? key,
//     required this.pages,
//   }) : super(key: key);
//   final List<PdfPageImage> pages;
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(
//         pages.length,
//         (index) {
//           return GestureDetector(
//             onPanStart: ((details) => print(details)),
//             onTap: () {
//               print('On Tap ');
//             },
//             onDoubleTap: () {
//               ViewerController.to.selectedActionIndex.value = 0;

//               ViewerController.to.setEditable(false);
//             },
//             onTapUp: (details) {
//               print('On Tap Up');
//               print(details);
//             },
//             onTapCancel: () => print('On Tap Cancel'),
//             onTapDown: (details) {
//               print(details);
//             },
//             child: PageContainer(
//               image: Image.memory(pages[index].bytes),
//               // Image.asset(
//               //     fit: BoxFit.cover,
//               //     "assets/images/background_R.png"), // MemoryImage(pages[index].bytes),
//               pageNumber: index,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

String uint8ListTob64(Uint8List uint8list) {
  String base64String = base64Encode(uint8list);
  String header = "data:image/png;base64,";
  return header + base64String;
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    // super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {});

    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: ViewerController.to.themeColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (3.14 / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * 3.14 / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    //  super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      //  color: Colors.red,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        // color: Colors.white,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    //  super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
