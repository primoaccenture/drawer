import 'package:flutter/material.dart';
import 'nold_drawer_item.dart';

class NOLD_Drawer_Component extends StatefulWidget {
  NOLD_Drawer_Component({
    Key? key,
    this.animationController,
    this.header,
    this.footer,
    this.items = const [],
    this.decoration,
    this.scrollable = true,
    this.padding,
  }) : super(key: key);

  Widget? header;
  Widget? footer;
  List<NOLD_Drawer_Item> items;
  BoxDecoration? decoration;
  bool scrollable;
  EdgeInsets? padding;

  Animation<double>? animationController;

  @override
  _NOLD_Drawer_Component_State createState() => _NOLD_Drawer_Component_State();
}

class _NOLD_Drawer_Component_State extends State<NOLD_Drawer_Component> {
  var _padding = EdgeInsets.symmetric(vertical: 64.0);

  Widget _getMenu() {
    if (widget.scrollable) {
      return ListView(
        children: [
          Container(
            child: widget.header,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items,
          ),
          if (widget.footer != null) widget.footer!,
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            child: widget.header,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.items,
            ),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.padding != null) {
      _padding = widget.padding!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: Padding(
        padding: _padding,
        child: _getMenu(),
      ),
    );
  }
}
