part of 'application_cubit.dart';

@immutable
abstract class ApplicationState {}

class ApplicationInitial extends ApplicationState {}
class ApplicationLoading extends ApplicationState {}
class ApplicationError extends ApplicationState {}

