import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/colors.dart';
import 'package:to_do_list/Routes/routes_name.dart';
import '../Utils/text.dart';

var taskData = [].obs;
var taskDate = [].obs;

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              SizedBox(width: 10.w)
            ]),
        body: TabBarView(
          children: [tab1(), tab1()],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            TabBar(
                tabs: [textWhite16('Home'), textWhite16('Settings')],
                indicatorColor: Colors.transparent),
            SizedBox(height: 10.h)
          ],
        ),
      ),
    );
  }

  Widget tab1() {
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
                  return Container(
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWhite16(taskData[index].toString()),
                          textWhite16(taskDate[index].toString()),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: taskData.length),
      ),
    );
  }
}
