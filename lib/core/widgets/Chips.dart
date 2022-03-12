import '../constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCategoryTab extends StatelessWidget {
  final bool isSelected;
  final String name;
  final Function onPressed;
  final bool isSearchTab;
  final bool isLeading;

  const MainCategoryTab(
      {Key key,
        this.isSelected = false,
        @required this.name,
        this.onPressed,
        this.isLeading,
        this.isSearchTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 1.5.w,
          vertical: 1.5.h),
       // ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          decoration: BoxDecoration(
              color: isLeading
                  ? Colors.white
                  : isSelected
                  ? AppColors.primary
                  : AppColors.primary[100],
              borderRadius: isSearchTab
                  ? BorderRadius.circular(1.5.w)
                  : BorderRadius.circular(8.0.w)),
          child: InkWell(
            onTap: () {
              onPressed();
            },
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 6.0.w),
              child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: isSelected
                            ? 40
                            : 40,
                        color:
                        isSelected ? AppColors.secondary : AppColors.primary),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  static buildMainCategoriesSection({List<String> list}) {
    List<MainCategoryTab> mainCategoryTabsList = List<MainCategoryTab>();
    list.forEach((text) {
      mainCategoryTabsList.add(
        MainCategoryTab(
          isLeading: false,
          isSearchTab: false,
          name: text,
          onPressed: () {


          },
          isSelected: 'one' == text,
        ),
      );
    });
    return Container(
      padding: EdgeInsets.only(left: 8),
      width: 100.0.w,
      child: LimitedBox(
        maxHeight: 17.0.w,
        maxWidth: 100.0.w,
        child: ListView.builder(
            itemCount: mainCategoryTabsList.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return mainCategoryTabsList[index];
            }),
      ),
    );
  }

}