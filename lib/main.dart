import 'dart:io';

import 'package:driver3/sell_buy.dart';
import 'package:driver3/worker_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider package
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HISOBCHI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WorkersPage()));
              },
              child: Text('Ishchi xodim uchun'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SellBuyPage()));
              },
              child: Text('Kirim - chiqim uchun '),
            ),
          ],
        ),
      ),
    );
  }
}
