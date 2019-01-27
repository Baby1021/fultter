import 'dart:core';

import 'package:baby/bean/User.dart';

class Task {
  final int id;
  final String title;
  final String description;
  final bool done;
  final User processor;

  Task(this.id, this.title, this.description, this.done, this.processor);

  Task.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        description = json['description'],
        done = json['done'],
        processor = User.fromJson(json['processor']);
}
