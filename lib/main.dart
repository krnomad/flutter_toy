import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.red,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        actions: [
          IconButton(
            onPressed: () {
              print('Pressed');
            },
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: [
        Container(
          child: Center(
            child: Text('tab1'),
          ),
        ),
        Container(
          child: Center(
            child: Text('tab2'),
          ),
        )
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: (index) {
          setState(() {
            tab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

