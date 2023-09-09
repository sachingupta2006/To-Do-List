import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Controller/joke_api_controller.dart';
import 'package:to_do_list/Utils/text.dart';

import '../../Utils/colors.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  JokeApiController getApiController = Get.put(JokeApiController());
  @override
  void initState() {
    super.initState();
    getApiController.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: textSecondary30w600('Jokes API'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> getApiController.reload(),
        child: const Icon(Icons.refresh),
      ),
      body: GetBuilder<JokeApiController>(
        builder: (controller) {
          return getApiController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Column(
                    children: [
                      textBlue15('${getApiController.jokesApi!.id}'),
                      textBlue15('${getApiController.jokesApi!.setup}'),
                      textBlue15('${getApiController.jokesApi!.punchline}'),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
