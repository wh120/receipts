import 'package:bloc/bloc.dart';
import '../models/GetListRequest.dart';
import '../../../API/CoreModels/base_response_model.dart';
import '../../../API/errors/base_error.dart';
import '../../../API/CoreModels/base_result_model.dart';

import 'package:meta/meta.dart';

part 'pagination_state.dart';

typedef RepositoryCallBack  = Future<BaseResultModel> Function( dynamic data);

class PaginationCubit<ListModel> extends Cubit<PaginationState> {
  final RepositoryCallBack getData;

  PaginationCubit(this.getData) : super(PaginationInitial ());


  List<ListModel>  list;
  Map<String,dynamic> params={};
  int maxResultCount = 20;
  int skipCount = 1;
  String keyword;

  getList({  bool loadMore = false  , Map<String,dynamic> param ,String keyword  })async{


    if(!loadMore)
    {
      skipCount = 1;
     // if(list.isEmpty)
       emit(Loading ());
    }
    else
      skipCount ++;

    if(param!= null)
      params.addAll(param);

    var requestData = GetListRequest(
        maxResultCount: maxResultCount,
        skipCount: skipCount,
        extraParams: params,
        keyword: keyword

    );
    var response = await getData(requestData);

    if(response is ListResultModel<ListModel>)
    {
      if(loadMore)
        list.addAll(response.list  );
      else
        list = response.list;

      emit(GetListSuccessfully (
          list: list ,
          noMoreData:  response.list.length==0 &&loadMore
      ));
    }
    else if(response is BaseError)  emit(Error( response.message));
    else if (response is ServerError) emit(Error(response.message ));

    else emit(PaginationInitial ());
  }
}
