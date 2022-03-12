import 'base_error.dart';
import 'package:easy_localization/easy_localization.dart';

class ConnectionError extends BaseError {
  String message ='ConnectionError'.tr();
  @override
  List<Object> get props => [message];
}