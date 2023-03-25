import 'package:dio/dio.dart';
import 'package:weather_report/api/dio_http.dart';
import 'package:weather_report/api/i_http.dart';
import 'package:weather_report/api/result.dart';

class ApiCallWrapper {
  late IHttp _iHttp;

  ApiCallWrapper._();

  static final ApiCallWrapper _instance = ApiCallWrapper._();

  factory ApiCallWrapper() {
    _instance._iHttp = DioHttp();
    return _instance;
  }

  Future<Result> makeRequest({String? url}) async {
    try {
      Response response = await _iHttp.get(url!);
      return Result.success(response.data);
    } catch (error) {
      error as DioError;
      return Result.error(DataError(error.response?.statusMessage ?? "Something went wrong",
          error.response?.statusCode ?? 0));
    }
  }
}
