import 'package:flutter/material.dart';
import 'package:shared_prefenreces/app/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue[400],
          centerTitle: true,
        ),
      ),
      home: const HomePage(
        title: 'NotePad',
      ),
    );
  }
}
