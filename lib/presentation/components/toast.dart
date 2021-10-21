import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _ToastAnimatedWidget extends StatefulWidget {
  _ToastAnimatedWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {
  bool get _isVisible => true; //update this value later

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 4),
      opacity: _isVisible ? 1.0 : 0.0,
      child: widget.child,
    );
  }
}

class Toast {
  static void show(
    String msg,
    BuildContext context,
  ) {
    dismiss();
    Toast._createView(msg, context);
  }

  static OverlayEntry? _overlayEntry;
  static bool isVisible = false;

  static void _createView(
    String msg,
    BuildContext context,
  ) async {
    var overlayState = Overlay.of(context);

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 30,
        width: MediaQuery.of(context).size.width - 100,
        left: 50,
        child: _ToastAnimatedWidget(
          child: Center(
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 270,
                      child: Text(
                        msg,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    isVisible = true;
    overlayState?.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry?.remove();
  }
}
