import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:baby/love/LoveDetailPage.dart';
import 'package:baby/takecase/TakeCasePage.dart';
import 'dart:ui';

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
      home: findRoute(window.defaultRouteName),
    );
  }
}

Widget findRoute(String name) {
  // 路由参考：https://apkdv.com/problems-related-to-using-futterview-in-android-i.html/comment-page-1
  switch (name) {
    case '/router/love/detail':
      return LoveDetailPage(title: '发布Love');
    case '/router/main/takecase':
      return TakeCasePage();
    default:
      return Center(
        child: Text('Unknown route: $name', textDirection: TextDirection.ltr),
      );
  }
}
