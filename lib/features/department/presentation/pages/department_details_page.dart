import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/utils/extensions/extensions.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';

import '../../../../core/constants/AppColors.dart';

import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/constants/AppTheme.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/data_table/widget_data_table.dart';
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
            child: buildTable( ),
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
  buildTable(){
    List<Item> items = widget.department.items;

    return WidgetDataTable(
      columns: [
        Text(
          "الرقم",
        ),
        Text(
          "الاسم",
        ),
        Text("الكمية 1"),
        Text("الكمية 2"),
        Text("الكمية 3"),
        Text('الأوامر')
      ],
      rows: List.generate(items.length, (index) {
        List<Widget> list = [
          Text((index + 1).toString()),
          Text(items[index].name),
          Text(items[index].unitValue.toString() +' '+ items[index].unit),
        ];

        //todo
        for(int i = 0; i < 3;i++) {
          String s = '-';
          if(items[index].units.tryGet(i) != null)
            s =items[index].units.tryGet(i).value.toString() + ' ' + items[index].units.tryGet(i).name;
          list.add(Text(s));
        }


          list.add(IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.delete)));
        return list;
      }),
    );
  }
}
