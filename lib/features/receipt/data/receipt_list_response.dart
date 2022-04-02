import 'package:receipts/features/profile/data/profile_response.dart';

import '../../admin/data/role_list_response.dart';
import 'item_list_response.dart';

class ReceiptListResponse {
  List<Receipt> items;

  ReceiptListResponse({this.items});

  ReceiptListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Receipt>();
      json['items'].forEach((v) {
        items.add(new Receipt.fromJson(v));
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

class Receipt {
  int id;
  String receiptNumber;
  int createdByUserId;
  int acceptedByUserId;
  int mustApprovedByRoleId;
  int receiptTypeId;
  String description;
  String acceptedAt;
  String createdAt;
  String updatedAt;
  List<Item> items;
  Role mustApprovedByRole;
  User createdByUser;

  Receipt(
      {this.id,
        this.receiptNumber,
        this.createdByUserId,
        this.acceptedByUserId,
        this.mustApprovedByRoleId,
        this.receiptTypeId,
        this.description,
        this.acceptedAt,
        this.createdAt,
        this.updatedAt,
        this.items,
        this.mustApprovedByRole,
        this.createdByUser});

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiptNumber = json['receipt_number'];
    createdByUserId = json['created_by_user_id'];
    acceptedByUserId = json['accepted_by_user_id'];
    mustApprovedByRoleId = json['must_approved_by_role_id'];
    receiptTypeId = json['receipt_type_id'];
    description = json['description'];
    acceptedAt = json['accepted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = new List<Item>();
      json['items'].forEach((v) {
        items.add(new Item.fromJson(v));
      });
    }
    mustApprovedByRole = json['must_approved_by_role'] != null
        ? new Role.fromJson(json['must_approved_by_role'])
        : null;
    createdByUser = json['created_by_user'] != null
        ? new User.fromJson(json['created_by_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receipt_number'] = this.receiptNumber;
    data['created_by_user_id'] = this.createdByUserId;
    data['accepted_by_user_id'] = this.acceptedByUserId;
    data['must_approved_by_role_id'] = this.mustApprovedByRoleId;
    data['receipt_type_id'] = this.receiptTypeId;
    data['description'] = this.description;
    data['accepted_at'] = this.acceptedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.mustApprovedByRole != null) {
      data['must_approved_by_role'] = this.mustApprovedByRole.toJson();
    }
    if (this.createdByUser != null) {
      data['created_by_user'] = this.createdByUser.toJson();
    }
    return data;
  }
}

















