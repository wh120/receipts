import 'package:cached_network_image/cached_network_image.dart';
import '/core/constants/AppColors.dart';

import '../../constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverScrollView extends StatefulWidget {
  final Widget child;
  final String title;
  final imagePath;

  const SliverScrollView({Key key, this.child, this.title, this.imagePath}) : super(key: key);
  @override
  _SSliverScrollViewState createState() => _SSliverScrollViewState();
}

class _SSliverScrollViewState extends State<SliverScrollView> {



// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(

         physics: BouncingScrollPhysics(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        slivers: <Widget>[

          SliverAppBar(


            // shape: ContinuousRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
           // backgroundColor: Colors.white,
           // backgroundColor: Colors.red,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 25.0.h,
            flexibleSpace:   FlexibleSpaceBar(

              collapseMode: CollapseMode.pin,

              title: Container(


              child: Text(widget.title)),
              background: Hero(
                tag: 'background',
                child: Container(

                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        Theme.of(context).primaryColorDark,
                        Theme.of(context).primaryColorDark,
                      ],
                    ),
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(25),
                    //   bottomRight: Radius.circular(25),
                    // ),
                  ),
                  child: widget.imagePath!= null?
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(

                        child: CachedNetworkImage(
                          imageUrl: widget.imagePath,
                          fit: BoxFit.cover,
                          ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(

                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.5),
                              AppColors.primary.withOpacity(0.3),
                              AppColors.primary.withOpacity(0.1),
                              AppColors.primary.withOpacity(0.05),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      )
                    ],
                  ):null


                ),
              ),


            ),
          ),

           SliverToBoxAdapter(
            child: widget.child,
          ),

          // SliverList(
          //   delegate:   SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //
          //       return Container(
          //         color: index.isOdd ? Colors.white : Colors.black12,
          //         height: 100.0,
          //         child: Center(
          //           child: Text('$index', textScaleFactor: 5),
          //         ),
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
          // SliverFillRemaining(
          //   child: Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(15),
          //       child: Image.asset(AppAssets.male_avatar),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

}
