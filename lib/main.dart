// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  getPermission() async {
    var status = await Permission.contacts.status;
    if ( status.isGranted ) {
      print('Permission is already granted');
    } else {
      print('No Permission');
      await Permission.contacts.request();

      if ( status.isGranted ) {
        print('Permission is granted');
      } else {
        print('Permission is denied');
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getPermission();
  // }

  var people = ['John', 'Doe', 'Jane'];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My App'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
          actions: [
            IconButton(
              onPressed: () {
                getPermission();
                // openAppSettings();
              },
              icon: Icon(Icons.contacts),
            ),
            IconButton(
              onPressed: () {
                print('Clicked');
              },
              icon: Icon(Icons.search),
            ),
          ],
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(people[index]),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return InputDialog(
                  addPerson: (name) {
                    setState(() {
                      people.add(name);
                    });
                  }
                );
              });
        },
      ),
    );
  }
}

class InputDialog extends StatelessWidget {
  final Function(String) addPerson;

  InputDialog({
    super.key,
    required this.addPerson,
  });

  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Person'),
      content: TextField(
        controller: inputData,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            addPerson(inputData.text);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('cancel'),
        ),
      ],
    );
  }
}


