import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/Model/jokes_model.dart';

class JokeApiController extends GetxController {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  JokesModel? _jokesApi;
  JokesModel? get jokesApi => _jokesApi;

  getApi() async {
    try {
      http.Response resp = await http
          .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
      var responseData = json.decode(resp.body);
      if (resp.statusCode == 200) {
        _jokesApi = JokesModel.fromJson(responseData);
        _isLoading = false;
        update();
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  reload() {
    _isLoading = true;
    getApi();
    update();
  }
}
