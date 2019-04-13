import 'package:dio/dio.dart';
import 'package:flutter_movie_playground/utils/Constants.dart';

Dio getDio(String baseUrl) {
  int maxCharactersPerLine = 2000;
  var dio = Dio()
    ..options = BaseOptions(
        baseUrl: baseUrl, connectTimeout: 5000, receiveTimeout: 5000,queryParameters: {
      "api_key" : ApiKeys.TMDB_API_KEY,
      "language" : "en-US"
    })
    ..interceptors.add(InterceptorsWrapper(onRequest: (options) {
      print("--> ${options.method} ${options.path}");
      print("Content type: ${options.contentType}");
      print("<-- END HTTP");
    }, onResponse: (response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    }, onError: (error) {
      String errorDescription = "";
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.CANCEL:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            errorDescription = "Connection timeout with API server";
            break;
          case DioErrorType.DEFAULT:
            errorDescription =
                "Connection to API server failed due to internet connection";
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioErrorType.RESPONSE:
            errorDescription =
                "Received invalid status code: ${error.response.statusCode}";
            break;
          case DioErrorType.SEND_TIMEOUT:
            errorDescription =
                "Connection SEND_TIMEOUT : ${error.response.statusCode}";
            break;
        }
      } else {
        errorDescription = "Unexpected error occured";
      }
      return errorDescription;
    }));

  return dio;
}
