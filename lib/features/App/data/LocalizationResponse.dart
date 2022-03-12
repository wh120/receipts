
import '../../../core/API/CoreModels/base_result_model.dart';

class LocalizationResponse extends BaseResultModel {
  int totalCount;
 // List<Localization> localizations;
  Map<String, Localization> localizations;

  LocalizationResponse({this.totalCount, this.localizations});

  LocalizationResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
     // localizations = new List<Localization>();
      localizations = new Map();
      json['items'].forEach((v) {

        var obj = new Localization.fromJson(v);
        localizations.putIfAbsent(obj.id, () => obj);
      //  localizations.add(obj);
      });
    }
  }

}

class Localization {
  String id;
  String arabicValue;
  String englishValue;

  Localization({this.id, this.arabicValue, this.englishValue});

  Localization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabicValue = json['arabicValue'];
    englishValue = json['englishValue'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabicValue'] = this.arabicValue;
    data['englishValue'] = this.englishValue;
    return data;
  }

}
