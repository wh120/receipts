import '/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import '/core/widgets/animations/FadeAnimation.dart';
import '/core/widgets/errors/ConnectionErrorWidget.dart';
import '/core/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void CreatedCallback( CreateModelCubit cubit);
typedef ModelCreated<Model>  =   Function (Model model);

class CreateModel<Model> extends StatefulWidget {

  final ModelCreated<Model> onSuccess;


  final RepositoryCallBack repositoryCallBack;
  final CreatedCallback onCubitCreated;
  final VoidCallback onError;
  final Widget child;


  const CreateModel({Key key,
    this.repositoryCallBack,
    this.onCubitCreated,
    this.child,
    this.onSuccess,
    this.onError }) : super(key: key);

  @override
  State<CreateModel<Model>> createState() => _GetModelState<Model>();
}

class _GetModelState<Model> extends State<CreateModel<Model>> {

  CreateModelCubit<Model> cubit ;

  void initState() {

    cubit = CreateModelCubit<Model>(widget.repositoryCallBack);
    if(widget.onCubitCreated != null) {
      widget.onCubitCreated(cubit);
    }
    //cubit.createModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModelCubit,CreateModelState>(
      bloc:  cubit,
      builder: (context, state) {
        print('fromPatientList builder');
        print(state);
        if(state is CreateModelInitial)
          return widget.child;
        else if(state is Loading)
          return Center(child: CupertinoActivityIndicator());
        else if(state is CreateModelSuccessfully ){
          return widget.child ;
        }

        // else if (state is Error ){
        //   return ConnectionErrorWidget(
        //     message: state.message,
        //     onTap: (){
        //       cubit.createModel( );
        //     },
        //   );
        // }
        else
          return  widget.child;
      },
      listener: (context, state) {
        if(state is CreateModelSuccessfully) {

          widget.onSuccess(state.model);
          showSnackBar(state.message );
        }
        if(state is Error){
              if(widget.onError != null )widget.onError();
            showSnackBar(state.message.toString());
          //  ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message));
        }

      },
    );
  }

}
