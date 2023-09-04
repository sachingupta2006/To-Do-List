import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Routes/Utils/colors.dart';
import 'package:to_do_list/Routes/Utils/home_controller.dart';
import 'package:to_do_list/Routes/routes_name.dart';
import '../Routes/Utils/text.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final HomeController homeController = Get.put(HomeController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
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
    return Column(
      children: [
        SizedBox(height: 15.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textSecondary30w600('Task'),
              GestureDetector(
                  onTap: () => Get.offNamed(RouteName.createNewTask),
                  child:
                      Icon(Icons.add, size: 30.sp, color: AppColors.secondary))
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () => Container(
              color: Colors.grey[600],
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: HomeController().taskData.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 50.h),
                            textWhite16Center(
                                "You don't have any Tasks yet, press the 'Create Task' or '+' button to create one."),
                            SizedBox(height: 150.h),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors.primary)),
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
                                child: textWhite16(HomeController().taskData[index].toString()));
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          itemCount: HomeController().taskData.length)),
            ),
          ),
        ),
      ],
    );
  }
}
