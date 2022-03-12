import '../../constants/AppColors.dart';
import 'package:flutter/material.dart';

class ChipCard extends StatelessWidget {
  final Widget child ;
  final bool selected  ;
  final VoidCallback onPressed;

    ChipCard({
    Key key, this.child, this.onPressed, this.selected=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(
          right: 1.0,
          left: 20.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: OutlinedButton(


          style: OutlinedButton.styleFrom(
           // shape: StadiumBorder(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.5),
            ),
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 6,
            ),
            side: selected?BorderSide(
                width: 2,
                color: AppColors.secondary
            ):null,
          ),
          // splashColor: Theme.of(context).primaryColor,
          // highlightColor: Colors.red,

          onPressed: onPressed,
         // textColor: Theme.of(context).primaryColor,

          child: Align(
              alignment: Alignment.center,
              child: child
          ),
        ),
      ),
    );
  }
}