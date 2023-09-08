import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/colors.dart';
import 'package:to_do_list/Routes/routes_name.dart';
import '../Controller/home_controller.dart';
import '../Utils/text.dart';
import 'create_new_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    homeController.storeData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var confirmedExit = await Get.defaultDialog(
            buttonColor: AppColors.primary,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(25.h),
            confirm: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back(result: false);
                    },
                    child: textBlue15('Cancel')),
                GestureDetector(
                    onTap: () {
                      Get.back(result: true);
                    },
                    child: textRed15('Confirm')),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [textSecondary15('Are you sure you want to exit ?')],
            ));
        return confirmedExit ?? false;
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
                  onTap: () => Get.toNamed(RouteName.createNewTask),
                  child: const Icon(Icons.add)),
              SizedBox(width: 10.w),
              GestureDetector(
                  onTap: () => Get.toNamed(RouteName.setting),
                  child: const Icon(Icons.settings)),
              SizedBox(width: 10.w),
            ]),
        body: body(),
      ),
    );
  }

  Widget body() {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        color: Colors.grey[600],
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: homeController.taskData.isEmpty
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
                        Get.toNamed(RouteName.createNewTask);
                      },
                      child: textGreen24w500('Add a Task')),
                  SizedBox(height: 15.h)
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return taskRow(
                      homeController.taskData[index].toString(),
                      homeController.taskDate[index].toString(),
                      index,
                      homeController.taskBool[index] == 'true' ? true : false);
                },
                itemCount: homeController.taskData.length),
      );
    });
  }

  Widget taskRow(String txt, String date, index, bool bool) {
    return GestureDetector(
      onTap: () {
        if (homeController.taskBool[index] != 'true') {
          Get.defaultDialog(
              buttonColor: AppColors.primary,
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(25.h),
              confirm: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back(result: false);
                      },
                      child: textBlue15('Cancel')),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                        homeController.taskBool[index] = true;
                        homeController.storeData();
                      },
                      child: textRed15('Confirm')),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textSecondary15(
                      'Are you sure you want to mark this task as done ?')
                ],
              ));
        } else {
          Get.snackbar('You have already marked done this task',
              'Long press to delete or edit the task');
        }
      },
      onLongPress: () {
        Get.defaultDialog(
            buttonColor: AppColors.primary,
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.all(25.h),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.to(CreateNewTask(
                        editTitle: homeController.taskData[index].toString(),
                        editIndex: index,
                      ));
                    },
                    child: textBlue15('Edit Task')),
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
                                  onTap: () {
                                    Get.back();
                                    Get.back();
                                  },
                                  child: textBlue15('Cancel')),
                              GestureDetector(
                                  onTap: () {
                                    homeController.removeTask(index);
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
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 21.h,
              height: 21.h,
              decoration: ShapeDecoration(
                color: homeController.taskBool[index].toString() == 'true'
                    ? AppColors.secondary
                    : Colors.white,
                shape: const OvalBorder(
                  side: BorderSide(width: 0.8, color: Color(0xFFEE3764)),
                ),
              ),
              child: Center(
                  child: Icon(Icons.check_outlined,
                      size: 15.h, color: Colors.white)),
            ),
            SizedBox(width: 16.w),
            Flexible(
              flex: 4,
              child: Text(txt,
                  style: TextStyle(
                      decoration:
                          homeController.taskBool[index].toString() == 'true'
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      fontSize: 15.sp,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w400)),
            ),
            const Spacer(),
            Text(
              date,
              style: TextStyle(
                  decoration:
                      homeController.taskBool[index].toString() == 'true'
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  fontSize: 15.sp,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
