import '/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

import 'GeneralCard.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  BoxDecoration decoration = boxDecoration.copyWith(boxShadow:defaultShadow);

  CustomContainer({
        this.height,
        this.padding = DefaultEdgeInsets,
        this.margin,
        this.child,
        this.width  ,
    this.decoration
      }){
    if(decoration==null)
      decoration = boxDecoration.copyWith(boxShadow:defaultShadow);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: GeneralCard(

          child: child,

      ),
    );
    return Container(
      padding: padding,
    //  alignment: Alignment.center,
      margin: margin,
      height: height,
      width: width,
      decoration: decoration,
      child: child != null ? child : null,

    );
  }
}