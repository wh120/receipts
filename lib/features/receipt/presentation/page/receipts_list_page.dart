
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/core/Boilerplate/Pagination/cubits/pagination_cubit.dart';
import 'package:receipts/core/constants/AppColors.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/features/receipt/data/receipt_type_json.dart';
import 'package:receipts/features/receipt/presentation/page/fill_receipt_page.dart';
import 'package:receipts/features/receipt/repository/ReceiptRepository.dart';

import '../../../../core/Boilerplate/Pagination/widgets/PaginationList.dart';
import '../../../../core/utils/Converters/Converters.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../data/receipt_list_response.dart';


class  ReceiptsListPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<ReceiptsListPage> {
  int activeDay = 3;

  PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: buildBody(),
    );
  }

  Widget buildBody() {

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
                      "جميع الإيصالات",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    Row(
                      children: [

                        SizedBox(
                          width: 20,
                        ),
                        Icon(AntDesign.search1)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(child: getList())
      ],
    );
  }
  getList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: PaginationList<Receipt>(
        onCubitCreated: (c){
          cubit=c;
        },
        repositoryCallBack: (data) => ReceiptRepository.geReceipts(data),
        listBuilder: (List<Receipt> list)=>buildList(list),
      ),
    );
  }

  buildList(List<Receipt> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return buildReceiptCard(list[index]);
      },
    );
  }

  GeneralCard buildReceiptCard(Receipt receipt ) {
    return GeneralCard(
      onTap: (){
        Navigation.push(FillReceiptPage(receipt: receipt,)).then((value) {
          cubit?.getList();
        });

      },
      child: Container(
        width: double.infinity,

        child: Padding(
          padding: EdgeInsets.only(
              left: 25, right: 25, bottom: 25, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "عملية "+receipt_type[receipt.receiptTypeId-1]["name"],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff67727d) ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      MyConverter.timeToTimeAgo(receipt.createdAt),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d).withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "أنشئت من قِبل: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        receipt.createdByUser.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),


                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      receipt.createdByUser.roles.first?.name??'',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d).withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "من: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        receipt.fromDepartment?.name??'',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),


                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 3),
                  //   child: Text(
                  //     receipt.createdByUser.roles.first?.name??'',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 13,
                  //         color: Color(0xff67727d).withOpacity(0.6)),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "إلى: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        receipt.toDepartment?.name??'',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),

                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      receipt.mustApprovedByRole?.name??''
                      ,
                      // MyConverter.timeToTimeAgo(receipt.createdAt),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xff67727d).withOpacity(0.6)),
                    ),
                  ),
                ],
              ),


              SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  if(receipt.acceptedByUser!= null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "قُبِلت من قِبل: ",
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              receipt.acceptedByUser?.name??'',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            MyConverter.timeToTimeAgo(receipt.acceptedAt)??'',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d).withOpacity(0.6)),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      "لم تُقبل بعد",
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 15,
                      ),
                    ),

                  Text('#'+receipt.id.toString())

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
