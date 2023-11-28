// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  var inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );

  runApp(MaterialApp(
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red[600],
    ),
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.red[600],
      inputDecorationTheme: inputDecorationTheme,
    ),
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

  List<String> people = [];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My App (${people.length})'),
          backgroundColor: Colors.red[600],
          actions: [
            IconButton(
              onPressed: () {
                getPermission();
                loadContacts();
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
                  addContact: addContact,
                );
              });
        },
      ),
    );
  }

  void loadContacts() async {
    // Iterable<Contact> contacts = await ContactsService.getContacts();
    var contacts = await ContactsService.getContacts();
    setState(() {
      people.clear();
      contacts.forEach((element) {
        if ( element.displayName != null ) {
          people.add(element.displayName!);
          // people.add(element.displayName ?? 'Unknown');
          print(element.displayName);
        }
      });
    });
  }

  void addContact(String displayName, String givenName, String familyName, String phone) async {
    Contact newContact = Contact(
      displayName: displayName,
      givenName: givenName,
      familyName: familyName,
      phones: [Item(label: 'mobile', value: phone)],
    );

    print('Adding Contact $newContact');


    await ContactsService.addContact(newContact);
  }
}

class InputDialog extends StatelessWidget {
  final Function(String, String, String, String) addContact;

  InputDialog({
    super.key,
    required this.addContact,
  });

  // add contact input data - DisplayName, GivenName, FamilyName, Phone
  var displayName = TextEditingController();
  var givenName = TextEditingController();
  var familyName = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var inputDecorationTheme = ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow,
                width: 1.0,
              ),
          ),
      ),
    );

    return AlertDialog(
      title: Text('Add Person'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            // use inputDecorationTheme
            controller: displayName,
          ),
          TextField(
            controller: displayName,
            decoration: InputDecoration(
              labelText: 'Display Name',
              hintText: 'Enter Display Name',
            ),
          ),
          TextField(
            controller: givenName,
            decoration: InputDecoration(
              labelText: 'Given Name',
              hintText: 'Enter Given Name',
            ),
          ),
          TextField(
            controller: familyName,
            decoration: InputDecoration(
              labelText: 'Family Name',
              hintText: 'Enter Family Name',
            ),
          ),
          TextField(
            controller: phone,
            decoration: InputDecoration(
              labelText: 'Phone',
              hintText: 'Enter Phone',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await addContact(displayName.text, givenName.text, familyName.text, phone.text);
            Navigator.pop(context);
          },
          child: Text('Add Contact'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}


