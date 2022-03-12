import 'package:flutter/material.dart';
import '../constants/AppTheme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sectionTitle(context , title);
  }
  Widget sectionTitle(context, String title) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 20.0,
          //  left: 10.0,
         //   right: 10.0,
            bottom: 10.0,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: AppTheme.headline3,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 1,
                ),
                child: Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

}
