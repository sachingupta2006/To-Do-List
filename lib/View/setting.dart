import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_list/Utils/colors.dart';
import 'package:to_do_list/Utils/text.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(elevation: 0,
      backgroundColor: AppColors.primary,
        title: textSecondary30w600('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(height: 20.h), SizedBox(height: 30.h)],
        ),
      ),
    );
  }
}
