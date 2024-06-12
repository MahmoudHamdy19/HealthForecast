import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Admin/AdminArticlesScreen/controller/article_controller.dart';
import 'package:healthforecast/Features/Patient/Account_Settings/presentation/manger/profile_setting_controller.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/manger/question_controller.dart';
import 'package:healthforecast/Features/Patient/Medical_Records/presentation/controller/article_controller.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/manager/chat_bot_controller.dart';
import 'package:healthforecast/data/network/api_client/api_client.dart';
import 'package:healthforecast/data/network/api_client/api_user_client.dart';
import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

import '../../Features/Admin/AdminMedicationScreen/controller/medical_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Get.put(auth);
    Get.put(firestore);
    Get.put(storage);
    Get.put(ApiClient(Get.find(), Get.find(), Get.find()));
    Get.put(ApiUserClient(Get.find(), Get.find()));
    Get.put(RemoteDataSourceImpl(Get.find()));
    Get.put(UserRemoteDataSourceImpl(Get.find()));
  }
}

initMainBinding() {
  Get.put(ArticleController());
  Get.put(MedicalController());
}

initUserMainBinding() {
  Get.put(UserArticleController());
  Get.put(ProfileSettingController());
 // Get.put(ChatController());
  }



 class QuestionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionController) ;
   }

 }


