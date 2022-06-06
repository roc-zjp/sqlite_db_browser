import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqlite_db_browser/common/consts.dart';

class DeveloperPage extends StatefulWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  State<DeveloperPage> createState() {
    return DeveloperState();
  }
}

class DeveloperState extends State<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const _LogoTip(),
    );
  }
}

class _LogoTip extends StatefulWidget {
  const _LogoTip({Key? key}) : super(key: key);

  @override
  State<_LogoTip> createState() => _LogoTipState();
}

class _LogoTipState extends State<_LogoTip> {
  final LayerLink _layerLink = LayerLink();
  bool show = false;
  OverlayEntry? _overlayEntry;
  Autocomplete autocomplete = Autocomplete<String>(
    optionsBuilder: (TextEditingValue value) {
      return ["dog", 'cat'];
    },
    fieldViewBuilder: (
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
    ) {
      return TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
    },
  );

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return UnconstrainedBox(
        child: CompositedTransformFollower(
          link: _layerLink,
          followerAnchor: Alignment.topLeft,
          targetAnchor: Alignment.bottomCenter,
          child: Container(
            color: Colors.green,
            child: const Text(
              "我是一个OverlayEntry,目标组件为Flutter 图标",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _toggleOverlay();
          },
          child: CompositedTransformTarget(
            link: _layerLink,
            child: const Positioned(
              child: FlutterLogo(
                size: 80,
              ),
            ),
          ),
        ),
        Positioned(
          left: 100,
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  _showPopMenu(context);
                },
                child: const FlutterLogo(
                  size: 80,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  void dispoae() {
    _hideOverlay();
    super.dispose();
  }

  void _showPopMenu(BuildContext context) {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;

    final offset = renderBox.localToGlobal(Offset.zero);

    //*calculate the start point in this case, below the button
    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    //*The right does not indicates the width
    final right = left + renderBox.size.width;

    final RelativeRect position = buttonMenuPosition(context);
    showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(left, top, right, 0.0),
        useRootNavigator: true,
        items: [
          const PopupMenuItem<String>(child: Text('Doge'), value: 'Doge'),
          const PopupMenuItem<String>(child: Text('Lion'), value: 'Lion'),
        ]).then((value) => null);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  RelativeRect buttonMenuPosition(BuildContext context) {
    final RenderBox bar = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;
    const Offset offset = Offset.zero;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.centerRight(offset), ancestor: overlay),
        bar.localToGlobal(bar.size.centerRight(offset), ancestor: overlay),
      ),
      offset & overlay.size,
    );
    return position;
  }

  void _toggleOverlay() {
    if (!show) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
    show = !show;
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
    logger.d("show Overlay");
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
  }
}
