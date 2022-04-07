
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/features/receipt/data/receipt_type_json.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipts/features/receipt/repository/ReceiptRepository.dart';
import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
import '../../../../core/constants/AppColors.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

import '../../data/receipt_type_response.dart';
class DailyReceiptsPage extends StatefulWidget {
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyReceiptsPage> {
  int activeDay = 3;
  DateTime selectedDateTime =DateTime.now();

  GetModelCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
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
                      "العمليات اليومية",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    Icon(AntDesign.search1)
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                buildCalendar()
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: getReceiptType( ),
          ),
        ),


      ],
    );
  }

  getReceiptType(){

    return GetModel<ReceiptTypeResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => ReceiptRepository.getReceiptTypes(dateTime: selectedDateTime),
      modelBuilder: (ReceiptTypeResponse model)=>buildReceiptType(model),
    );
  }
    buildReceiptType( ReceiptTypeResponse model) {
    return ListView.builder(
          itemCount: model.items.length,
          itemBuilder:(c,index){
            return InkWell(
              onTap: (){

              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (100.w - 40) * 0.7,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grey.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Image.asset(
                                  receipt_type[index]['icon'],
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: (100.w  - 90) * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    receipt_type[index]['name'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'ww ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (100.w  - 40) * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              model.items[index].receiptsCount.toString() + ' عملية',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppColors.secondary),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 65, top: 8),
                    child: Divider(
                      thickness: 0.8,
                    ),
                  )
                ],
              ),
            );
          }
    );
  }

    buildCalendar() {
    return Directionality(
                  textDirection: TextDirection.ltr,
                  child: CalendarTimeline(
                    showYears: true,
                    initialDate: selectedDateTime,
                    firstDate: DateTime(2022, 1, 1),
                    lastDate: DateTime(2050, 11, 20),
                    onDateSelected: (date) {
                      selectedDateTime =date;
                      cubit?.getModel(params: selectedDateTime);
                      },
                    leftMargin: 20,
                    monthColor: Colors.blueGrey,
                    dayColor: AppColors.secondary[300],
                    activeDayColor: AppColors.secondary,
                    activeBackgroundDayColor: AppColors.primary,
                    dotsColor: Color(0xFF333A47),

                    locale: 'ar',
                  ),
                );
  }
}
