import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nold_drawer/nold_drawer.dart';

import 'screens/auth_page.dart';
import 'screens/calendar_page.dart';
import 'screens/main_page.dart';
import 'utils/class_builder.dart';

void main() {
  ClassBuilder.registerClasses();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late NOLD_Drawer_Controller _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = NOLD_Drawer_Controller(
      initialPage: ClassBuilder.fromString('MainPage'),
      items: [
        NOLD_Drawer_Item.initWithPage(
          text: const Text('MAIN', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.home, color: Colors.white),
          page: MainPage(),
        ),
        NOLD_Drawer_Item.initWithPage(
          text: const Text(
            'CALENDAR',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.calendar_today, color: Colors.white),
          page: CalendarPage(),
        ),
        NOLD_Drawer_Item.initWithPage(
          text: const Text(
            'YYYY',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.settings, color: Colors.white),
          page: ClassBuilder.fromString('SettingsPage'),
        ),
        NOLD_Drawer_Item.initWithPage(
          text: const Text(
            'XXX',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.calendar_today, color: Colors.white),
          page: CalendarPage(),
        ),
        NOLD_Drawer_Item.initWithPage(
          text: const Text(
            'SETTINGS',
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.settings, color: Colors.white),
          page: ClassBuilder.fromString('SettingsPage'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NOLD_Drawer(
        borderRadius: 20,
        shadowBorderRadius: 10.0,
        //menuPadding: const EdgeInsets.all(10.0),
        scrollable: false,
        controller: _drawerController,
        minScale: 0.8,
        header: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/logo.png',
              alignment: Alignment.centerLeft,
              height: 100,
              width: 200,
            ),
          ),
        ),
        footer: NOLD_Drawer_Item(
          text: const Text('SIGN IN', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.input, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return AuthPage();
              },
            ));
          },
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 234, 249, 248),
              Color.fromARGB(255, 3, 4, 60)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
