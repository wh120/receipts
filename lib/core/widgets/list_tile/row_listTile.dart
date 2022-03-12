 import 'package:flutter/material.dart';

class RowListTile extends StatelessWidget {
  final leading;
  final trailing;
  final underline;

  const RowListTile(
      {Key key, this.leading, this.trailing, this.underline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leading, style: Theme.of(context).textTheme.button),
        Text(trailing,
            style: underline
                ? Theme.of(context).textTheme.bodyText2.copyWith(
                      decoration: TextDecoration.underline,
                    )
                : Theme.of(context).textTheme.bodyText2)
      ],
    );
  }
}
