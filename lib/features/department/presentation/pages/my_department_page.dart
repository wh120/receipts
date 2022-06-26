import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';

import '../../../../core/constants/AppColors.dart';

 import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/constants/AppTheme.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../admin/data/department_list_response.dart';
import '../../../admin/repository/admin_repository.dart';
import 'department_details_page.dart';

class MyDepartmentPage extends StatefulWidget {
  const MyDepartmentPage({Key key}) : super(key: key);

  @override
  State<MyDepartmentPage> createState() => _MyDepartmentPageState();
}

class _MyDepartmentPageState extends State<MyDepartmentPage> {
  GetModelCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "الأقسام الخاصة بي",
          ),
        ),

        body: getBody()
    );
  }
  Widget getBody() {
     return Column(
      children: [
         SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: getDepartments( ),
          ),
        ),


      ],
    );
  }

  getDepartments() {
    return GetModel<DepartmentListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getMyDepartments(),
      modelBuilder: (DepartmentListResponse model)=>buildbody(model),

    );

  }

  buildbody(DepartmentListResponse model) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: model.items.length,
        itemBuilder: (c,index){
          return GeneralCard(
              onTap: () {
                Navigation.push(DepartmentDetailsPage(department: model.items[index],));
              },
              child: Center(child: Text(model.items[index].name,style: AppTheme.headline2,))
          );
        });
  }
}
