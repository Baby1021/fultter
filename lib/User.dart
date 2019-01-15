class User {
  final String userId;
  String name;
  final String avatar;

  User.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        name = json['name'],
        avatar = json['avatar'];
}
