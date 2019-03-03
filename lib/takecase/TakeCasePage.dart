import 'dart:convert';
import 'dart:io';

import 'package:baby/bean/love.dart';
import 'package:baby/http/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TakeCasePage extends StatefulWidget {
  TakeCasePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TakeCasePage> {
  _MyHomePageState() {
    // 状态栏颜色
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.white);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("开发中"),
          ],
        ),
      ),
    );
  }
}
