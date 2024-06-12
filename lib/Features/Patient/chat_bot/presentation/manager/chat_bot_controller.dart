import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared_preferences.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/models/message_model.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

class ChatController extends GetxController {
  RxBool loading = false.obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;
  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  //String baseUrl = CacheHelper.getData("baseUrl");
  TextEditingController questionController = TextEditingController();

  List<MessageModel> get getMessages => messages.reversed.toList();

  gemini() async {
    loading.value = true;
    messages.add(
        MessageModel(message: questionController.text, isUserMessage: true));
    questionController.clear();

    (await remoteDataSource.getApiUrl()).fold((l) {
      Get.defaultDialog(
        title: "Error",
        content: Text(l.message),
        actions: [
          ElevatedButton(
            child: const Text("Ok"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
      loading.value = false;
    }, (baseUrl) async {
      (await remoteDataSource.gemini(baseUrl, questionController.text)).fold(
          (l) {
        Get.defaultDialog(
          title: "Error",
          middleText: l.message,
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          },
        );
        loading.value = false;
      }, (r) {
        messages.add(MessageModel(message: r, isUserMessage: false));
        loading.value = false;
      });
    });
  }
}
