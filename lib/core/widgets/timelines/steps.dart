import 'package:flutter/material.dart';

class StepWidget{
  final Color labelColor;
  final Color backgroundColor;
  final String label;
  final Widget child;

  StepWidget({this.labelColor, this.backgroundColor, this.label, this.child});

}
class Steps extends StatelessWidget {
  final Axis direction;
  final List<StepWidget> steps;
  final double size;
  final Color color;
  final double width;
  Steps({
    Key key,
    this.direction = Axis.vertical,
    @required this.steps,
    this.size = 21,
    @required  this.color,
    @required  this.width,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var horizontal = 16 + size * 2.14 / 2 - 5 / 2;
    var top = 16 + size * 2.14 / 2 - 5 / 2;

    return ListView.builder(
      scrollDirection: direction,
      itemCount: steps.length,
      itemBuilder: (context, position) => Stack(
        children: <Widget>[
          Positioned(
            top: direction == Axis.horizontal ? top : 0,
            bottom: direction == Axis.horizontal ? null : 0,
            left: direction == Axis.horizontal ? 0 : Directionality.of(context) == TextDirection.rtl? null: horizontal,
            right: direction == Axis.horizontal ? 0 :  Directionality.of(context) == TextDirection.rtl? horizontal:null,
            height: direction == Axis.horizontal ? width : null,
            width: direction == Axis.horizontal ? null : width,
            child: Container(
              color: color,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Directionality.of(context) == TextDirection.rtl?16:0 ,right: Directionality.of(context) == TextDirection.rtl?0:16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Text(
                    steps[position].label,
                    style: TextStyle(
                      color: steps[position].labelColor,
                      fontSize: size,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  padding: EdgeInsets.all(6),
                  width: size * 2.14,
                  height: size * 2.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: steps[position].backgroundColor,
                    borderRadius: BorderRadius.circular(size * 2.14),
                  ),
                ),
                steps[position].child != null
                    ? direction == Axis.horizontal
                    ? Padding(
                  padding: EdgeInsets.only(top: size * 2.14),
                  child: steps[position].child,
                )
                    : Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: size * 2.14),
                    child: steps[position].child,
                  ),
                )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}