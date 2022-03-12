import '../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
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
                            color: black),
                      ),
                      Icon(AntDesign.setting)
                    ],
                  ),
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
                      // Container(
                      //   width: (size.width - 40) * 0.4,
                      //   child: Container(
                      //     child: Stack(
                      //       children: [
                      //         // RotatedBox(
                      //         //   quarterTurns: -2,
                      //         //   child: CircularPercentIndicator(
                      //         //       circularStrokeCap: CircularStrokeCap.round,
                      //         //       backgroundColor: grey.withOpacity(0.3),
                      //         //       radius: 110.0,
                      //         //       lineWidth: 6.0,
                      //         //       percent: 0.53,
                      //         //       progressColor: primary),
                      //         // ),
                      //         Positioned(
                      //           top: 16,
                      //           left: 13,
                      //           child: Container(
                      //             width: 85,
                      //             height: 85,
                      //             decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 image: DecorationImage(
                      //                     image: NetworkImage(
                      //                         "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                      //                     fit: BoxFit.cover)),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "أبو محمد",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "امين مستودع بن الحسناء",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black.withOpacity(0.4)),
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
                        color: primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.01),
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
                                "اسم المستخدم",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "abu_mohamad",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: white),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: white)),
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                "تعديل",
                                style: TextStyle(color: white),
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
                  cursorColor: black,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
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
