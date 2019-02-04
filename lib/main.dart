import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:baby/love/LoveDetailPage.dart';

Dio http = new Dio();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '发布',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoveDetailPage(title: '发布Love'),
    );
  }
}
