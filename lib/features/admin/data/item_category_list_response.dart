import 'package:receipts/core/API/CoreModels/base_result_model.dart';

import 'item_main_category_list_response.dart';

class ItemCategoryListResponse extends BaseResultModel{
  List<ItemCategory> items;

  ItemCategoryListResponse({this.items});

  ItemCategoryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<ItemCategory>();
      json['items'].forEach((v) {
        items.add(new ItemCategory.fromJson(v));
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

class ItemCategory extends BaseResultModel{
  int id;
  String code;
  String name;
  int itemMainCategoryId;
  ItemMainCategory itemMainCategory;

  ItemCategory(
      {this.id,
        this.code,
        this.name,
        this.itemMainCategoryId,
        this.itemMainCategory});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    itemMainCategoryId = json['item_main_category_id'];
    itemMainCategory = json['item_main_category'] != null
        ? new ItemMainCategory.fromJson(json['item_main_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['item_main_category_id'] = this.itemMainCategoryId;
    if (this.itemMainCategory != null) {
      data['item_main_category'] = this.itemMainCategory.toJson();
    }
    return data;
  }
}


