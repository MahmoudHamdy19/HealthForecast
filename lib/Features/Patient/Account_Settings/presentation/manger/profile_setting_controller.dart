import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/Core/Utils/Shared_preferences.dart';
import 'package:healthforecast/data/models/user_model.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

class ProfileSettingController extends GetxController {

  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>();
   RxBool isLoading = false.obs;
   RxBool baseUrlLoading = false.obs;
   Rx<UserModel> user = UserModel().obs;
  TextEditingController controllerBaseUrl  =   TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController heightController   = TextEditingController();
  TextEditingController weightController   = TextEditingController();
  TextEditingController bloodController    = TextEditingController();
  TextEditingController medicalAllergiesController = TextEditingController();
  TextEditingController medicalDiseasesController  = TextEditingController();

  getProfile() async{
    isLoading.value = true;
    (await userRemoteDataSource.getProfile()).fold((failure) {
      isLoading.value = false;
      showCustomDialog(ontap: (){
        Get.back();
      }, message: failure.message);
    }, (userModel) {
      user.value = userModel ;
      isLoading.value = false;
    });

  }

  updateProfile(DateTime dateTime) async{
    isLoading.value = true;
    var userModel = UserModel(
      uid: user.value.uid,
      age: user.value.age,
      email: user.value.email,
      name: fullNameController.text,
      healthInfo: HealthInfo(
        height: heightController.text,
        weight: weightController.text,
        bloodType: bloodController.text,
        medicalAllergies: medicalAllergiesController.text,
        medicalDiseases: medicalDiseasesController.text,
      ),
      personalInfo: PersonalInfo(
        idNumber: idNumberController.text,
        name: fullNameController.text,
        dateOfBirth: dateTime,
      )
    );
    (await userRemoteDataSource.updateProfile(userModel)).fold((failure) {
      isLoading.value = false;
      showCustomDialog(ontap: (){
        Get.back();
      }, message: failure.message);
    }, (userModel) {
      isLoading.value = false;
      showCustomDialog(ontap: (){}, message: 'Profile Updated Successfully');
    });
  }
  @override
  void onInit()async {
  await  getProfile();
     fullNameController.text = user.value.name!;
     idNumberController.text = user.value.personalInfo!.idNumber!;
     heightController.text = user.value.healthInfo!.height!;
     weightController.text = user.value.healthInfo!.weight!;
     bloodController.text = user.value.healthInfo!.bloodType!;
     medicalAllergiesController.text = user.value.healthInfo!.medicalAllergies!;
     medicalDiseasesController.text = user.value.healthInfo!.medicalDiseases!;
     controllerBaseUrl.text = CacheHelper.getData('baseUrl')??'';
    super.onInit();
  }

  setBaseUrl()async{
    baseUrlLoading.value = true;
    await  CacheHelper.saveData('baseUrl', controllerBaseUrl.text);
    Get.back();
    baseUrlLoading.value = false;
  }


}