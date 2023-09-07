import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/Controller/home_controller.dart';
import 'Routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList('items') ?? [];
    final taskList2 = prefs.getStringList('date') ?? [];
    final taskList3 = prefs.getStringList('bool') ?? [];
    homeController.taskData.assignAll(taskList);
    homeController.taskDate.assignAll(taskList2);
    homeController.taskBool.assignAll(taskList3);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => GetMaterialApp(
            title: 'To-Do List',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            getPages: AppRoutes.appRoutes()));
  }
}
