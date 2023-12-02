import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
          child: Column(
            children: [
              Image.network('https://th.bing.com/th/id/OIG.6xc0LMOc4WsZF05n.Fmr?w=1024&h=1024&rs=1&pid=ImgDetMain'),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text('Hello'),
                    ),
                    Text('Hello'),
                    Text('Hello'),
                    Text('Hello'),
                  ],
                ),
              ),
            ],
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

