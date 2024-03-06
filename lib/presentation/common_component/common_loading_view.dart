import 'package:flutter/material.dart';

/// Global key for accessing the overlay state
final _tKey = GlobalKey(debugLabel: 'overlay_parent');

/// Variables to track theme and loading overlay state
bool isDarkTheme = false;
bool _loaderShown = false;

/// Overlay entry for the loading indicator
OverlayEntry? _loaderEntry;

/// Widget for displaying loading overlay
class Loading extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const Loading({Key? key, this.child, this.darkTheme = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Set theme based on parameter
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

/// Function to retrieve the overlay state
OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;

  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);

  assert(navigator != null, '''unable to show overlay''');
  return navigator!.overlay;
}

/// Function to show loading indicator overlay
Future<void> showLoadingIndicator({bool isModal = true, Color? modalColor}) async {
  try {
    debugPrint('Showing loading overlay');

    /// Widget for the loading indicator
    const child = Center(
      child: CircularProgressIndicator(),
    );

    /// Show overlay with or without modal barrier based on parameter
    await _showOverlay(
      child: isModal
          ? Stack(
        children: <Widget>[
          ModalBarrier(
            color: modalColor,
          ),
          child
        ],
      )
          : child,
    );
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    rethrow;
  }
}

/// Function to hide loading indicator overlay
Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    rethrow;
  }
}

/// Function to insert loading indicator overlay into the overlay stack
Future<void> _showOverlay({required Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      /// TODO: Handle if overlay is already shown
      return Future.value();
    }

    /// Create overlay entry and insert into the overlay stack
    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    rethrow;
  }
}

/// Function to remove loading indicator overlay from the overlay stack
Future<void> _hideOverlay() async {
  try {
    _loaderEntry?.remove();
    _loaderEntry = null;
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    rethrow;
  }
}
