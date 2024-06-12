import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/medical_model.dart';

class MedicalController  extends GetxController {

    RxBool loading = false.obs;
    RemoteDataSource  remoteDataSource = Get.find<RemoteDataSourceImpl>();
    RxList<MedicalModel> medicals = <MedicalModel>[].obs;

    addMedical(MedicalModel medicalModel) async{
      loading.value = true;
      (await remoteDataSource.addMedical(medicalModel,XFile(medicalModel.image!))).fold((l) {
        loading.value = false;
        showCustomDialog(ontap: () {}, message: l.message);
      }, (r){
        loading.value = false;
        getMedicals ();
         showCustomDialog(ontap: () {
          Get.back();
        }, message:'Medical added successfully');
      });
    }

    getMedicals () async {
      loading.value = true;
      (await remoteDataSource.getMedicals()).fold((l) {
        loading.value = false;
        showCustomDialog(ontap: () {
          Get.back();
        }, message: l.message);
      },(r) {
        medicals.value = r;
        loading.value = false;
      }) ;
    }

    deleteMedical (String id) async {
      (await remoteDataSource.deleteMedical(id)).fold((l) {
        showCustomDialog(ontap: () {
          Get.back();
        }, message: l.message);
      }, (r) {
        showCustomDialog(ontap: (){
          getMedicals();
        }, message: 'Medical deleted successfully');
      });
    }

    @override
    void onInit() {
      getMedicals();
      super.onInit();
    }

}