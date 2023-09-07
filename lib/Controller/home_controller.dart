import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final List _taskData = [];
  List get taskData => _taskData;

  final List _taskDate = [];
  List get taskDate => _taskDate;

  void storeData() async {
    final prefs = await SharedPreferences.getInstance();
    final taskDataAsStrings = _taskData.map((task) => task.toString()).toList();
    final taskDateAsStrings = _taskDate.map((task) => task.toString()).toList();
    await prefs.setStringList('items', taskDataAsStrings);
    await prefs.setStringList('date', taskDateAsStrings);
    update();
  }

  void addTask(String title, String date) {
    _taskData.add(title);
    _taskDate.add(date);
    storeData();
    update();
  }

  void removeTask(int index) {
    _taskData.removeAt(index);
    _taskDate.removeAt(index);
    storeData();
    update();
  }
}
