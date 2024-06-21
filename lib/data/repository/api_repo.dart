import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recommend_book_app/view/widgets/extention/object_extension.dart';

import '../db/shared-preferences.dart';
import 'api_exception.dart';

class ApiRepo {
  /*
***************************** TimeOut ***********************************
    sendTimeout: const Duration(milliseconds:300000),
    receiveTimeout: const Duration(milliseconds:300000),
     connectTimeout: const Duration(milliseconds: 300000),

************************ For Error Response *****************************
    receiveDataWhenStatusError: true,

***************************** Headers ***********************************
    HttpHeaders.authorizationHeader : "Bearer $token"
    HttpHeaders.contentTypeHeader : "application/json"
    HttpHeaders.acceptEncodingHeader: "*"
*/

  // Dio Initialization
  Dio dio = Dio();

  // Set BaseOption for Api Request
  Future<void> dioOption({required Map<String, dynamic> headers}) async {
    try {
      dio.options = BaseOptions(
          connectTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          receiveDataWhenStatusError: true,
          headers: headers);
    } catch (e) {
      "Error $e";
    }
  }

  // ======================================================================
  //POST REQUEST
  // Getting four parameters
  // context => use for loader and navigation
  // screen =>  router name
  // url => url of the api
  // Map data => json data for api

  signInRequest(BuildContext navigatorContext, String screen, String url,
      Map<String, dynamic> data,
      {String? bearerToken}) async {
    // debugPrint("Post Request=====================>>> \n URl : $url \n Sending data : $data");

    // Get the bearer token which we have stored in sharedPreferences before
    // String? bearerToken = await LocalDb.getBearerToken;
    // debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // Convert json (Map) to form data
    var formData = FormData.fromMap(data);

    // calling dioOption method to set base options
    // await dioOption(headers: {
    //   HttpHeaders.contentTypeHeader: "application/json",
    //   HttpHeaders.acceptHeader: "application/json",
    //   'x-api-key': 'CODEX@123', // Adding the x-api-key header
    // });

    try {
      // Calling Api
      final response = await dio.post(url,
          data: formData,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.acceptHeader: "application/json",
            'x-api-key': 'CODEX@123', // Adding the x-api-key header
          }));

      // return response back
      return response;
    } on DioException catch (exception) {
      // if(exception.response!.statusCode==422) {
      //   // Fluttertoast.showToast(msg: exception.response!.data['message']);
      // }
      // else if(exception.response!.statusCode==401) {
      //   // print("Response code: ${exception.response!.statusCode}");
      //   // Fluttertoast.showToast(msg: exception.response!.data['message']);
      // }
      // else if(exception.response!.statusCode==403) {
      //   // Fluttertoast.showToast(msg: exception.response!.data['error']);
      // }
      // else if(exception.type == DioErrorType.receiveTimeout) {
      //   // Fluttertoast.showToast(msg: 'Request timed out. You can retry or use fallback response.');
      // }else if(exception.error is SocketException) {
      //   // Fluttertoast.showToast(msg: 'Please check your internet connection.');
      // }
      // else {
      //   // Fluttertoast.showToast(msg: '${exception.response!.data['message']}');
      // }
      // If Exception Occur calling dioError method to Handle the Exception
      print(exception);
      return dioError(exception, navigatorContext, screen);
    }
  }

  postRequest(BuildContext navigatorContext, String screen, String url,
      Map<String, dynamic> data,
 ) async {
    var formData = FormData.fromMap(data);

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    });

    try {
      // Calling Api
      final response = await dio.post(url, data: formData);

      // return response back
      return response;
    } on DioError catch (exception) {
      if (exception.response!.statusCode == 422) {
        Fluttertoast.showToast(msg: exception.response!.data['message']);
      } else if (exception.response!.statusCode == 401) {
        print("Response code: ${exception.response!.statusCode}");
        Fluttertoast.showToast(msg: exception.response!.data['message']);
      } else if (exception.response!.statusCode == 403) {
        Fluttertoast.showToast(msg: exception.response!.data['error']);
      } else if (exception.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(
            msg: 'Request timed out. You can retry or use fallback response.');
      } else if (exception.error is SocketException) {
        Fluttertoast.showToast(msg: 'Please check your internet connection.');
      } else {
        Fluttertoast.showToast(msg: '${exception.response!.data['message']}');
      }
      // If Exception Occur calling dioError method to Handle the Exception
      print(exception);
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // GET REQUEST
  getRequest(BuildContext navigatorContext, String screen, String url,
      {String? bearerToken}) async {
    // calling dioOption method to set base options
    await dioOption(headers: {
      //   HttpHeaders.authorizationHeader: "Bearer $bearerToken",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    });

    try {
      // Calling Api
      final response = await dio.get(url);

      // return response back
      return response;
    } on DioError catch (exception) {
      if (exception.response!.statusCode == 422) {
        Fluttertoast.showToast(msg: exception.response!.data['message']);
      } else if (exception.response!.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 401");
      } else if (exception.response!.statusCode == 405) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 405");
      } else if (exception.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(
            msg: 'Request timed out. You can retry or use fallback response.');
      } else if (exception.error is SocketException) {
        Fluttertoast.showToast(msg: 'Please check your internet connection.');
      } else {
        Fluttertoast.showToast(msg: '${exception.response!.data['message']}');
      }
      //If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // PUT REQUEST
  putRequest(BuildContext navigatorContext, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint(
        "Put Request=====================>>> \n URl : $url \n Sending data : $data");

    // Get the bearer token which we have stored in sharedPreferences before
    String? bearerToken = await LocalDb.getBearerToken;
    debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.authorizationHeader: "Bearer $bearerToken",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptEncodingHeader: "*"
    });

    try {
      // Calling Api
      final response = await dio.put(url, queryParameters: data);
      // return response back
      return response;
    } on DioError catch (exception) {
      // If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // DELETE REQUEST
  deleteRequest(BuildContext navigatorContext, String screen, String url,
      Map<String, dynamic> data) async {
    debugPrint(
        "Delete Request=====================>>> \n URl : $url \n Sending data : $data");

    // Get the bearer token which we have stored in sharedPreferences before
    String? bearerToken = await LocalDb.getBearerToken;
    debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.authorizationHeader: "Bearer $bearerToken",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptEncodingHeader: "*"
    });

    try {
      // Calling Api
      final response = await dio.delete(url, queryParameters: data);

      // return response back
      return response;
    } on DioError catch (exception) {
      // If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // POST MULTIPART REQUEST
  //POST MULTIPART REQUEST
  //When we are uploading Media  like (image,file,video,audio,etc)
  //then we are using multipart request

  multipartRequest(BuildContext navigatorContext, String screen, String url,
      Map<String, dynamic> data,
      {String? bearerToken}) async {
    debugPrint(
        "Multipart Request=====================>>> \n URl : $url \n Sending data : $data");

    // Get the bearer token which we have stored in sharedPreferences before
    // String? bearerToken = await LocalDb.getBearerToken;
    debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // Convert json (Map) to form data
    var formData = FormData.fromMap(data);

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      'x-api-key': 'CODEX@123',
    });

    try {
      // Calling Api
      final response = await dio.post(url, data: formData);

      // return response back
      return response;
    } on DioError catch (exception) {
      if (exception.response!.statusCode == 422) {
        Fluttertoast.showToast(msg: exception.response!.data['message']);
      } else if (exception.response!.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 401");
      } else if (exception.response!.statusCode == 405) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 405");
      } else if (exception.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(
            msg: 'Request timed out. You can retry or use fallback response.');
      } else if (exception.error is SocketException) {
        Fluttertoast.showToast(msg: 'Please check your internet connection.');
      } else {
        Fluttertoast.showToast(msg: '${exception.response!.data['message']}');
      }
      // If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  multipartRequestBanner(BuildContext navigatorContext, String screen,
      String url, Map<String, dynamic> data,
      {String? bearerToken}) async {
    debugPrint(
        "Multipart Request=====================>>> \n URl : $url \n Sending data : $data");

    // Get the bearer token which we have stored in sharedPreferences before
    // String? bearerToken = await LocalDb.getBearerToken;
    debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // Convert json (Map) to form data
    var formData = FormData.fromMap(data);

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      'x-api-key': 'CODEX@123',
    });

    try {
      // Calling Api
      final response = await dio.post(url, data: formData);

      // return response back
      return response;
    } on DioError catch (exception) {
      if (exception.response!.statusCode == 422) {
        Fluttertoast.showToast(msg: exception.response!.data['message']);
      } else if (exception.response!.statusCode == 401) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 401");
      } else if (exception.response!.statusCode == 405) {
        Fluttertoast.showToast(
            msg: "The request return invalid response code of 405");
      } else if (exception.type == DioErrorType.receiveTimeout) {
        Fluttertoast.showToast(
            msg: 'Request timed out. You can retry or use fallback response.');
      } else if (exception.error is SocketException) {
        Fluttertoast.showToast(msg: 'Please check your internet connection.');
      } else {
        Fluttertoast.showToast(msg: '${exception.response!.data['message']}');
      }
      // If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // DOWNLOAD REQUEST
  downloadRequest(BuildContext navigatorContext, String screen, String url,
      String savePath) async {
    debugPrint("Download Request=====================>>> \n URl : $url");

    // Get the bearer token which we have stored in sharedPreferences before
    String? bearerToken = await LocalDb.getBearerToken;
    debugPrint("Bearer token=====================>>>\n Token:$bearerToken");

    // calling dioOption method to set base options
    await dioOption(headers: {
      HttpHeaders.authorizationHeader: "Bearer $bearerToken",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptEncodingHeader: "*"
    });

    int? percentage;
    try {
      // Calling Api
      final response = await Dio().download(
        url,
        savePath,
        onReceiveProgress: (rec, total) {
          // set progress to percentage variable
          percentage = ((rec / total) * 100).floor();
          "Percentage : $percentage";
        },
      );

      // return response back
      return response;
    } on DioError catch (exception) {
      // If Exception Occur calling dioError method to Handle the Exception
      return dioError(exception, navigatorContext, screen);
    }
  }

  // ======================================================================
  // Error Handling

  Future<dynamic> dioError(
      DioError exception, BuildContext navigatorContext, String screen) async {
    // if response is 400 OR 401 then we will return back API response otherwise we will navigate to  Error Screen
    if (exception.type == DioErrorType.badResponse) {
      if (exception.response!.statusCode == 400 ||
          exception.response!.statusCode == 401) {
        return exception.response;
      }
    }
    await Future.delayed(Duration.zero, () {
      apiException(exception, navigatorContext, screen);
    });
  }

  // For GetRequest :

  getBookRequest(
    BuildContext navigatorContext,
    String screen,
    String url,
  ) async {
    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          },
            responseType: ResponseType.json,
          ));

      return response;
    } on DioException catch (exception) {
      print(exception);
      return dioError(exception, navigatorContext, screen);
    }
  }
}
