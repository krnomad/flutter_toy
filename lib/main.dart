import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'style.dart' as style;

void main() {
  runApp(MaterialApp(
      theme: style.themeData,
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
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () {
              print('Pressed');
            },
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: [
        ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return MainContent();
            }),
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
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(
                  'https://th.bing.com/th/id/OIG.6xc0LMOc4WsZF05n.Fmr?w=1024&h=1024&rs=1&pid=ImgDetMain'),
              Row(
                children: [
                  Text('종아요 100'),
                ],
              ),
              Row(
                children: [
                  Text('johnkim'),
                ],
              ),
              Row(
                children: [
                  Text('8월 7일'),
                ],
              ),
            ],
          )),
    );
  }
}

