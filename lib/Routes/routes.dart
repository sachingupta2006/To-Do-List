import 'package:get/get.dart';
import 'package:to_do_list/View/dashboard.dart';
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
      ];
}
