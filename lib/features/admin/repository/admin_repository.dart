
import 'package:receipts/core/API/CoreModels/empty_model.dart';

import '../data/department_list_response.dart';
import '../data/item_category_list_response.dart';
import '../data/item_list_response.dart';
import '../data/item_main_category_list_response.dart';
import '../data/role_list_response.dart';
import '../data/transformation_list_response.dart';
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Homepage/data/SliderListModel.dart';

class AdminRepository{


  static Future<BaseResultModel> getItems( ) async {
    return await RemoteDataSource.request<ItemListResponseModel>(
        converter: (json) => ItemListResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_ITEMS);

  }
  static Future<BaseResultModel> createItem(Item item ) async {
    return await RemoteDataSource.request<Item>(
        converter: (json) => Item.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: item.toJson(),

        url: ApiURLs.GET_ITEMS);

  }

  static Future<BaseResultModel> deleteItem(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        url: ApiURLs.GET_ITEM.replaceFirst('{id}', id.toString()));

  }


  static Future<BaseResultModel> getTransformations( ) async {
    return await RemoteDataSource.request<TransformationList>(
        converter: (json) => TransformationList.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_TRANSFORMATIONS);

  }

  static Future<BaseResultModel> getItemCategories( ) async {
    return await RemoteDataSource.request<ItemCategoryListResponse>(
        converter: (json) => ItemCategoryListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_ITEM_CATEGORIES);

  }
  static Future<BaseResultModel> createItemCategory(ItemCategory category ) async {
    return await RemoteDataSource.request<ItemCategory>(
        converter: (json) => ItemCategory.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: category.toJson(),

        url: ApiURLs.GET_ITEM_CATEGORIES);

  }

  static Future<BaseResultModel> deleteItemCategory(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        url: ApiURLs.GET_ITEM_CATEGORY.replaceFirst('{id}', id.toString()));

  }


  static Future<BaseResultModel> getItemMainCategories( ) async {
    return await RemoteDataSource.request<ItemMainCategoryListResponse>(
        converter: (json) => ItemMainCategoryListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_ITEM_MAIN_CATEGORIES);

  }
  static Future<BaseResultModel> createItemMainCategory(ItemMainCategory category ) async {
    return await RemoteDataSource.request<ItemMainCategory>(
        converter: (json) => ItemMainCategory.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: category.toJson(),

        url: ApiURLs.GET_ITEM_MAIN_CATEGORIES);

  }

  static Future<BaseResultModel> deleteItemMainCategory(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        url: ApiURLs.GET_ITEM_MAIN_CATEGORY.replaceFirst('{id}', id.toString()));

  }


  static Future<BaseResultModel> getRoles( ) async {
    return await RemoteDataSource.request<RoleListResponse>(
        converter: (json) => RoleListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_ROLES);

  }
  static Future<BaseResultModel> createRole(Role role ) async {
    return await RemoteDataSource.request<Role>(
        converter: (json) => Role.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: role.toJson(),

        url: ApiURLs.GET_ROLES);

  }
  static Future<BaseResultModel> deleteRole(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        url: ApiURLs.GET_ROLE.replaceFirst('{id}', id.toString()));

  }

  static Future<BaseResultModel> getDepartments( ) async {

    return await RemoteDataSource.request<DepartmentListResponse>(
        converter: (json) => DepartmentListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,

        url: ApiURLs.GET_DEPARTMENTS);

  }

  static Future<BaseResultModel> getMyDepartments( ) async {

    return await RemoteDataSource.request<DepartmentListResponse>(
        converter: (json) => DepartmentListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,

        url: ApiURLs.GET_MY_DEPARTMENTS);

  }
  static Future<BaseResultModel> createDepartment(Department department ) async {
    return await RemoteDataSource.request<Department>(
        converter: (json) => Department.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: department.toJson(),

        url: ApiURLs.GET_DEPARTMENTS);

  }

  static Future<BaseResultModel> deleteDepartment(int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        url: ApiURLs.GET_DEPARTMENT.replaceFirst('{id}', id.toString()));

  }


}