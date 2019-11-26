import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info/device_info.dart';
import 'functions.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparison',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'ProductSans'),
      home: MyHomePage(title: 'Comparison App'),
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

  int _n;
  BigInt _fibo = BigInt.from(0);
  Duration _time = Duration();

  Position _position = Position();
  Placemark _location = Placemark();

  String _pasted = "";

  String _android = "";

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

  void notify() async {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Text('Fibo:'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (i) {
                    setState(() {
                      _n = int.parse(i);
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Calculate Fibonacci"),
                  onPressed: () {
                    setState(() {
                      Map<String, dynamic> temp = fibonacci(_n);
                      _fibo = temp['f'];
                      _time = temp['t'];
                    });
                  },
                ),
                AutoSizeText(
                  _fibo.toString(),
                  maxLines: 2,
                ),
                Text("Calculation took $_time seconds"),
              ]),
            ),
            Container(
              child: Column(children: <Widget>[
                RaisedButton(
                  child: Text("Get Position"),
                  onPressed: () async {
                    Position p = await getPosition();
                    List<Placemark> l = await Geolocator()
                        .placemarkFromCoordinates(p.longitude, p.latitude);
                    setState(() {
                      _position = p;
                      _location = l[0];
                    });
                  },
                ),
                Text("${_position.longitude}, ${_position.latitude}"),
                Text("${_location.country}")
              ]),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Notify"),
                    onPressed: notify,
                  )
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                child: Text("Vibrate"),
                onPressed: HapticFeedback.lightImpact,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_pasted ?? "null"),
                  RaisedButton(
                    child: Text("Paste"),
                    onPressed: () {
                      setState(() async {
                        ClipboardData c = await Clipboard.getData('text/plain');
                        _pasted = c.text;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_android ?? "null"),
                  RaisedButton(
                    child: Text("Device Info"),
                    onPressed: () async {
                      AndroidDeviceInfo android = await getDeviceInfo();
                      setState(() {
                        _android = android.model;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
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
            icon: Icon(Icons.speaker),
            backgroundColor: Colors.red,
            title: Text("Performance"),
          ),
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
