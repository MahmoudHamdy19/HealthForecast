 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/Login_Screen.dart';
 import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';

class SettingController extends GetxController {


  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();

  TextEditingController baseUrlController = TextEditingController();
  RxBool isLoading = false.obs;

  getApiUrl()async{
    isLoading.value = true;
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
    }, (r) {
      baseUrlController.text = r;
      isLoading.value = false;
    });
  }

  saveApiUrl()async{
    isLoading.value = true;
    (await remoteDataSource.saveApiUrl(baseUrlController.text)).fold((l) {
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
    }, (r) {
      isLoading.value = false;
    });
  }

  logOut()async{
    (await remoteDataSource.logout()).fold((l){

    }, (r){
      navigateAndFinished(Get.context, LoginScreen());
    });
  }


  @override
  void onInit() {
    getApiUrl();
    super.onInit();
  }
}