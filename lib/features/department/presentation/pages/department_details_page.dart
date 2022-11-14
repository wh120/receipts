import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';

import '../../../../core/constants/AppColors.dart';

import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/constants/AppTheme.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/errors/NoDataWidget.dart';
import '../../../admin/data/department_list_response.dart';
import '../../../admin/data/item_list_response.dart';
import '../../../admin/repository/admin_repository.dart';

class DepartmentDetailsPage extends StatefulWidget {
  final Department department;
  const DepartmentDetailsPage({Key key, this.department}) : super(key: key);

  @override
  State<DepartmentDetailsPage> createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {
  GetModelCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        widget.department.name,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black),
      ),),
      body: getBody(),
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
            child: buildbody( ),
          ),
        ),


      ],
    );
  }



  buildbody( ) {



    List<Item> items = widget.department.items;
    if(items.length == 0)return NoDataWidget();


    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (c,index){
          return GeneralCard(child:
          ListTile(title: Text(items[index].name),
            trailing: Text(items[index].defaultUnitValue.toString() + ' ' +items[index].defaultUnit.toString()),)
          );
        });

  }
}
