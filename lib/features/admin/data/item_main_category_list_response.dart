import 'package:receipts/core/API/CoreModels/base_result_model.dart';

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

class ItemMainCategory extends BaseResultModel{
  int id;
  String code;
  String name;

  ItemMainCategory({this.id, this.code, this.name});

  ItemMainCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
