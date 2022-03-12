import '/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import '/core/widgets/animations/FadeAnimation.dart';
import '/core/widgets/errors/ConnectionErrorWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void CreatedCallback( GetModelCubit cubit);
typedef ModelBuilder<Model>  = Widget Function (Model model);
typedef ModelReceived<Model>  =   Function (Model model);

class GetModel<Model> extends StatefulWidget {

  final ModelBuilder<Model> modelBuilder;
  final ModelReceived<Model> onSuccess;

  final RepositoryCallBack repositoryCallBack;
  final CreatedCallback onCubitCreated;



  const GetModel({Key key,
    this.repositoryCallBack,
    this.onCubitCreated,
    this.modelBuilder,
    this.onSuccess }) : super(key: key);

  @override
  State<GetModel<Model>> createState() => _GetModelState<Model>();
}

class _GetModelState<Model> extends State<GetModel<Model>> {

  GetModelCubit<Model> cubit ;

  void initState() {

    cubit = GetModelCubit<Model>(widget.repositoryCallBack);
    if(widget.onCubitCreated != null) {
      widget.onCubitCreated(cubit);
    }
    cubit.getModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetModelCubit,GetModelState>(
      bloc:  cubit,
      builder: (context, state) {
        print('fromPatientList builder');
        print(state);
        if(state is Loading)
          return Center(child: CupertinoActivityIndicator());
        else if(state is GetModelSuccessfully ){


          return buildModel(state.model);
        }

        else if (state is Error ){
          return ConnectionErrorWidget(
            message: state.message,
            onTap: (){
              cubit.getModel( );
            },
          );
        }
        else
          return Container();
      },
      listener: (context, state) {
        if(state is Error){
          // ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message));
        }
        else if(state is GetModelSuccessfully)
          if(widget.onSuccess !=  null)widget.onSuccess(state.model);

      },
    );
  }
  buildModel(Model model){

    return FadeAnimation(
      child: RefreshIndicator(


          child: widget.modelBuilder(model),
          onRefresh: (){
            cubit.getModel();
            return Future.delayed(Duration(seconds: 1));
          }),
    );

  }
}
