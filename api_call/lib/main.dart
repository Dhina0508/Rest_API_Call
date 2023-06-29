import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.teal,
          useMaterial3: true,
        ),
        home: RestAPICall());
  }
}

class RestAPICall extends StatefulWidget {
  RestAPICall({Key? key}) : super(key: key);

  @override
  State<RestAPICall> createState() => _RestAPICallState();
}

class _RestAPICallState extends State<RestAPICall> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Rest API Call',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ), // AppBar
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final name = user['name']['first'];
            final email = user['email'];
            final age = user['dob']['age'];
            final imageUrl = user['picture']['thumbnail'];
            return ListTile(
              onTap: () {},
              trailing: Column(
                children: [
                  Text("Age"),
                  Text(age.toString()),
                ],
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageUrl),
              ), // ClipRRect
              title: Text(name),
              subtitle: Text(email),
            ); // ListTile/ ListTile
          }), // ListView.builder
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.refresh),
        onPressed: fetchUsers,
      ), // FloatingActionButton
    ); // Scaffold
  }

  void fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=50';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });
  }
}
