import '../../constants/Keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/AppColors.dart';


class SearchAppbar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final String hintText;
  final ValueChanged<String> onChanged;

  SearchAppbar({
    Key key,
    this.title,
    this.hintText,
    this.onChanged
  }) : super(key: key);

  @override
  _SearchAppbarState createState() => _SearchAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}

class _SearchAppbarState extends State<SearchAppbar> {
  bool _isSearching = false;

  TextEditingController searchController = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return  AppBar(

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
      ),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          !_isSearching?
          Text(
            widget.title,

          ):Container(),
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                //height: AppBar().preferredSize.height * 0.8,
                decoration: BoxDecoration(
                    color: _isSearching
                        ?  AppColors.white
                        : AppColors.primary,
                    borderRadius:  BorderRadius.circular(2.5.r)
                ),
                width: _isSearching ? 60.0.w: 0.0.w,

                child: TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  focusNode: searchFocusNode,
                  onTap: () {
                    if (!_isSearching) {
                      _isSearching = true;
                      setState(() {});
                    }
                  },
                  onEditingComplete: () {
                    print('onEditingComplete');
                  },
                //  onChanged: widget.onChanged,
                  onFieldSubmitted:widget.onChanged ,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.0.w),
                    hintMaxLines: 1,
                    hintText: widget.hintText ?? 'Search'.tr(),
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                ),
              ),
              IconButton(
                splashColor: Colors.transparent,
                icon: Icon(Icons.search , size: 4.0.r,),
                onPressed: () {
                  if (!_isSearching) {
                    _isSearching = true;
                    setState(() {});
                  }
                  else{
                    searchFocusNode.unfocus();
                    _isSearching = false;
                    setState(() {});
                  }
                },
              )

            ],
          ),
        ],

      ),

      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Keys.scaffoldKey.currentState.openDrawer();
        },
      ),
    );
  }


}