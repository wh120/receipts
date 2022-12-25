import 'package:receipts/features/admin/data/item_list_response.dart';

import '../../../core/API/CoreModels/base_result_model.dart';

class TransformationList extends BaseResultModel{
  List<Transformation> items;

  TransformationList({this.items});

  TransformationList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Transformation>();
      json['items'].forEach((v) {
        items.add(new Transformation.fromJson(v));
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

class Transformation   {
  int id;
  String name;
  String description;
  bool isActive;
  String createdAt;
  String updatedAt;
  List<Item> inputs;
  List<Item> outputs;

  Transformation(
      {this.id,
        this.name,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.inputs,
        this.outputs});

  Transformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['inputs'] != null) {
      inputs = new List<Item>();
      json['inputs'].forEach((v) {
        inputs.add(new Item.fromJson(v));
      });
    }
    if (json['outputs'] != null) {
      outputs = new List<Item>();
      json['outputs'].forEach((v) {
        outputs.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.inputs != null) {
      data['inputs'] = this.inputs.map((v) => v.toJson()).toList();
    }
    if (this.outputs != null) {
      data['outputs'] = this.outputs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

