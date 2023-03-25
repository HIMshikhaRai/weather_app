import 'package:flutter/material.dart';
import 'package:weather_report/api/result.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/repositories/weather_repository.dart';
import 'package:weather_report/utils/custom_date_utils.dart';
import 'package:weather_report/utils/status_enum.dart';

class WeatherViewModel extends ChangeNotifier {
  Status _status = Status.success;

  final WeatherRepository _weatherRepository = WeatherRepository();
  WeatherResponse? _weatherResponse;
  DataError? _dataError;
  List<ListElement> todayForecast = [];
  List<ListElement> _tomorrowForecast = [],
      _thirdForecast = [],
      _fourthForecast = [],
      _fifthForecast = [];
  Map<String, List<ListElement>>? allWeatherForecast;

  Future<void> getWeather(String city) async {
    _weatherResponse = null;
    if (status != Status.loading) status = Status.loading;
    var result = await _weatherRepository.getWeather(city);
    if (result.isSuccess()) {
      _weatherResponse = result.getValue();
      _calculateWeatherForecastDetail();
      status = Status.success;
    } else {
      _dataError = result.getError();
      status = Status.error;
    }
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  DataError? get dataError => _dataError;

  set dataError(DataError? value) {
    _dataError = value;
  }

  WeatherResponse? get weatherResponse => _weatherResponse;

  set weatherResponse(WeatherResponse? value) {
    _weatherResponse = value;
  }

  void _calculateWeatherForecastDetail() {
    todayForecast = weatherResponse?.list
            ?.where((element) =>
                CustomDateUtils().calculateDifference(element.dtTxt!) == 0)
            .toList() ??
        [];
    _tomorrowForecast = weatherResponse?.list
            ?.where((element) =>
                CustomDateUtils().calculateDifference(element.dtTxt!) == 1)
            .toList() ??
        [];
    _thirdForecast = weatherResponse?.list
            ?.where((element) =>
                CustomDateUtils().calculateDifference(element.dtTxt!) == 2)
            .toList() ??
        [];
    _fourthForecast = weatherResponse?.list
            ?.where((element) =>
                CustomDateUtils().calculateDifference(element.dtTxt!) == 3)
            .toList() ??
        [];
    _fifthForecast = weatherResponse?.list
            ?.where((element) =>
                CustomDateUtils().calculateDifference(element.dtTxt!) == 4)
            .toList() ??
        [];
    allWeatherForecast = {};
    allWeatherForecast?.addAll({"Tomorrow": _tomorrowForecast});
    allWeatherForecast?.addAll({
      CustomDateUtils().getDate(_thirdForecast.first.dtTxt ?? DateTime.now()):
          _thirdForecast
    });
    allWeatherForecast?.addAll({
      CustomDateUtils().getDate(_fourthForecast.first.dtTxt ?? DateTime.now()):
          _fourthForecast
    });
    allWeatherForecast?.addAll({
      CustomDateUtils().getDate(_fifthForecast.first.dtTxt ?? DateTime.now()):
          _fifthForecast
    });
  }
}
