import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio= Dio(
        BaseOptions(
          baseUrl: 'http://api.weatherapi.com/',
          receiveDataWhenStatusError: true,

        )

    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async
  {
    dio.options.headers={
      'Content-Type':'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }



}