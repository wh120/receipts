import '/core/API/CoreModels/base_result_model.dart';

class SliderListModel extends BaseResultModel {
  int totalCount;
  List<Slide> list;

  SliderListModel({this.totalCount, this.list});

  SliderListModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      list = new List<Slide>();
      json['items'].forEach((v) {
        list.add(new Slide.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.list != null) {
      data['items'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slide {
  String photoRelativePath;
  bool isActive;
  int id;

  Slide({this.photoRelativePath, this.isActive, this.id});

  Slide.fromJson(Map<String, dynamic> json) {
    photoRelativePath = json['photoRelativePath'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoRelativePath'] = this.photoRelativePath;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }
}

