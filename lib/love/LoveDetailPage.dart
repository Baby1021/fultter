import 'dart:convert';

import 'package:baby/bean/love.dart';
import 'package:baby/http/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoveDetailPage extends StatefulWidget {
  LoveDetailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoveDetailPage> {
  static const argumentChannel =
      const MethodChannel("app.channel.page.argument");

  Love love = null;
  String userId = null;

  @override
  void initState() {
    super.initState();
    getArgument();
  }

  void getArgument() async {
    String argument = await argumentChannel.invokeMethod("getArgument");
    var json = jsonDecode(argument);
    Map<String, dynamic> temp = json['love'];

    if (temp != null) {
      setState(() {
        love = Love.fromJson(temp);
      });
    }
    setState(() {
      userId = json['userId'];
    });
  }

  _addLove() async {
    if (love == null) {
      await Service.getInstance().addLove(_controller.text, userId);
    } else {
      await Service.getInstance().updateLove(love.id, _controller.text, userId);
    }
    _back();
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
    if (love == null) {
      return;
    }
    await Service.getInstance().deleteLove(love.id);
    _back();
  }

  void _back() async {
    SystemNavigator.pop();
  }

  Future<bool> _systemBack() async {
    _back();
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addLove,
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
