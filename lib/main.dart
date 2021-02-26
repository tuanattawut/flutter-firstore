import 'package:flutter/material.dart';
import 'package:lab9_firestore/addbook.dart';
import 'package:lab9_firestore/book.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: buildMaterialApp(),
    );
  }
}

MaterialApp buildMaterialApp() {
  return MaterialApp(
    title: 'FireStore Demo',
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => BookPage(),
      '/addbook': (context) => AddBookPage(),
    },
  );
}
