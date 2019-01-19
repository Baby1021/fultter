import 'dart:convert';

import 'package:baby/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

Dio http = new Dio();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '发布',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '发布'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const argumentChannel =
      const MethodChannel("app.channel.page.argument");

  Task task = null;

  @override
  void initState() {
    super.initState();
    getArgument();
  }

  void getArgument() async {
    String argument = await argumentChannel.invokeMethod("getArgument");
    Map<String, dynamic> temp = jsonDecode(argument)['task'];
    if (argument != null) {
      setState(() {
        task = Task.fromJson(temp);
      });
    }
  }

  void _incrementCounter() {
    get();
  }

  post() async {
    // 头部
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    // body
    String body = jsonEncode({
      "task": {"title": _controller.text, "processor": "laiyuanwen"}
    });

    // 请求
    var response = await http.post(
      "http://39.108.227.137:3000/api/v1/task",
      data: body,
      // 这个参数可以不配置
      // options: new Options(headers: headers)
    );

    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("http post方法"),
        content: new Text(response.data.toString()),
      ),
    );
  }

  get() async {
    var response =
        await http.get("http://39.108.227.137:3000/api/v1/user/list");
    showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text("http get"),
        content: new Text(response.data),
      ),
    );
  }

  void _save() async {
    showTestDialog("保存");
  }

  void _confirmDelete() async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('你确认删除吗'),
              contentPadding: EdgeInsets.all(0),
              actions: <Widget>[
                new FlatButton(
                  onPressed: _delete,
                  child: new Text('确定'),
                  padding: EdgeInsets.all(1),
                ),
                new FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: new Text('取消'),
                ),
              ],
            ));
  }

  void _delete() async {
    await http.delete("http://39.108.227.137:3000/api/v1/task",
        data: {"taskId": task.id});
    SystemNavigator.pop();
  }

  void _back() async {
    showTestDialog("点击返回");
    // 直接返回了
//    SystemNavigator.pop();
  }

  Future<bool> _systemBack() async {
    showTestDialog("系统back键");
    return Future.value(false);
  }

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBack,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),

          // todo 这里有一个BackButton
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _back,
          ),

          // 右边按钮
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: "删除",
              onPressed: _confirmDelete,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextField(
                  autofocus: true,
                  maxLines: 8,
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  cursorWidth: 1.5,
                  controller: _controller,
                  cursorRadius: Radius.circular(1.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '你要分享什么给你家宝贝呢',
                    hintStyle: TextStyle(),
                  ),
                ),
              ),
              new RaisedButton(
                onPressed: post,
                child: new Text('添加任务'),
              ),
              new RaisedButton(
                onPressed: _delete,
                child: new Text("删除任务"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _save,
          tooltip: 'Increment',
          child: Icon(Icons.done),
        ),
      ),
    );
  }

  void showTestDialog(String message) {
    showDialog(
        context: context,
        child: new AlertDialog(
          content: new Text(message),
        ));
  }
}
