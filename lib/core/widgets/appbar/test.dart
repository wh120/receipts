import '../../constants/app_assets.dart';
import 'package:flutter/material.dart';

class MyCustomAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverDelegate(
              expandedHeight: 150,
              title: "My Custom AppBar",
              description: "SliverPersistentHeader",
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(AppAssets.male_avatar),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final String title;
  final String description;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
    this.title = "",
    this.description = "",
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final factor = 2 - (expandedHeight / appBarSize);
    final percent = factor < 0 || factor > 1 ? 0.0 : factor;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: SizedBox(
        height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
        child: AppBar(
          backgroundColor: Colors.green,
          leading: BackButton(),
          elevation: 0.0,
          title: Opacity(
            opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
            child: Text(title),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Slive extends StatefulWidget {
  @override
  _SliveState createState() => _SliveState();
}

class _SliveState extends State<Slive> {

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            backgroundColor: Colors.red,
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: const Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(AppAssets.male_avatar),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('pinned'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _pinned = val;
                    });
                  },
                  value: _pinned,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('snap'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _snap = val;
                      // Snapping only applies when the app bar is floating.
                      _floating = _floating || _snap;
                    });
                  },
                  value: _snap,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('floating'),
                Switch(
                  onChanged: (bool val) {
                    setState(() {
                      _floating = val;
                      _snap = _snap && _floating;
                    });
                  },
                  value: _floating,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
