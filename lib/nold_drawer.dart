library nold_drawer;

import 'package:flutter/material.dart';
import 'nold_drawer_component.dart';
import 'nold_drawer_controller.dart';
import 'nold_drawer_item.dart';

export 'nold_drawer.dart';
export 'nold_drawer_controller.dart';
export 'nold_drawer_content.dart';
export 'nold_drawer_item.dart';

class NOLD_Drawer extends StatefulWidget {
  NOLD_Drawer({
    Key? key,
    this.header,
    this.footer,
    this.items = const [],
    this.controller,
    this.decoration,
    this.drawerWidth,
    this.minScale,
    this.borderRadius,
    this.shadowBorderRadius,
    this.shadowOffset,
    this.scrollable = true,
    this.menuPadding,
    this.disableContentTap = true,
  }) : super(key: key);

  Widget? header;
  Widget? footer;
  BoxDecoration? decoration;
  List<NOLD_Drawer_Item> items;
  NOLD_Drawer_Controller? controller;
  double? drawerWidth;
  double? minScale;
  double? borderRadius;
  double? shadowBorderRadius;
  double? shadowOffset;
  bool scrollable;
  EdgeInsets? menuPadding;
  bool disableContentTap;

  @override
  _NOLD_Drawer_State createState() => _NOLD_Drawer_State();
}

class _NOLD_Drawer_State extends State<NOLD_Drawer>
    with TickerProviderStateMixin {
  bool _menuOpened = false;
  bool _isDraggingMenu = false;

  double _drawerWidth = 0.66;
  double _minScale = 0.86;
  double _borderRadius = 32.0;
  double _shadowBorderRadius = 44.0;
  double _shadowOffset = 16.0;
  bool _scrollable = false;
  bool _disableContentTap = true;

  late Animation<double> animation, scaleAnimation;
  late Animation<BorderRadius?> radiusAnimation;
  late AnimationController animationController;

  _open() {
    animationController.forward();
    setState(() {
      _menuOpened = true;
    });
  }

  _close() {
    animationController.reverse();
    setState(() {
      _menuOpened = false;
    });
  }

  _onMenuPressed() {
    _menuOpened ? _close() : _open();
  }

  _finishDrawerAnimation() {
    if (_isDraggingMenu) {
      var opened = false;
      setState(() {
        _isDraggingMenu = false;
      });
      if (animationController.value >= 0.4) {
        animationController.forward();
        opened = true;
      } else {
        animationController.reverse();
      }
      setState(() {
        _menuOpened = opened;
      });
    }
  }

  List<NOLD_Drawer_Item> _getDrawerItems() {
    if (widget.controller?.items != null) {
      return widget.controller!.items.map((NOLD_Drawer_Item item) {
        if (item.onPressed == null) {
          item.onPressed = () {
            widget.controller!.page = item.page;
            if (widget.controller!.close != null) widget.controller!.close!();
          };
        }
        item.page?.onMenuPressed = _onMenuPressed;
        return item;
      }).toList();
    }
    return widget.items;
  }

  @override
  void initState() {
    super.initState();
    if (widget.minScale != null) {
      _minScale = widget.minScale!;
    }
    if (widget.borderRadius != null) {
      _borderRadius = widget.borderRadius!;
    }
    if (widget.shadowOffset != null) {
      _shadowOffset = widget.shadowOffset!;
    }
    if (widget.shadowBorderRadius != null) {
      _shadowBorderRadius = widget.shadowBorderRadius!;
    }
    if (widget.drawerWidth != null) {
      _drawerWidth = widget.drawerWidth!;
    }
    if (widget.scrollable) {
      _scrollable = widget.scrollable;
    }
    if (widget.disableContentTap) {
      _disableContentTap = widget.disableContentTap;
    }
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: _minScale).animate(animationController);
    radiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(0.0),
            end: BorderRadius.circular(_borderRadius))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?.page?.onMenuPressed = _onMenuPressed;
    widget.controller?.close = _close;
    widget.controller?.open = _open;

    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (_disableContentTap) {
          if (_menuOpened &&
              event.position.dx / MediaQuery.of(context).size.width >=
                  _drawerWidth) {
            _close();
          } else {
            setState(() {
              _isDraggingMenu = (!_menuOpened && event.position.dx <= 8.0);
            });
          }
        } else {
          setState(() {
            _isDraggingMenu = (_menuOpened &&
                    event.position.dx / MediaQuery.of(context).size.width >=
                        _drawerWidth) ||
                (!_menuOpened && event.position.dx <= 8.0);
          });
        }
      },
      onPointerMove: (PointerMoveEvent event) {
        if (_isDraggingMenu) {
          animationController.value =
              event.position.dx / MediaQuery.of(context).size.width;
        }
      },
      onPointerUp: (PointerUpEvent event) {
        _finishDrawerAnimation();
      },
      onPointerCancel: (PointerCancelEvent event) {
        _finishDrawerAnimation();
      },
      child: Stack(
        children: <Widget>[
          NOLD_Drawer_Component(
            padding: widget.menuPadding,
            scrollable: _scrollable,
            animationController: animationController,
            header: widget.header,
            footer: widget.footer,
            items: _getDrawerItems(),
            decoration: widget.decoration,
          ),
          Transform.scale(
            scale: scaleAnimation.value,
            child: Transform.translate(
              offset: Offset(
                  (MediaQuery.of(context).size.width * _drawerWidth) *
                      animation.value,
                  0.0),
              child: AbsorbPointer(
                absorbing: _menuOpened && _disableContentTap,
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_shadowBorderRadius)),
                              child: Container(
                                color: Colors.white.withAlpha(128),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: animation.value * _shadowOffset),
                      child: ClipRRect(
                        borderRadius: radiusAnimation.value,
                        child: Container(
                          color: Colors.white,
                          child: widget.controller?.page,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
