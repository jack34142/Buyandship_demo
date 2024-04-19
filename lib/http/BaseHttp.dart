import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseHttp {
  final dio = Dio();

  String get baseUrl;

  BaseHttp(){
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = Duration(seconds: 60);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          debugPrint("|- (${options.method}) ${options.uri.toString()}");
          options.headers.forEach((key, value) {
            debugPrint("|- $key: $value");
          });
          debugPrint("|- data: ");
          if(options.data is Map){
            (options.data as Map<String, dynamic>).forEach((key, value) {
              debugPrint("|- $key: $value");
            });
          }
          options.queryParameters.forEach((key, value) {
            debugPrint("|- $key: $value");
          });
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          debugPrint("|- Response: ${response.realUri.toString()}");
          response.headers.forEach((name, values) {
            debugPrint("|- $name: ${values.join(', ')}");
          });
          debugPrint("|- data: ${response.data.toString()}");
          if( response.data is String ){
            try{
              response.data = jsonDecode(response.data);
            }catch(e){}
          }
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(error);
        },
      ),
    );
  }
}