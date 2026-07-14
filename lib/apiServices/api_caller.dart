import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {
 static final Logger _logger = Logger();

 static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri);
      _logResponse(url, response);

      print(response.statusCode);
      print(response.body);

      final int statusCode = response.statusCode;
      if(response.statusCode == 200){
        //Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData,
        );

      } else {
        //Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMassage: e.toString(),
      );
    }
  }

 static Future<ApiResponse> postRequest({required String url, Map<String, dynamic>? body } ) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await post(uri,
          body: jsonEncode(body),
        headers: {'Content-Type': 'application/json',
        }
      );
      _logResponse(url, response);

      print(response.statusCode);
      print(response.body);

      final int statusCode = response.statusCode;
      if(response.statusCode == 200){
        //Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData,
        );

      } else {
        //Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMassage: e.toString(),
      );
    }
  }

  static void _logRequest(String url){
    _logger.i('URL => $url');
  }
  static void _logResponse(String url, Response response) {
    _logger.i('URL => $url\n'
    'Status Code: ${response.statusCode}\n'
    'Body; ${response.body}');
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMassage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMassage = 'Something went wrong',
  });
}
