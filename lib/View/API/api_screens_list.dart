import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/text.dart';
import '../../Routes/routes_name.dart';
import '../../Utils/colors.dart';

class APIScreensList extends StatelessWidget {
  const APIScreensList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
          title: textSecondary30w600('API Screens List'),
          backgroundColor: AppColors.primary,
          actionsIconTheme:
              IconThemeData(size: 30.sp, color: AppColors.secondary)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [customContainer('Jokes', RouteName.jokesScreen)],
      ),
    );
  }

  Widget customContainer(String text, String route) {
    return GestureDetector(
        onTap: () => Get.toNamed(route),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
            child: textWhite20(text)));
  }
}
