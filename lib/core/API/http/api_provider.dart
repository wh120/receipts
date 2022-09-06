import 'dart:io';
import 'dart:convert';
import '/core/API/errors/custom_error.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import '../CoreModels/base_response_model.dart';
import '../CoreModels/base_result_model.dart';
import '../errors/internal_server_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/bad_request_error.dart';
import '../errors/not_found_error.dart';
import '../errors/unknown_error.dart';
import '../errors/base_error.dart';
import '../errors/http_error.dart';
import '../errors/net_error.dart';

import '../../constants/constants.dart';
import '../errors/cancel_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import 'http_method.dart';

 class ApiProvider {

  static Future<BaseResponseModel> sendObjectRequest<T extends BaseResultModel>({
    @required T Function(Map<String, dynamic>) converter,
    @required String method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    Map<String,String> files,
    CancelToken cancelToken,
    bool isLongTime = false
  }) async {
    assert(method != null);
    assert(url != null);




    if(files != null)
    {
      headers.remove(HEADER_CONTENT_TYPE);
      if(data == null)
        data = Map();

      await Future.forEach(files.entries, (MapEntry entry) async {
        if(entry.value != null)
        data.addAll({
          entry.key: await MultipartFile.fromFile(entry.value)
        });
      });

    }
    try {

      var baseOptions =  BaseOptions(
        connectTimeout: isLongTime? 60 *1000 : 15 *1000,
      );

      Options requestOptions =Options(
        headers: headers,
        method: method ,
        contentType: Headers.jsonContentType,
        sendTimeout: 4000,
      );

      Dio dio = new Dio(baseOptions);
  //    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

      var options;
      if(Platform.operatingSystem != 'windows' && method == HttpMethod.GET){
        dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);

        options=buildCacheOptions(Duration(days: 7),maxStale: Duration(days: 14),options: requestOptions,forceRefresh: true);

      }
      else options = requestOptions;


      Response response;
      response = await dio.request(
           url,
        queryParameters: queryParameters,
        options: options,
     //   cancelToken: cancelToken,
        data: files!= null? FormData.fromMap(data):data
      );
      if (null != response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE)) {
        // data come from cache
      } else {
        // data come from net
      }
      // Get the decoded json
      var decodedJson;

      if (response.data is String )
       {
         if(response.data.length ==0)
           decodedJson={"":""};
         else
           decodedJson = json.decode(response.data);
       }
      else
        decodedJson = response.data;

      print(decodedJson);


      return BaseResponseModel.fromJson(json: decodedJson,fromJson: converter);
    }

    // Handling errors
    on DioError catch (e , s) {
      print('catch DioError ');
      print(e);

      print('Stacktrace DioError ');
      print(s);
     var error = _handleDioError(e);
      var json ;
      print('DioErrorDioErrorDioError $error');
      if(e.response!=null )
        if(e.response.data!=null)
          if(!(e.response.data is String))
           {

             json =e.response.data;
             print(json);
           }

      return BaseResponseModel.fromJson(json: json,error: error);
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return BaseResponseModel.fromJson(error: SocketError());
    }
    catch(e , stacktrace) {
      print(e);
      print(stacktrace);
      return BaseResponseModel.fromJson(error: CustomError(message: 'parse error'));
    }
  }


  static BaseError _handleDioError(DioError error) {
    print('error.type = ${(error.type) }');
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.response) {
        switch (error.response.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else
      return UnknownError();
  }
}
