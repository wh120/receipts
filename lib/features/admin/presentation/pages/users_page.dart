import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/widgets/BottomSheet.dart';
import 'package:receipts/core/widgets/ColumnBuilder.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/admin/data/user_list_response.dart';
import 'package:receipts/features/admin/repository/admin_repository.dart';
import 'package:search_choices/search_choices.dart';
import 'package:collection/collection.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/widgets/data_table/widget_data_table.dart';
import '../../../RootApp/json/department_json.dart';
import '../../data/item_main_category_list_response.dart';
import '../../data/role_list_response.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<UserPage> {
  GetModelCubit cubit;



  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إدارة المستخدمين",
        ),
      ),
      // backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(

          ),


          Expanded(child: getBody()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigation.push(CreateUserWidget(  onCreated: (_){cubit.getModel();},));

                  // showDialog(
                  //     context: context,
                  //     builder: (_)=>SingleChildScrollView(
                  //       child: Align(
                  //         alignment: Alignment.center,
                  //         child: Dialog(
                  //             child: Container(
                  //                 height:60.h ,
                  //                 child: CreateUserWidget(
                  //                   onCreated: (_){
                  //                     cubit.getModel();
                  //                   },
                  //                 )) ),
                  //       ),
                  //     ));
                },
                child: Text('إضافة مستخدم جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel< UserListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getUsers(),
      modelBuilder: (UserListResponse model)=>buildbody(model),

    );
  }
  buildbody(UserListResponse model) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: [
          Text("الرقم"),
          Text("الاسم"),
          Text("الأيميل"),
          Text("الدور"),
          Text("الأوامر"),

        ],
        rows: List.generate(model.items.length, (index) => [
          Text(model.items[index].id.toString()),
          Text(model.items[index].name) ,
          Text(model.items[index].email) ,
          Text(List.generate(model.items[index].roles?.length??0, (i) => model.items[index].roles[i].name).toString()) ,
          Row(
            children: [
              IconButton(onPressed: (){
                MyBottomSheet.showConfirmBottomSheet(
                  context: context,
                  text: 'هل تريد الحذف' ,
                  onClicked: (b){
                    if(b)cubit?.getModel();
                  },repositoryCallBack: (data)=>AdminRepository.deleteUser(model.items[index].id),

                );
              }, icon: Icon(Icons.delete)),

              IconButton(onPressed: (){

                Navigation.push(CreateUserWidget(user:model.items[index] , onCreated: (_){cubit.getModel();},));
              }, icon: Icon(Icons.edit))
            ],
          )


        ]),
      ),
    );
  }





}

class CreateUserWidget extends StatefulWidget {
  final ValueChanged onCreated;
  final User user;

  const CreateUserWidget({Key key, this.onCreated, this.user}) : super(key: key);
  @override
  _CreateUserWidgetState createState() => _CreateUserWidgetState();
}

class _CreateUserWidgetState extends State<CreateUserWidget> {

  CreateModelCubit cubit;
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  User user;

  void initState() {

    if(widget.user!= null){
      user=widget.user;
    }
    else{
      user = new User(
          name: '',
          email: '',
        roles: [null]
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ?'إضافة مستخدم جديد':'تعديل المسنخدم'),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "الاسم",
              onChanged: (v){user.name = v;},
              initialValue: user.name,
              // controller: nameController,
            ),
            RoundedTextField(
              hintText: "الأيميل",
              onChanged: (v){user.email = v;},
              initialValue: user.email,
              // controller: codeController,
            ),
            RoundedTextField(
              hintText: "كلمة السر",
              onChanged: (v){user.password = v;},
              initialValue: user.password,
              // controller: codeController,
            ),
            getDepartmentsAndRoles(),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateModel<EmptyModel>(
                repositoryCallBack: (data) => widget.user!=null?AdminRepository.updateUser(user.id,data):AdminRepository.createUser(data),
                onCubitCreated: (c){
                  cubit=c;
                },
                onSuccess: (m){

                  Navigation.pop();
                  widget.onCreated(m);

                },
                child: ElevatedButton(
                    onPressed: () {
                      if(cubit!=null && user.name.isNotEmpty && user.email.isNotEmpty) {
                        if(user.roles.where((element) => element==null).length ==0)
                          cubit.createModel(user);
                      }

                    },
                    child: Text(widget.user == null ?'إضافة مستخدم جديد':'تعديل المسنخدم')
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  Department selectedDepartment;

  getDepartmentsAndRoles(){
    return GetModel<RoleListResponse>(
      repositoryCallBack: (data) => AdminRepository.getRoles(),
      modelBuilder: (RoleListResponse model) {


        return buildDepartments(model.items);
      },

    );
  }
  buildDepartments(List<Role> items) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "الأدوار",
        ),
        Column(
          children: [
            ColumnBuilder(
              itemCount: user.roles.length,
              itemBuilder: (c,index){
                return Row(
                  children: [

                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ObjectDropDown<Role>(
                        selectedValue: user.roles[index],
                        items:  items,
                        text: 'الدور',
                        onChanged: (Role role){
                          user.roles[index] = role;
                          // selectedDepartment = department;
                          setState(() {

                          });
                        },
                      ),
                    ),

                    IconButton(onPressed: (){
                      user.roles.removeAt(index);
                      setState(() {
                      });
                    }, icon: Icon(Icons.remove)),
                  ],
                );
              },
                ),
            IconButton(onPressed: (){
              user.roles.add(null);
              setState(() {
              });
            }, icon: Icon(Icons.add))
          ],
        )
      ],
    );
  }
}



