import '../../constants/Keys.dart';
import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const GeneralAppBar({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(title  ,),
      automaticallyImplyLeading: true,
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
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Keys.scaffoldKey.currentState.openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}