import 'package:get/get.dart';
import 'package:healthforecast/Features/Admin/AddItemsScreen/presentation/view/add_new_article.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

import '../../../../../data/models/medical_model.dart';

class MedicineController extends GetxController {

  RxBool isLoading = false.obs;

  RxList<MedicalModel> medicalsColon = <MedicalModel>[].obs;
  RxList<MedicalModel> medicalsDiabetes = <MedicalModel>[].obs;
  RxList<MedicalModel> medicalsHeart = <MedicalModel>[].obs;

  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();

  getMedicals()async{
    isLoading.value = true;
    (await remoteDataSource.getMedicals()).fold((l){
      isLoading.value = false;
    }, (r){
      medicalsColon.value = r ;
      medicalsDiabetes.value = r.where((element) => element.type!=typeList[1]).toList();
      medicalsHeart.value = r.where((element) => element.type!=typeList[0]).toList();
       isLoading.value = false;
    });
  }


  @override
  void onInit() {
    super.onInit();
    getMedicals();
  }




}