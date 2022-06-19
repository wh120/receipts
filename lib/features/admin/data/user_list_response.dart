import 'package:receipts/features/admin/data/role_list_response.dart';

import '../../../core/API/CoreModels/base_result_model.dart';

class UserListResponse extends BaseResultModel{
  List<User> items;

  UserListResponse({this.items});

  UserListResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<User>();
      json['items'].forEach((v) {
        items.add(new User.fromJson(v));
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

class User extends BaseResultModel{
  int id;
  String name;
  String email;
  String password;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  List<Role> roles;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = new List<Role>();
      json['roles'].forEach((v) {
        roles.add(new Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


