import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:home_automation/home.dart';
import 'pages/google_auth.dart';
import 'auth.dart';
import 'auth_provider.dart';

void main() {
  FirebaseDatabase database;
  database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
  runApp(AuthProvider(auth: Auth(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/home.png'), context);
    precacheImage(AssetImage('assets/g-logo.png'), context);
    precacheImage(AssetImage('assets/dashboard.png'), context);
    precacheImage(AssetImage('assets/empty.png'), context);

    return MaterialApp(
      title: 'Automate',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.indigo,
      // ),
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
          primarySwatch: Colors.grey),
      // home: MyHomePage(title: 'Automate'),
      // home: GoogleAuth(),
      initialRoute: '/',
      routes: {
        '/': (context) => GoogleAuth(),
      },
    );
  }
}
