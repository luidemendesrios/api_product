import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Api product',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),

    );
  }
}
