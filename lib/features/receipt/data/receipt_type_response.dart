import 'package:receipts/core/API/CoreModels/base_result_model.dart';

class ReceiptTypeResponse extends BaseResultModel{
  List<Items> items;

  ReceiptTypeResponse({this.items});

  ReceiptTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
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

class Items {
  int id;
  String name;
  int receiptsCount;

  Items({this.id, this.name, this.receiptsCount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    receiptsCount = json['receipts_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['receipts_count'] = this.receiptsCount;
    return data;
  }
}
