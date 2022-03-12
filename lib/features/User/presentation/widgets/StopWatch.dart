import '/core/constants/AppColors.dart';
import '/core/constants/AppTheme.dart';
import 'package:quiver/async.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class StopWatch extends StatefulWidget {
  final  int time;


  const StopWatch({Key key,@required this.time }) : super(key: key);
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {

  int _start ;
  int _current ;
  Widget text ;
  @override
  void initState() {
    _start = widget.time;
    _current = widget.time;

    startTimer();
    super.initState();
  }




  Widget build(BuildContext context) {

    if(_current == 0)
      text =Text('Resend activation code'.tr(),style: AppTheme.bodyText2.copyWith(color: AppColors.secondary[600]),);

    else
      text = Text( "You can resend the code within X seconds".tr(args: [_current.toString()]) );

    return TextButton(

        onPressed: _current == 0?startTimer:null,
        style: TextButton.styleFrom(

            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent)
            ),
            padding: EdgeInsets.all(0)
        ),
        child: text
    );
  }



  void startTimer() {
    _start = widget.time;
    _current = widget.time;

    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  void dispose() {

    super.dispose();
  }


}
