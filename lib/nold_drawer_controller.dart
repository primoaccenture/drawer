import 'nold_drawer_content.dart';
import 'nold_drawer_item.dart';

class NOLD_Drawer_Controller {
  NOLD_Drawer_Controller(
      {this.items = const [], required NOLD_Drawer_Content initialPage}) {
    this.page = initialPage;
  }

  List<NOLD_Drawer_Item> items;
  Function? close;
  Function? open;
  NOLD_Drawer_Content? page;
}
