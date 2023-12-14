import 'package:flutter/material.dart';
import 'nold_drawer_content.dart';

class NOLD_Drawer_Item extends StatelessWidget {
  NOLD_Drawer_Item({this.onPressed, this.text, this.icon});

  NOLD_Drawer_Item.initWithPage(
      {this.onPressed, this.text, this.icon, this.alias, this.page});

  GestureTapCallback? onPressed;
  Widget? text;
  Widget? icon;

  String? alias;
  NOLD_Drawer_Content? page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 8.0),
                  child: icon,
                ),
                if (text != null) text!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
