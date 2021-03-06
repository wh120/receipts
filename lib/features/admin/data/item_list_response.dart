import 'package:flutter/material.dart';
import 'package:receipts/core/API/CoreModels/base_result_model.dart';

import 'item_category_list_response.dart';

class ItemListResponseModel extends BaseResultModel{
  List<Item> items;

  ItemListResponseModel({this.items});

  ItemListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
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

class Item extends BaseResultModel{
  int id;
  String code;
  String name;
  String description;
  String unit;
  int unitValue;
  TextEditingController controller = TextEditingController();
  bool isDefaultUnit;
  int itemCategoryId;
  String createdAt;
  String updatedAt;
  List<Unit> units;
  ItemCategory itemCategory;


  Item(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.unit,
        this.isDefaultUnit,
        this.itemCategoryId,
        this.createdAt,
        this.updatedAt,
        this.units,
        this.itemCategory});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    unitValue = 0;
    //isDefaultUnit = json['is_default_unit'];
    itemCategoryId = json['item_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unitValue = json['value'] != null ? new Value.fromJson(json['value']).value : 0;
    if (json['units'] != null) {
      units = new List<Unit>();
      json['units'].forEach((v) {
        units.add(new Unit.fromJson(v));
      });
    }
    itemCategory = json['item_category'] != null
        ? new ItemCategory.fromJson(json['item_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['value'] = this.unitValue;
    data['is_default_unit'] = this.isDefaultUnit;
    data['item_category_id'] = this.itemCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.units != null) {
      data['units'] = this.units.map((v) => v.toJson()).toList();
    }
    if (this.itemCategory != null) {
      data['item_category'] = this.itemCategory.toJson();
    }
    return data;
  }

  bool operator ==(o) => o is Item  && name == o.name;
}

class Unit {
  int id;
  String name;
  double value;
  TextEditingController controller = TextEditingController();
  int conversionFactor;
  int isDefault;
  int itemId;
  String createdAt;
  String updatedAt;

  Unit(
      {this.id,
        this.name,
        this.conversionFactor,
        this.isDefault,
        this.itemId,
        this.createdAt,
        this.updatedAt});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value=0;
    conversionFactor = json['conversion_factor']??1;
    isDefault = json['is_default'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['conversion_factor'] = this.conversionFactor;
    data['is_default'] = this.isDefault;
    data['item_id'] = this.itemId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Value {
  int receiptId;
  int itemId;
  int value;

  Value({this.receiptId, this.itemId, this.value});

  Value.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    itemId = json['item_id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['item_id'] = this.itemId;
    data['value'] = this.value;
    return data;
  }
}
