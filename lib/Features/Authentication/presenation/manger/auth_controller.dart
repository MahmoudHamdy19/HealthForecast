import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Admin/TapAdmin/presentation/view/tabs_screen.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/Login_Screen.dart';
import 'package:healthforecast/data/models/user_model.dart';
import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';

import '../../../../Core/di/di.dart';
import '../../../Patient/Home/presentation/view/tabs_screen.dart';
import '../view/verification_email.dart';

class AuthController extends GetxController {
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();
  RxBool loading = false.obs;
  login(String email , password )async{
    loading.value = true;
    (await remoteDataSource.login(
      email,
      password
    )).fold((l){
      loading.value = false;
      showCustomDialog(ontap:(){
        Get.back();
      }, message: l.message);
    }, (r) {
      loading.value = false;
      initMainBinding() ;
      if(r.isAdmin) {
        Get.offAll(const TabsAdminScreen());
      }else {
        initUserMainBinding() ;
        Get.offAll(const TabsScreen());

      }

    }
    );
  }

  register(UserModel userModel, password)async{
    loading.value = true;
    (await remoteDataSource.register(
        userModel,
      password
    )).fold((l){
      loading.value = false;
      showCustomDialog(ontap:(){
        Get.back();
      }, message: l.message);
    }, (r) {
      initMainBinding() ;
      loading.value = false;
      initUserMainBinding() ;
      Get.offAll(LoginScreen());
    }
    );
  }

  forgetPassword(String email)async{
    loading.value = true ;
    (await remoteDataSource.forgetPassword(email)).fold((l){
      loading.value = false ;
    }, (r){
      navigateTo(Get.context, VerificationEmailScreen());
      loading.value = false ;
    });

  }

}