import '../../utils/Navigation/Navigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../CoreModels/base_result_model.dart';
import '../http/api_provider.dart';
import '../errors/unauthorized_error.dart';

 class RemoteDataSource {
   
  static Future<BaseResultModel> request<Response extends BaseResultModel>({
    @required Response Function(Map<String, dynamic> json) converter,
    @required String method,
    @required String url,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    Map<String,String> files,
    bool withAuthentication = true,
    CancelToken cancelToken,
    bool isLongTime = false
  }) async {

    assert(converter != null);
    assert(method != null);
    assert(url != null);

    Map<String, String> headers= {
      HEADER_CONTENT_TYPE : "application/json",
      HEADER_ACCEPT : "application/json",
    };

    /// Get the language.
    String lang = AppSharedPreferences.lang;
    headers.putIfAbsent(HEADER_LANGUAGE, () => lang);


    if (withAuthentication) {
      if (AppSharedPreferences.hasAccessToken)
        headers.putIfAbsent(HEADER_AUTH, () => ('bearer ${AppSharedPreferences.accessToken}'));
      else{
       logOut();
        return UnauthorizedError();
      }


    }
    //ToDo remove prints
    print('HEADERS  $headers');

    print('--------------------  Start Request Body  --------------------'
        ' \n The HttpMethod & URL are : [$method: $url]');
    print('The sended Object Request is : $data');
    print('The headers is : $headers');
    print('The queryParameters is : $queryParameters \n '
        '--------------------  End Request Body  --------------------'
        ' \n');

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url:   url,
      converter: converter,
      headers: headers,
      queryParameters: queryParameters ?? {},
      data: data??{},
      files: files,
      isLongTime:isLongTime,
      cancelToken: cancelToken,
    );

    if (response.success) {
      return response.result;
    }
    else
    {
      if(response.serverError != null){

        if(response.error is UnauthorizedError){

          logOut();

        }
        return response.serverError;
      }

      else
      return response.error;
    }
  }
  static logOut(){
    AppSharedPreferences.clearForLogOut();

    // RouteSettings v =  ModalRoute.of(MyApp.navigatorKey.currentContext).settings;
    //   print(v);

   // print(MyApp.navigatorKey.currentState);
    Navigation.goToLogin();
  }


 }
