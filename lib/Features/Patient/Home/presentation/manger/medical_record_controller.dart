import 'package:get/get.dart';
import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

import '../../../../../data/models/medical_record.dart';

class MedicalRecordController extends GetxController{

  RxBool isLoading = false.obs;

  RxInt currentTabIdx = 0.obs;


  RxList<MedicalRecord> medicals = <MedicalRecord>[].obs;
  RxList<MedicalRecord> medicalsPos = <MedicalRecord>[].obs;
  RxList<MedicalRecord> medicalsNag = <MedicalRecord>[].obs;

  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();





  void onTabChanged(int index) {
    if (index == currentTabIdx.value) return;
     currentTabIdx.value = index;
  }

  getMedicalRecords()async{
    isLoading.value = true;
    (await remoteDataSource.getMedicalRecords()).fold((l){
      isLoading.value = false;
    }, (r){

      medicals.value = r;
      medicalsPos.value = r.where((e) => !e.diagnose!.label.contains('Not')).toList();
      medicalsNag.value = r.where((e) => e.diagnose!.label.contains('Not')).toList();
      isLoading.value = false;
    }) ;
  }

  @override
  void onInit() {
    getMedicalRecords();
     super.onInit();
  }



}