import 'package:receipts/core/API/CoreModels/base_result_model.dart';

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

class Item {
  int id;
  String code;
  String name;
  String description;
  String unit;
  int unitValue;
  String isDefaultUnit;
  int itemCategoryId;
  String createdAt;
  String updatedAt;
  List<Unit> units;

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
        this.units});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    unit = json['unit'];
    unitValue = 0;
    isDefaultUnit = json['is_default_unit'];
    itemCategoryId = json['item_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['units'] != null) {
      units = new List<Unit>();
      json['units'].forEach((v) {
        units.add(new Unit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['is_default_unit'] = this.isDefaultUnit;
    data['item_category_id'] = this.itemCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.units != null) {
      data['units'] = this.units.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool operator ==(o) => o is Item  && name == o.name;
}

class Unit {
  int id;
  String name;
  double value;
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
    conversionFactor = json['conversion_factor'];
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
