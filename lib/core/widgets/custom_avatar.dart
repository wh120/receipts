import 'dart:io';
import 'dart:typed_data';

import '/core/constants/AppColors.dart';
import '/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAvatar extends StatelessWidget {
  final height;
  final width;
  final image;
  final borderWidth;

  const CustomAvatar(
      {Key key, this.height, this.width, this.image, this.borderWidth = 0.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10.w,
      width: width ?? 10.w,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: AppColors.grey),
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.fill,
            image:
            image is File ? FileImage(image) :
            Uri.parse(image.toString()).isAbsolute? NetworkImage(image):
                image is Uint8List ? MemoryImage(image) :
            AssetImage(AppAssets.male_avatar)),
      ),
    );
  }
}
