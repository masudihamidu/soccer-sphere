import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';  // Import provider
import 'package:soccersphere/screens/Favourites.dart';
import 'package:soccersphere/screens/Watch.dart';
import 'package:soccersphere/screens/homePage.dart';

import 'Classes/AppState.dart';

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

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(title: 'Homepage'),
      ),
      GoRoute(
        path: '/Favourites',
        builder: (context, state) => const Favourites(title: "Favourites"),
      ),
      GoRoute(
        path: '/Watch',
        builder: (context, state) => const Watch(title: "Watch"),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Soccer',
            theme: ThemeData(),
            routerConfig: _router,
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    return const Scaffold(
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
