import 'dart:core';

import 'package:baby/User.dart';

class Love {
  final int id;
  final String content;
  final User user;

  Love(this.id, this.content, this.user);

  Love.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        content = json['content'],
        user = User.fromJson(json['user']);
}
