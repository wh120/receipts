part of 'pagination_cubit.dart';

@immutable
abstract class PaginationState  {}

class PaginationInitial  extends PaginationState  {}
class Loading extends PaginationState  {}

class GetListSuccessfully   extends PaginationState  {
  final List  list;
  final bool noMoreData;

  GetListSuccessfully({this.list, this.noMoreData});
}

class Error  extends PaginationState  {
  final String message;
  Error(this.message);
}
