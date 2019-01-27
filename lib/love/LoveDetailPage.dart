import 'dart:convert';
import 'dart:io';

import 'package:baby/bean/love.dart';
import 'package:baby/http/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class LoveDetailPage extends StatefulWidget {
  LoveDetailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoveDetailPage> {
  static const argumentChannel =
      const MethodChannel("app.channel.page.argument");

  Love love;
  String userId;
  bool isChange = false;
  List<File> _images = [];
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_changeContent);
    getArgument();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _images.add(image);
      });
    } else {
      showTestDialog("没有选择图片");
    }
  }

  void _changeContent() async {
    setState(() {
      isChange = true;
    });
  }

  void getArgument() async {
    String argument = await argumentChannel.invokeMethod("getArgument");
    var json = jsonDecode(argument);
    Map<String, dynamic> temp = json['love'];

    if (temp != null) {
      var _love = Love.fromJson(temp);
      setState(() {
        love = _love;
      });
      _controller.text = _love.content;
    }
    setState(() {
      userId = json['userId'];
    });
  }

  _addLove() async {
    showLoadingDialog();
    if (love == null) {
//      await Service.getInstance().addLove(_controller.text, userId);
      await Service.getInstance()
          .addLoveWithImage(_images, _controller.text, userId);
    } else {
      await Service.getInstance().updateLove(love.id, _controller.text, userId);
    }
    closeLoadingDialog();
    _back();
  }

  showLoadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Center(
              child: Container(
                width: 300,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  // todo 抽象自定义Flutter Dialog
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        child: new CircularProgressIndicator(),
                      ),
                      Text(
                        "正在保存中",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  closeLoadingDialog() {
    Navigator.pop(context);
//    new Future.delayed(const Duration(seconds: 1), () {});
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
    // 判断是否刷新
    await argumentChannel.invokeMethod("setResult", {"isRefresh": isChange});
    SystemNavigator.pop();
  }

  Future<bool> _systemBack() async {
    _back();
    return Future.value(false);
  }

  void showTestDialog(String message) {
    showDialog(
        context: context,
        child: new AlertDialog(
          content: new Text(message),
        ));
  }

  uploadImage() async {
    await Service.getInstance()
        .addLoveWithImage(_images, _controller.text, userId);
    showTestDialog("上传图片成功");
  }

  Widget buildItem(File image) {
    return Image.file(image);
  }

  Widget generateImage() {
    return new GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: _images.length >= 9 ? 9 : _images.length + 1,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (_images.length >= 9 && index >= _images.length) {
          return Container(
            width: 0,
            height: 0,
          );
        }
        if (index == _images.length) {
          return new RaisedButton(
            onPressed: getImage,
            child: Text("选择图片"),
          );
        }
        return buildItem(_images[index]);
      },
    );
  }

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
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.delete),
//              tooltip: "删除",
//              onPressed: _confirmDelete,
//            ),
//          ],
        ),
        body: SingleChildScrollView(
          child: Center(
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
                generateImage()
              ],
            ),
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
}
