import 'package:get/get.dart';
import 'package:to_do_list/View/create_new_task.dart';
import 'package:to_do_list/View/dashboard.dart';
import 'package:to_do_list/View/setting.dart';
import '../View/splashscreen.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.splashScreen,
            page: () => const SplashScreen(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.dashboard,
            page: () => const Dashboard(),
            transition: Transition.leftToRight),
        GetPage(
            name: RouteName.createNewTask,
            page: () => const CreateNewTask(),
            transition: Transition.downToUp),
        GetPage(
            name: RouteName.setting,
            page: () => const Setting(),
            transition: Transition.upToDown),
      ];
}
