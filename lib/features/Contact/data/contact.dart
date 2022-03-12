

import '../../../core/constants/constants.dart';

class Contact {
  int id;
  String prefix;
  String contactInfo;
  String description;
  ContactType type;
  bool isActive;

  Contact(
      {this.id,
        this.prefix,
        this.contactInfo,
        this.description,
        this.type,
        this.isActive});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefix = json['prefix'];
    contactInfo = json['contactInfo'];
    description = json['description'];
    type = ContactType.values[(json['type']-1)>=ContactType.values.length?ContactType.values.length-1:(json['type']-1)];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefix'] = this.prefix;
    data['contactInfo'] = this.contactInfo;
    data['description'] = this.description;
    data['type'] = this.type;
    data['isActive'] = this.isActive;
    return data;
  }
}

