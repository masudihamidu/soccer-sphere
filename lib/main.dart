import 'dart:async'; // Import the async library
import 'package:flutter/material.dart';
import 'package:soccersphere/screens/homePage.dart';
Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Start a timer with a duration of 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soccer',
      theme: ThemeData(),
      home: _isLoading ? _buildLoader() : MyHomePage(title: 'Soccer'),
    );
  }

  Widget _buildLoader() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Soccer',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
