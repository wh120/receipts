import 'package:flutter/material.dart';

class ScrollViewBuilder extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final int itemCount;
  final Axis scrollDirection;

  const ScrollViewBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection: VerticalDirection.down, this.scrollDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(this.itemCount,
            (index) => this.itemBuilder(context, index)).toList();

    return  SingleChildScrollView(
      scrollDirection: scrollDirection,
      child:scrollDirection == Axis.horizontal?
      Row(children: children):
      Column(children: children)
      ,
    );
  }
}