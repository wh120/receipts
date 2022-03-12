import 'package:bloc/bloc.dart';
import '/core/API/CoreModels/base_response_model.dart';
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/errors/base_error.dart';
import 'package:meta/meta.dart';

part 'create_model_state.dart';

typedef RepositoryCallBack  = Future<BaseResultModel> Function( dynamic data);


class CreateModelCubit<Model> extends Cubit<CreateModelState> {
  final RepositoryCallBack getData;

  CreateModelCubit(this.getData) : super(CreateModelInitial());

  createModel(dynamic requestData)async{
    emit(Loading ());
    var response = await getData(requestData);
    if(response is Model)
    {
      emit(CreateModelSuccessfully (response ));
    }
    else if(response is BaseError)  emit(Error( response.message));
    else if (response is ServerError) emit(Error(response.message ));

  }
}
