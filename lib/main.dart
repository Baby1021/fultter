import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:baby/task.dart';
import 'package:baby/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '赖远文'),
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
    task.processor.name = "赖远文";
    setState(() {
      task = task;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${task.title} ${task.done} ${task.description} ${task.id} ${task.processor.name}',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
