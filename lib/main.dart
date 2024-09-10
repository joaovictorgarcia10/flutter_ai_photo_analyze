import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/pages/home_page.dart';
import 'package:flutter_ai_photo_analyze/pages/image_page.dart';
import 'package:flutter_ai_photo_analyze/pages/pdf_page.dart';
import 'package:flutter_ai_photo_analyze/pages/result_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.purple[900]),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/image': (context) => const ImagePage(),
        '/pdf': (context) => const PdfPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}
