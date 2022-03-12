import '../../constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCard extends StatelessWidget {
  final GestureTapCallback onTap;
  final String imagePath;
  final   Widget child;
  final bool isCircleImage;
        double radius;

   ImageCard({Key key, this.onTap, this.imagePath, this.child, this.isCircleImage=true, this.radius}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(radius== null)radius = 2.0.r;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
     semanticContainer: true,
      elevation: 0,
      shadowColor: AppColors.primary[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        side: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.primary.withOpacity(0.1),
          width: 0.5,
        ),
      ),
    //  color: Colors.white,
      child: new InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        onTap: onTap,
        child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Container(

              //  width:30.r,
                height: 20.r,

                // margin: EdgeInsets.only(
                //   right: 2.5.w,
                //   left: 2.5.w
                // ),

                child:
                Container(
                  width: 100.0,
                //   height: 100.0,
                  decoration: BoxDecoration(


                    image: DecorationImage(
                      fit: BoxFit.fitHeight,

                        image: NetworkImage(imagePath),

                    ),
                   // shape: isCircleImage? BoxShape.circle: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5))
  

                  ),
                ),

                //Image.network(imagePath,fit: BoxFit.contain),

                // decoration: BoxDecoration(
                //   color: Colors.red,
                //   image: DecorationImage(
                //     fit: BoxFit.fitWidth,
                //     image: NetworkImage(imagePath)
                //   )
                // ),
                // Container(
                //   width: 100.0,
                //   height: 100.0,
                //   decoration: BoxDecoration(
                //
                //     image: DecorationImage(
                //
                //         image: NetworkImage(imagePath),
                //
                //     ),
                //     shape: isCircleImage? BoxShape.circle: BoxShape.rectangle,
                //
                //
                //   ),
                // ),

                // ClipOval(
                //   child: Image.network(
                //     imagePath,
                //     height: 100,
                //     width: 100,
                //     fit: BoxFit.cover,
                //   ),
                // ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50),
                //   child: Image.network(
                //     imagePath,
                //     height: 150.0,
                //     width: 100.0,
                //   ),
                // )

                //    CircleAvatar(
                //   radius: 9.r  ,
                //      backgroundImage:   imagePath == null ? null:NetworkImage(imagePath) ,
                // )
              ),
            ),
            Expanded(
              flex: 2,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}