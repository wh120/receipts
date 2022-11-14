import 'dart:convert';

class CreateReceiptRequest {

  int fromDepartmentId;
  int toDepartmentId;
  int mustApprovedByRoleId;
  int receiptTypeId;
  String description;
  List<ReceiptItem> items;

  CreateReceiptRequest(
      {
        this.fromDepartmentId,
        this.toDepartmentId,
        this.mustApprovedByRoleId,
        this.receiptTypeId,
        this.description,
        this.items});

  CreateReceiptRequest.fromJson(Map<String, dynamic> json) {

    fromDepartmentId = json['from_department_id'];
    toDepartmentId = json['to_department_id'];
    mustApprovedByRoleId = json['must_approved_by_role_id'];
    receiptTypeId = json['receipt_type_id'];
    description = json['description'];
    if (json['items'] != null) {
      items = new List<ReceiptItem>();
      json['items'].forEach((v) {
        items.add(new ReceiptItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['from_department_id'] = this.fromDepartmentId;
    data['to_department_id'] = this.toDepartmentId;
    data['must_approved_by_role_id'] = this.mustApprovedByRoleId;
    data['receipt_type_id'] = this.receiptTypeId;
    data['description'] = this.description;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceiptItem {
  int id;
  double value0;
  double value1;
  double value2;



  ReceiptItem({this.id, this.value0 , this.value1, this.value2});

  ReceiptItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value0 = json['value0'];
    value1 = json['value1'];
    value2 = json['value2'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value0'] = this.value0??0;
    data['value1'] = this.value1??0;
    data['value2'] = this.value2??0;

    return data;
  }
}
