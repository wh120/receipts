import 'package:receipts/core/API/CoreModels/base_result_model.dart';

import '../../receipt/data/receipt_list_response.dart';
import 'department_list_response.dart';

class RoleListResponse extends BaseResultModel{
  List<Role> items;

  RoleListResponse({this.items});

  RoleListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Role>();
      json['items'].forEach((v) {
        items.add(new Role.fromJson(v));
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

class Role extends BaseResultModel{
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  int departmentId;
  Department department;

  Role(
      {this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.departmentId,
        this.department});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    departmentId = json['department_id'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['department_id'] = this.departmentId;
    if (this.department != null) {
      data['department'] = this.department.toJson();
    }
    return data;
  }
  bool operator ==(o) => o is Role  && id == o.id;
}


