import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final List _taskData = [];
  List get taskData => _taskData;

  final List _taskDate = [];
  List get taskDate => _taskDate;

  final List _taskBool = [];
  List get taskBool => _taskBool;

  void storeData() async {
    final prefs = await SharedPreferences.getInstance();
    final taskDataAsStrings = _taskData.map((task) => task.toString()).toList();
    final taskDateAsStrings = _taskDate.map((task) => task.toString()).toList();
    final taskBoolasString = _taskBool.map((task) => task.toString()).toList();
    await prefs.setStringList('items', taskDataAsStrings);
    await prefs.setStringList('date', taskDateAsStrings);
    await prefs.setStringList('bool', taskBoolasString);
    update();
  }

  void addTask(String title, String date, bool bool) {
    _taskData.add(title);
    _taskDate.add(date);
    _taskBool.add(bool);
    storeData();
    update();
  }

  void removeTask(int index) {
    _taskData.removeAt(index);
    _taskDate.removeAt(index);
    _taskBool.removeAt(index);
    storeData();
    update();
  }

  void clearTask() {
    _taskData.clear();
    _taskDate.clear();
    _taskBool.clear();
    storeData();
    update();
  }
}
