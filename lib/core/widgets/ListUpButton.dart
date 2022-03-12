import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListUpButton extends StatefulWidget {
  final ScrollController scrollController;

  const ListUpButton({Key key, this.scrollController}) : super(key: key);
  @override
  _UpButtonState createState() => _UpButtonState();
}

class _UpButtonState extends State<ListUpButton> {

  ScrollController _scrollController ;
  bool _show = false;

  @override
  void initState()
  {
    _scrollController = widget.scrollController;
    handleScroll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _show,
      child: FloatingActionButton(
        mini: true,
        // elevation: 0,
        onPressed: ()async{
          _scrollController.animateTo(
            0.0,
            curve: Curves.slowMiddle,
            duration: const Duration(milliseconds: 500),
          );
        },
        tooltip: 'up',
        child: new Icon(Icons.arrow_upward),
      ),
    );
  }
  void showFloationButton() {

    setState(() {
      _show = true;
    });
  }

  void hideFloationButton() {

    if (mounted)
      setState(() {
        _show = false;
      });


  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showFloationButton();
      }

      else
        hideFloationButton();
    });
  }
  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }
}

