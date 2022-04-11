
import 'package:receipts/core/API/CoreModels/empty_model.dart';

import '../data/department_list_response.dart';
import '../data/role_list_response.dart';
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Homepage/data/SliderListModel.dart';

class AdminRepository{



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