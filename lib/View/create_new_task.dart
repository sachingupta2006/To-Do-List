import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Routes/Utils/colors.dart';
import '../Routes/Utils/text.dart';

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TextButton(
                onPressed: () => Get.back(), child: textSecondary15('Cancel')),
            SizedBox(height: 15.h),
            textSecondary30w600('Create New Task'),
            SizedBox(height: 25.h),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Task title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white12, width: 1))),
            ),
            SizedBox(height: 25.h),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white12, width: 1))),
            ),
            SizedBox(height: 25.h),
            textWhite20('Remind me at'),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(10)),
                    child: textWhite16('date')),
                SizedBox(width: 5.w),
                Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(10)),
                    child: textWhite16('time'))
              ],
            ),
            SizedBox(height: 35.h),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  child: textWhite20('Create Task')),
            )
          ],
        ),
      )),
    );
  }
}
