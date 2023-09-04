import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Routes/Utils/colors.dart';
import 'package:to_do_list/Routes/routes_name.dart';

import '../Routes/Utils/text.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          flexibleSpace: const Icon(Icons.abc),
          actionsIconTheme:
              IconThemeData(size: 30.sp, color: AppColors.secondary),
          actions: [
            GestureDetector(
                onTap: () => Get.offNamed(RouteName.createNewTask),
                child: const Icon(Icons.add))
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.h),
              child: textSecondary30w600('Task')),
        ),
        body: TabBarView(
          children: [tab1(), tab1()],
        ),
        bottomNavigationBar:
            TabBar(tabs: [textWhite16('Home'), textWhite16('Settings')]),
      ),
    );
  }

  Widget tab1() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 50.h),
          textWhite16(
              "You don't have any Tasks yet, press the 'Create Task' or '+' button to create one."),
          SizedBox(height: 15.h),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.primary)),
              onPressed: () {
                Get.offNamed(RouteName.createNewTask);
              },
              child: textGreen24w500('Add a Task'))
        ],
      ),
    );
  }
}
