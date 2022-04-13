import 'package:flutter/material.dart';

import '../../constants/AppTheme.dart';

class DefaultTabBar extends StatelessWidget {
  final int initialIndex;
  final Map<String , Widget> tabs;
  const DefaultTabBar({Key key, this.tabs, this.initialIndex=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTabs();
  }
  buildTabs(){
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Column(
        children: [
          TabBar(
              labelStyle: AppTheme.headline3,

              tabs:List.generate(tabs.length, (index) => Tab(  child: Text(tabs.keys.elementAt(index))))

          ),
          Expanded(
            child: TabBarView(
              children: List.generate(tabs.length, (index) => tabs.values.elementAt(index)),
            ),
          )
        ],
      ),
    );
  }
}
