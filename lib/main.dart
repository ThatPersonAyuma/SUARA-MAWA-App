import 'package:flutter/material.dart';
import 'utils/server_down.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUARA MAWA',
      theme: ThemeData(
        fontFamily: 'PublicSans'
      ),
      home: ServerDownPage(onRetry: () {
      }),
    );
  }
}