
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
      backgroundColor: AppColors.grey.withOpacity(0.05),
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
    return GetModel<MyProfile>(
      repositoryCallBack: (data) => ProfileRepository.getProfile(),
      modelBuilder: (MyProfile model) => buildBody(model),
    );
  }

  Widget buildBody(MyProfile model) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(

            child: Column(
              children: [

                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://www.sh-kd.co/hasna.png"),
                              fit: BoxFit.contain)),
                    ),

                    Container(
                      width: (size.width - 40) * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              model.roles.first.name,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black.withOpacity(0.4)),
                          ),
                        ],
                      ),
                    )
                  ],
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
                                  fontSize: 20,
                                  color: AppColors.white),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              "تعديل",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "رقم الموبايل",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: dateOfBirth,
                  cursorColor: AppColors.blackText,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.blackText),
                  decoration: InputDecoration(
                      hintText: "0933333333", border: InputBorder.none),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          )
        ],
      ),
    );
  }


}
