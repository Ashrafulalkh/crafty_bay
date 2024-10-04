import 'dart:convert';

import 'package:crafty_bay/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;

  NetworkCaller({required this.logger});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      requestLog(url, {}, {}, '');
      final Response response = await get(
        uri,
        headers: {'token': ''},
      );
      if (response.statusCode == 200) {
        responseLog(url, response.statusCode, response.body, response.headers, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeBody,
        );
      } else {
        responseLog(url, response.statusCode, response.body, response.headers, false);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      responseLog(url, -1,null, {}, false, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      requestLog(url, {}, body ?? {} , '');
      final Response response = await post(
        uri,
        headers: {
          'token': '',
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        responseLog(url, response.statusCode, response.body, response.headers, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeBody,
        );
      } else {
        responseLog(url, response.statusCode, response.body, response.headers, false);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void requestLog(String url,Map<String, dynamic> params,Map<String, dynamic> body, String token) {
    logger.i('''
    Url : $url,
    Params : $params,
    Body : $body,
    Token : $token,
    ''');
  }

  void responseLog(String url,int statusCode,dynamic responsebody, Map<String,dynamic> headers,bool isSuccess, [dynamic error]) {
    String message = '''
    Url : $url,
    StatusCode : $statusCode,
    ResponseBody : $responsebody,
    Headers : $headers,
    Eroor : $error,
    ''';
    if(isSuccess) {
      logger.i(message);
    }else {
      logger.e(message);
    }
  }

}
