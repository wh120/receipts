import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyPieChart extends StatefulWidget {
  final List<PieItem> items;

  const MyPieChart({Key key, this.items}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<MyPieChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                        if (desiredTouch && pieTouchResponse.touchedSection != null) {
                          touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                        } else {
                          touchedIndex = -1;
                        }
                      });
                    }
                    ),
                    borderData: FlBorderData(
                      show: false,

                    ),
                    sectionsSpace: 3,

                    centerSpaceRadius: 15.0.w,
                    sections: showingSections(),

                ),
              //  swapAnimationDuration: Duration(seconds: 2),
              //   swapAnimationCurve: Curves.easeIn,
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: ListView.builder(
                  // physics:  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return Indicator(
                      item: widget.items[index],
                      isSquare: false,
                    );
                  },),
            ),
          ),

          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.items.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 30 : 10;
      return PieChartSectionData(
                color: widget.items[i].color,
                value: widget.items[i].value+0.0,
                title: isTouched ?widget.items[i].value.toInt().toString():'',
                radius: radius,
                titleStyle: TextStyle(
                    fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
              );

    });
  }
}


class Indicator extends StatelessWidget {
  final PieItem item;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.item,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: <Widget>[
        Icon(
          Icons.stop_circle,
        color: item.color,
        ),
        // Container(
        //   width: size,
        //   height: size,
        //   decoration: BoxDecoration(
        //     shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
        //     color: item.color,
        //   ),
        // ),
        SizedBox(
          width: 4,
        ),

        Expanded(
          flex: 2,
          child: Text(
            item.text,
            style: TextStyle(color: textColor),
          ),
        ),

        Expanded(
          child: Text(
            item.value .toString(),
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),

      ],
    );
  }
}

class PieItem {
  final Color color;
  final String text;
  final int value;

  const PieItem({this.value, this.color, this.text});
}
