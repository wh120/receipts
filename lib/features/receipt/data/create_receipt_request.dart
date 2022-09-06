class CreateReceiptRequest {
  String receiptNumber;
  int fromDepartmentId;
  int toDepartmentId;
  int mustApprovedByRoleId;
  int receiptTypeId;
  String description;
  List<ReceiptItem> items;

  CreateReceiptRequest(
      {this.receiptNumber,
        this.fromDepartmentId,
        this.toDepartmentId,
        this.mustApprovedByRoleId,
        this.receiptTypeId,
        this.description,
        this.items});

  CreateReceiptRequest.fromJson(Map<String, dynamic> json) {
    receiptNumber = json['receipt_number'];
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
    data['receipt_number'] = this.receiptNumber;
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
  double value;

  ReceiptItem({this.id, this.value});

  ReceiptItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
