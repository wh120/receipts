import '../errors/base_error.dart';
import 'base_result_model.dart';


class BaseResponseModel <Result extends BaseResultModel>{
  Result result;
  ServerError serverError;
  BaseError error;
  String targetUrl;
  bool success;
  bool unAuthorizedRequest;
  bool bAbp;

  BaseResponseModel(
      {this.result,
        this.targetUrl,
        this.success,
        this.serverError,
        this.error,
        this.unAuthorizedRequest,
        this.bAbp});

  BaseResponseModel.fromJson({
      Map<String, dynamic> json ,
      Result Function(Map<String, dynamic>) fromJson ,
      BaseError error
      }) {


    if(json ==null)
      {
        if(error != null)
        {
          this.error = error;
          success=false;
        }
      }
    else
      {
        targetUrl = json['targetUrl'];
        bAbp = json['__abp'];
        success = json['success'] !=null? json['success']:false;

        unAuthorizedRequest = json['unAuthorizedRequest'];

        this.error = error;

        serverError = json['error'] != null ? new ServerError.fromJson(json['error']) : null;

        if(fromJson != null)
          if (json['result'] != null) {
            result = fromJson(json['result']);
          } else {
            if(success)
            result = fromJson({});
          }



      }
  }

}


class ServerError extends BaseResultModel{
  int code;
  String message;
  String details;
  List<ValidationErrors> validationErrors;

  ServerError({this.code, this.message, this.details, this.validationErrors});

  ServerError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
    if (json['validationErrors'] != null) {
      validationErrors = new List<ValidationErrors>();
      json['validationErrors'].forEach((v) {
        validationErrors.add(new ValidationErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['details'] = this.details;
    if (this.validationErrors != null) {
      data['validationErrors'] =
          this.validationErrors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValidationErrors {
  String message;
  List<String> members;

  ValidationErrors({this.message, this.members});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    members = json['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['members'] = this.members;
    return data;
  }
}
