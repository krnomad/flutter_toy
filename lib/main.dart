// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
  var people = ['John', 'Doe', 'Jane'];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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

  String name = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Person'),
      content: TextField(
        onChanged: (value) {
          name = value;
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            addPerson(name);
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


