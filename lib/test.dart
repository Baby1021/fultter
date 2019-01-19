//import 'package:flutter/material.dart';
//
//class test {
//  void test() {
//    new TextField(
//      controller: _controller,
//      //输入文本的样式
//      style: TextStyle(fontSize: 15.0, color: Colors.blue),
//      maxLength: 30,
//      decoration: InputDecoration(
//        contentPadding: EdgeInsets.only(bottom: 8),
//        icon: Icon(Icons.lightbulb_outline),
//        labelText: '请输入你的姓名',
//        helperText: '请输入你的真实姓名',
//        // border: OutlineInputBorder(
//        //   borderRadius: BorderRadius.only(topRight: Radius.circular(10),),
//        //   borderSide: BorderSide(color: Colors.red),
//        // ),
//      ),
//      cursorColor: Colors.blue,
//      cursorWidth: 1.0,
//      cursorRadius: Radius.circular(1.0),
//      autofocus: false,
//      onSubmitted: (text) {
//        //内容提交(按回车)的回调
//        showDialog(
//          context: context,
//          child: new AlertDialog(
//            title: new Text("点击了回车"),
//          ),
//        );
//      },
//    )
//    ,
//  }
//}