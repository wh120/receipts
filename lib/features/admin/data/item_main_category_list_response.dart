import 'package:receipts/core/API/CoreModels/base_result_model.dart';

import 'department_list_response.dart';

class ItemMainCategoryListResponse extends BaseResultModel{
  List<ItemMainCategory> items;

  ItemMainCategoryListResponse({this.items});

  ItemMainCategoryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<ItemMainCategory>();
      json['items'].forEach((v) {
        items.add(new ItemMainCategory.fromJson(v));
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

class ItemMainCategory extends BaseResultModel {
  int id;
  String code;
  String name;
  int departmentId;
  Department department;

  ItemMainCategory({this.id, this.code, this.name, this.departmentId, this.department});

  ItemMainCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    departmentId = json['department_id'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['department_id'] = this.departmentId;
    if (this.department != null) {
      data['department'] = this.department.toJson();
    }
    return data;
  }
}



