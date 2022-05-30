import 'package:receipts/core/API/CoreModels/base_result_model.dart';
import 'package:receipts/features/admin/data/role_list_response.dart';

import 'item_list_response.dart';

class DepartmentListResponse extends BaseResultModel{
  List<Department> items;
  List<Department> myDepartment;

  DepartmentListResponse({this.items});

  DepartmentListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Department>();
      json['items'].forEach((v) {
        items.add(new Department.fromJson(v));
      });

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Department extends BaseResultModel {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  List<Role> roles;
  List<Item> items;

  Department({this.id, this.name, this.createdAt, this.updatedAt, this.roles , this.items });

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = new List<Role>();
      json['roles'].forEach((v) {
        roles.add(new Role.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
  bool operator ==(o) => o is Department  && id == o.id;
}


