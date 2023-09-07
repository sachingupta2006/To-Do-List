import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/colors.dart';
import 'package:to_do_list/Utils/text.dart';

import 'create_new_task.dart';
import 'dashboard.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: textSecondary30w600('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    buttonColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    contentPadding: EdgeInsets.all(25.h),
                    confirm: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => Get.back(),
                            child: textBlue15('Cancel')),
                        GestureDetector(
                            onTap: () {
                              taskData.clear();
                              taskDate.clear();
                              storeData();
                              Get.back();
                              Get.back();
                            },
                            child: textRed15('Confirm')),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textSecondary15(
                            'Are you sure you want to clear the data ?')
                      ],
                    ));
              },
              child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                  child: textWhite20('Clear Data')),
            ),
            SizedBox(height: 30.h)
          ],
        ),
      ),
    );
  }
}
