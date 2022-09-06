
 import 'package:receipts/core/API/CoreModels/empty_model.dart';
import '../../admin/data/item_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_list_response.dart';

import '../data/receipt_type_response.dart';
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Homepage/data/SliderListModel.dart';

class ReceiptRepository{

  static Future<BaseResultModel> getItems( ) async {
    return await RemoteDataSource.request<ItemListResponseModel>(
        converter: (json) => ItemListResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,

        url: ApiURLs.GET_ITEMS);

  }

  static Future<BaseResultModel> getReceiptTypes({DateTime dateTime = null}) async {

    var url =ApiURLs.CREATE_RECEIPT_TYPE;
    if(dateTime!= null ) {
      DateTime date = new DateTime(dateTime.year, dateTime.month, dateTime.day);
      url=url.replaceFirst('{date}', date.toString());
    } else url=url.replaceFirst('/{date}', 'date.toString()');

    return await RemoteDataSource.request<ReceiptTypeResponse>(
        converter: (json) => ReceiptTypeResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,

        url: url =url);

  }

  static Future<BaseResultModel> geReceipts( data) async {
    return await RemoteDataSource.request<ReceiptListResponse>(
        converter: (json) => ReceiptListResponse.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: data.toJson(),
        withAuthentication: true,
        url: ApiURLs.GET_RECEIPTS);

  }

  static Future<BaseResultModel> createReceipt(data ) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: data.toJson(),
        url: ApiURLs.CREATE_RECEIPT);

  }

  static Future<BaseResultModel> getMyApprovalReceipts( data) async {
    return await RemoteDataSource.request<ReceiptListResponse>(
        converter: (json) => ReceiptListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: data.toJson(),
        url: ApiURLs.GET_MY_APPROVAL_RECEIPTS);

  }
  static Future<BaseResultModel> getMyReceipts( data) async {
    return await RemoteDataSource.request<ReceiptListResponse>(
        converter: (json) => ReceiptListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: data.toJson(),
        url: ApiURLs.GET_MY_RECEIPTS);

  }

  static Future<BaseResultModel> approveReceipt( receiptId) async {
    var res = await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        url: ApiURLs.APPROVE_RECEIPT.replaceFirst('{id}', receiptId.toString()));

    return res;

  }

  static Future<BaseResultModel> transformItems( int department_id , int transformation_id , int count) async {
    var res = await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        url: ApiURLs.TRANSFORM,
        data: {
          "department_id": department_id,
          "transformation_id": transformation_id,
          "count":count
        }
    );

    return res;

  }


}