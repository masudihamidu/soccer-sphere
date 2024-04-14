import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NavBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavBar(),
      appBar: AppBar(
        // Apply linear gradient to AppBar background
        backgroundColor: Colors.transparent, // Make the background transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.black87],
            ),
          ),
        ),
      ),
      body: conent(),
    );
  }

  Widget conent(){
    return Container();
  }
}
