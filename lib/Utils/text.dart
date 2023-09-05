import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_list/Utils/colors.dart';

Widget textSecondary30w600(String text) {
  return Text(
    text,
    style: TextStyle(
        color: AppColors.secondary,
        fontSize: 30.sp,
        fontWeight: FontWeight.w600),
  );
}

Widget textWhite16Center(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white, fontSize: 16.sp),
  );
}

Widget textWhite16(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.white, fontSize: 16.sp),
  );
}

Widget textWhite16Line(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        decoration: TextDecoration.lineThrough),
  );
}

Widget textWhite20(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.white, fontSize: 20.sp),
  );
}

Widget textGreen24w500(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.green, fontSize: 24.sp, fontWeight: FontWeight.w500),
  );
}

Widget textSecondary15(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.secondary, fontSize: 15.sp),
  );
}

Widget textRed15(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.red, fontSize: 15.sp),
  );
}
Widget textBlue15(String text) {
  return Text(
    text,
    style: TextStyle(color: Colors.blue, fontSize: 15.sp),
  );
}
