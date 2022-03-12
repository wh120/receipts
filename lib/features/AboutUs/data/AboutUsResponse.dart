import '/core/API/CoreModels/base_result_model.dart';
import '/core/constants/constants.dart';
import '/features/Contact/data/contact.dart';

class AboutUsResponse extends BaseResultModel {
  int id;
  String arName;
  String enName;
  String photoRelativePath;
  double longitude;
  double latitude;
  List<Contact> contacts;

  AboutUsResponse(
      {this.id,
        this.arName,
        this.enName,
        this.photoRelativePath,
        this.longitude,
        this.latitude,
        this.contacts});

  AboutUsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arName = json['arName'];
    enName = json['enName'];
    photoRelativePath = json['photoRelativePath'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    if (json['contacts'] != null) {
      contacts = new List<Contact>();
      json['contacts'].forEach((v) {
        contacts.add(new Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arName'] = this.arName;
    data['enName'] = this.enName;
    data['photoRelativePath'] = this.photoRelativePath;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
