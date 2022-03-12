
import '../../../core/API/CoreModels/base_result_model.dart';

class PermissionListResponse extends BaseResultModel {
  List<String> permissions;

  PermissionListResponse({this.permissions});

  PermissionListResponse.fromJson(Map<String, dynamic> json) {
    permissions = json['items'].cast<String>();
  }

}
