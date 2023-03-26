import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_report/api/api_call_wrapper.dart';
import 'package:weather_report/api/result.dart';
import 'package:weather_report/models/weather.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/utils/string_constants.dart';

class WeatherRepository {
  WeatherRepository._();

  static final WeatherRepository _instance = WeatherRepository._();

  factory WeatherRepository() {
    return _instance;
  }

  final ApiCallWrapper _apiCallWrapper = ApiCallWrapper();

  Future<Result> getWeather(String city) async {
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';
    final Result result = await _apiCallWrapper.makeRequest(url: url);

    if (result.isSuccess()) {
      final data =
          await compute(weatherResponseFromJson, jsonEncode(result.getValue()));
      return Result.success(data);
    } else {
      return Result.error(result.getError());
    }
  }

  Future<Result> getDefaultWeather() async {
    const url =
        'https://api.openweathermap.org/data/2.5/weather?lat=27.7657743&lon=85.3591614&appid=$apiKey';
    final Result result = await _apiCallWrapper.makeRequest(url: url);

    if (result.isSuccess()) {
      final data =
          await compute(weatherFromJson, jsonEncode(result.getValue()));
      return Result.success(data);
    } else {
      return Result.error(result.getError());
    }
  }
}
