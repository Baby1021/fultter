import 'package:dio/dio.dart';

class Service {
  Dio http = new Dio();

  void init() {
    http.options.baseUrl = 'http://39.108.227.137:3000/api';
  }


}
