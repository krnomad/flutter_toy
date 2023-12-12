import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Content.dart';
import 'style.dart' as style;

void main() {
  runApp(
    MaterialApp(
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
        MainContent(),
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

class MainContent extends StatefulWidget {
  const MainContent({
    super.key,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Content> contents = [];
  var scroll = ScrollController();
  var requestedCount = 0;

  @override
  initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('bottom');
        if ( requestedCount == 0 ) {
          fetchOne('https://codingapple1.github.io/app/more1.json');
        } else if ( requestedCount == 1 ) {
          fetchOne('https://codingapple1.github.io/app/more2.json');
        }

        requestedCount ++;
      }
    });
    fetch('https://codingapple1.github.io/app/data.json');
    print('fetch called');
  }

  @override
  Widget build(BuildContext context) {

    if (contents.length == 0) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: contents.length,
      controller: scroll,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints(
                minHeight: 50,
                maxWidth: 600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    contents[index].image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  Text('좋아요 ${contents[index].likes}개'),
                  Text(contents[index].user),
                  Text(contents[index].date),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void fetchOne(String url) async {
    var uri = Uri.parse(url);
    var baseUrl = uri.origin;
    var path = uri.path;

    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    var json;
    try {
      var response = await dio.get(path);
      json = response.data;
    } catch (e) {
      print(e);
    }

    // Create Content List from jsonList using Content.fromJson
    setState(() {
      print('id: ${json['id']}');
      print('image: ${json['image']}');
      print('likes: ${json['likes']}');
      print('date: ${json['date']}');
      print('content: ${json['content']}');
      print('liked: ${json['liked']}');
      print('user: ${json['user']}');
      print('-------------------');
      try {
        var content = Content.fromJson(json);
        contents.add(content);
      } catch (e) {
        print(e);
      }
    });

    print(contents);
  }

  void fetch(String url) async {
    var uri = Uri.parse(url);
    var baseUrl = uri.origin;
    var path = uri.path;

    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    List jsonList = [];
    try {
      var response = await dio.get(path);
      jsonList = response.data;
    } catch (e) {
      print(e);
    }

    // Create Content List from jsonList using Content.fromJson
    setState(() {
      for (var json in jsonList) {
        print('id: ${json['id']}');
        print('image: ${json['image']}');
        print('likes: ${json['likes']}');
        print('date: ${json['date']}');
        print('content: ${json['content']}');
        print('liked: ${json['liked']}');
        print('user: ${json['user']}');
        print('-------------------');
        try {
          var content = Content.fromJson(json);
          contents.add(content);
        } catch (e) {
          print(e);
          continue;
        }
      }
    });

    print(contents);
  }
}
