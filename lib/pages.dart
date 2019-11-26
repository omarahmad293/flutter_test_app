import 'package:flutter/material.dart';

Widget performancePage = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text("Fibonacci:"),
      TextField(
        keyboardType: TextInputType.number,
      )
    ],
  ),
);

Widget locationPage = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Test:'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'null',
          ),
        ],
      ),
      RaisedButton(
        onPressed: ()async {
          //Position p = await getPosition();           
        },
      ),
    ],
  ),
);

Widget notificationPage = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Test:'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'null',
          ),
        ],
      ),
    ],
  ),
);

Widget deviceInfoPage = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text('Test:'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'null',
          ),
        ],
      ),
    ],
  ),
);