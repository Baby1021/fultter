import 'package:dio/dio.dart';

class Service {
  Dio http = new Dio();

  static final Service _instance = new Service._();

  static Service getInstance() {
    return _instance;
  }

  Service._() {
    http.options.baseUrl = 'http://39.108.227.137:3000';
    http.options.headers = {"Content-Type": "application/json"};
  }

  getLoves() async {}

  addLove(String content, String userId) async {
    Map body = {
      "love": {"content": content, "userId": userId}
    };

    // 请求
    var response = await http.post(
      "/api/v1/love",
      data: body,
    );

    return response.data.toString();
  }

  updateLove(int id, String content, String userId) async {
    var response = await http.put(
      "/api/v1/love",
      data: {
        "love": {"content": content, "userId": userId, "id": id}
      },
    );

    return response.data.toString();
  }

  deleteLove(int id) async {
    var response = await http.delete(
      "/api/v1/love",
      data: {"loveId": id},
    );
    return response.data.toString();
  }
}
