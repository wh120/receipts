
 import 'package:receipts/core/API/CoreModels/empty_model.dart';
import 'package:receipts/features/receipt/data/item_list_response.dart';

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

  static Future<BaseResultModel> createReceipt(data ) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: data.toJson(),
        url: ApiURLs.CREATE_RECEIPT);

  }



}