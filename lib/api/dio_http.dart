import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/api/i_http.dart';

class DioHttp extends IHttp{
  late Dio dio;

  DioHttp._();
  static final DioHttp _instance = DioHttp._();

  factory DioHttp() {
    _instance.dio = Dio();
    return _instance;
  }

  @override
  get(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    return dio.get(url);
  }
}