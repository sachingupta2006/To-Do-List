import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/colors.dart';
import 'package:to_do_list/Routes/routes_name.dart';
import '../Utils/text.dart';
import 'create_new_task.dart';

var taskData = [].obs;
var taskDate = [].obs;

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Get.defaultDialog(
            buttonColor: AppColors.primary,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(10.h),
            confirm: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                      false;
                    },
                    child: textBlue15('Cancel')),
                GestureDetector(
                    onTap: () {
                      true;
                    },
                    child: textRed15('Confirm')),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [textSecondary15('Are you sure you want to exit ?')],
            ));
        // return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
            title: textSecondary30w600('Task'),
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            actionsIconTheme:
                IconThemeData(size: 30.sp, color: AppColors.secondary),
            actions: [
              GestureDetector(
                  onTap: () => Get.offNamed(RouteName.createNewTask),
                  child: const Icon(Icons.add)),
              SizedBox(width: 10.w),
              GestureDetector(
                  onTap: () => Get.offNamed(RouteName.setting),
                  child: const Icon(Icons.settings)),
              SizedBox(width: 10.w),
            ]),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Obx(
      () => Container(
        color: Colors.grey[600],
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: taskData.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50.h),
                  textWhite16Center(
                      "You don't have any Tasks yet, press the 'Create Task' or '+' button to create one."),
                  SizedBox(height: 150.h),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primary)),
                      onPressed: () {
                        Get.offNamed(RouteName.createNewTask);
                      },
                      child: textGreen24w500('Add a Task')),
                  SizedBox(height: 15.h)
                ],
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return taskRow(taskData[index].toString(),
                      taskDate[index].toString(), index);
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: taskData.length),
      ),
    );
  }

  Widget taskRow(String txt, String date, index) {
    RxBool completed = false.obs;
    return Column(
      children: [
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () {
            completed.value = !completed.value;
          },
          onLongPress: () {
            Get.defaultDialog(
              buttonColor: AppColors.primary,
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(10.h),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(), child: textBlue15('Edit Task')),
                  GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                            buttonColor: AppColors.primary,
                            backgroundColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.h),
                            confirm: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.back();
                                    },
                                    child: textBlue15('Cancel')),
                                GestureDetector(
                                    onTap: () {
                                      removeTask(index);
                                      // taskData.removeAt(index);
                                      // taskDate.removeAt(index);
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
                                    'Are you sure you want to Delete this task ?')
                              ],
                            ));
                      },
                      child: textRed15('Delete Task')),
                ],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x3F717171),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 21.h,
                          height: 21.h,
                          decoration: ShapeDecoration(
                            color: completed.value
                                ? AppColors.secondary
                                : Colors.white,
                            shape: const OvalBorder(
                              side: BorderSide(
                                  width: 0.8, color: Color(0xFFEE3764)),
                            ),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.check_outlined,
                            size: 15.h,
                            color: Colors.white,
                          )),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          txt,
                          style: TextStyle(
                              decoration: completed.value
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 15.sp,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          decoration: completed.value
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 15.sp,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(height: 10.h)
      ],
    );
  }
}
