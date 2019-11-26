import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_app/pages.dart';
import 'pages.dart';
//import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparison',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'ProductSans'),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int _index = 0;
  final List<Widget> _children = [performancePage,locationPage, notificationPage, deviceInfoPage];

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("Payload: $payload");
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: Text("TEST"), content: Text("test")));
  }

  void _buttonFunction() async {
    var android =
        AndroidNotificationDetails('channel id', 'channel name', 'description');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(0, 'TEST', 'body', platform,
        payload: "Hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: _buttonFunction,
        tooltip: 'Get Position',
        child: Icon(Icons.camera),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            backgroundColor: Colors.red,
            title: Text("Location"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            backgroundColor: Colors.blue,
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            backgroundColor: Colors.orange,
            title: Text("Device Info"),
          )
        ],
      ),
    );
  }
}
