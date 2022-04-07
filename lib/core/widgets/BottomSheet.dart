import 'package:flutter/material.dart';
import 'package:receipts/core/API/CoreModels/empty_model.dart';
import '../Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import '../Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../constants/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';

class MyBottomSheet{



  static showConfirmBottomSheet({context , String text ,   ValueChanged<bool> onClicked , Widget form , RepositoryCallBack repositoryCallBack  , requestData}) {
     CreateModelCubit cubit;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(bottom: 3.0.h , top:  3.0.h , right: 3.0.w , left: 3.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 3.0.h),
                  child: Text(text ,),
                ),
                form??Container(),

                Container(
                  child: new Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      CreateModel<EmptyModel>(

                        child: CustomButton(
                          text: 'تأكيد' ,
                          onPressed: () {
                            cubit.createModel(requestData);
                            // onClicked(true);
                            // Navigator.pop(context);
                            // cubit.finishTask(task);
                          },
                        ),

                        repositoryCallBack:repositoryCallBack ,
                        onCubitCreated: (c){
                          cubit=c;
                        },
                        onSuccess: (m){
                          onClicked(true);
                          Navigator.pop(context);
                        },
                      ),
                      CustomButton(
                        color: AppColors.secondary,
                        text: 'إلغاء' ,
                        onPressed: () {
                          onClicked(false);
                          Navigator.pop(context);
                          // cubit.finishTask(task);
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
          );
        }
        );
  }
}