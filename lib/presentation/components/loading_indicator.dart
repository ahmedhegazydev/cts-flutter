import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final _tKey = GlobalKey<NavigatorState>();
final _modalBarrierDefaultColor = Colors.black.withOpacity(0.7);

OverlayEntry? _loaderEntry;

bool _loaderShown = false;

Widget? _loadingIndicator;

class Loading extends StatelessWidget {
  final Widget? child;
  final Widget? loader;
  final bool darkTheme;

  const Loading({Key? key, this.child, this.loader, this.darkTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _loadingIndicator = loader;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

showLoadingIndicator(BuildContext context,
    {bool isModal = true, Color? modalColor}) async {
  try {
    debugPrint('Showing loading overlay');
    final _child = Center(
      child: SizedBox(
        child: _loadingIndicator ?? CircularProgressIndicator(),
        width: 30,
        height: 30,
      ),
    );
    await _showOverlay(
      context: context,
      child: isModal
          ? Stack(
              children: <Widget>[
                ModalBarrier(
                  color: modalColor ?? _modalBarrierDefaultColor,
                ),
                _child
              ],
            )
          : _child,
    );
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    throw err;
  }
}

Future<void> _showOverlay(
    {required BuildContext context, required Widget child}) async {
  try {
    final overlay = Navigator.of(context, rootNavigator: true).overlay;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      return Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    if (overlay != null) overlay.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> _hideOverlay() async {
  try {
    if (_loaderEntry != null) _loaderEntry!.remove();
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    throw err;
  }
}
