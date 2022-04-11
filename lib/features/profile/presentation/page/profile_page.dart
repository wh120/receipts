
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../App/presentation/widgets/PopupMenu.dart';
import '../../data/profile_response.dart';
import '../../repository/profile_repository.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController dateOfBirth = TextEditingController(text: "0935555555");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.01),
            spreadRadius: 10,
            blurRadius: 3,
            // changes position of shadow
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 60, right: 20, left: 20, bottom: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الملف الشخصي",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),

                  PopupMenu()
                ],
              ),
              getBody()
            ],
          ),
        ),
      ),
    );
  }

  getBody() {
    return GetModel<User>(
      repositoryCallBack: (data) => ProfileRepository.getProfile(),
      modelBuilder: (User model) => buildBody(model),
    );
  }

  Widget buildBody(User model) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(

        child: Column(
          children: [

            SizedBox(
              height: 25,
            ),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://www.sh-kd.co/shammout.png"),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 25, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text(
                          "الأسم",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.white),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Text(
                          "الأيميل",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.white),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Text(
                          "الأدوار",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(List.generate(model.roles.length, (index) => model.roles[index].name).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15  ,
                              color: AppColors.white),
                        ),


                      ],
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
