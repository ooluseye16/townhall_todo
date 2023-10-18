import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ActualSize on num {
  Widget get height => SizedBox(
        height: h,
      );

  Widget get width => SizedBox(
        width: w,
      );
}


extension CompletePath on String {
  String get imagePath => "assets/images/$this.png";
   String get iconPath => "assets/icons/$this.png";
}

