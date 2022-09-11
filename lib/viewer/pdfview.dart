import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import './MoveableStackItem.dart';
import './controllers/viewerController.dart';
import './measureSize.dart';
import './pageContainer.dart';
import './static/AnnotationTypes.dart';

class PDFView extends StatelessWidget {
  PDFView(
      {Key? key,
      // required this.screenWidth,
      // required this.screenHeight,
      required this.pageWidth,
      required this.pageHeigt,
      required this.pages})
      : super(key: key);

  //final ViewerController c = Get.find();

  double screenWidthViewer = 0;
  double screenHeightViewer = 0;

  // final double screenWidth;
  // final double screenHeight;

  List<Widget> movableItems = [];
  final List<PdfPageImage> pages;
  double pageWidth;
  double pageHeigt;

  void _showAction(BuildContext context, int index) {
    var annotation = AnnotationBaseTypes.none;
    switch (index) {
      case 0:
        annotation = AnnotationBaseTypes.text;
        break;
      case 1:
        annotation = AnnotationBaseTypes.handWrite;
        break;
      case 2:
        annotation = AnnotationBaseTypes.shape;
        break;
    }
    ViewerController.to.prepareToAddAnnotationOnTap(annotation);
    // showDialog<void>(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text(_actionTitles[index]),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: const Text('CLOSE'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _onItemTapped(int index) {
    // setState(() {
    ViewerController.to.selectedActionIndex.value = index;
    if (index == 2) {
      ViewerController.to.setEditable(true);
    } else {
      ViewerController.to.setEditable(false);
    }
    // });
  }

  Size myChildSize = Size.zero;
  @override
  Widget build(BuildContext context) {
    // ViewerController.to.setScreenWidthAndHeight(pageWidth, pageHeigt);

    if (pages.isEmpty) {
      return const Text("error ?");
    } else {
      return MeasureSize(
        //setScreenWidthAndHeight
        onChange: (size) {
          //  setState(() {
          print(size);
          myChildSize = size;
          screenWidthViewer = size.width;
          screenHeightViewer = size.height;
          var aspect = screenWidthViewer / pageWidth;

          pageHeigt = pageHeigt * aspect;
          pageWidth = screenWidthViewer;
          ViewerController.to.setScreenWidthAndHeight(pageWidth, pageHeigt);

          ViewerController.to.screenHeight.value = pageHeigt;
          //});
        },
        child: Scaffold(
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
                    // pageWidth: s.screenWidth,
                    // pageHeigt: s.screenHeight,
                    // screenHeight: screenWidthViewer,
                    // screenWidth: screenHeightViewer
                  ),
                ),
                //   ),
              ),
            ),
            floatingActionButton: ExpandableFab(
              distance: 112.0,
              children: [
                ActionButton(
                  onPressed: () => _showAction(context, 0),
                  icon: const Icon(Icons.text_fields),
                ),
                ActionButton(
                  onPressed: () => _showAction(context, 1),
                  icon: const Icon(Icons.draw),
                ),
                ActionButton(
                  onPressed: () => _showAction(context, 2),
                  icon: const Icon(Icons.format_shapes),
                ),
              ],
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.back_hand),
                    label: 'view',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit),
                    label: 'draw',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'annotation',
                  ),
                ],
                currentIndex: ViewerController.to.selectedActionIndex.value,
                selectedItemColor: Colors.amber[800],
                onTap: _onItemTapped,
              ),
            )),
      );
    }
  }
}

class PDFColumn extends StatelessWidget {
  const PDFColumn({
    Key? key,
    required this.pages,
  }) : super(key: key);
  final List<PdfPageImage> pages;
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        pages.length,
        (index) {
          return PageContainer(
            image: MemoryImage(pages[index].bytes),
            pageNumber: index,
          );
        },
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    //  super.key,
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
                color: Theme.of(context).primaryColor,
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
    // super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    // super.key,
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
