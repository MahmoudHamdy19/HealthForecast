import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Admin/AdminMedicationScreen/controller/medical_controller.dart';
import 'package:healthforecast/data/models/medical_model.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/Shared Methods.dart';
import '../../../AddItemsScreen/presentation/view/AddNewItem.dart';
import '../../../AdminArticlesScreen/widget/ArticlesContainer.dart';

class AdminMedicationScreen extends GetWidget<MedicalController> {
  const AdminMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(context, AddNewMedicalScreen());
          },
          tooltip: "Add New Medication",
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Iconsax.add,
            color: AppColors.white,
            size: 35,
          )),
      body: Obx(()=> SingleChildScrollView(
          child: controller.loading.value ? const Center(
            child: CircularProgressIndicator(),
          ): _body(),
        ),
      ),
    );
  }

  _body()=> ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: controller.medicals.length,
    itemBuilder: (context, index) {
      var item = controller.medicals[index];
      return ArticlesContainer(
        name: item.name ?? "",
        price: "${item.price} RS",
        description:item.description??'',
        type: item.type ?? "",
        date: item.date ?? DateTime.now(),
        deleteIcon: () {
          controller.deleteMedical(item.id ?? "");
        },
        image: item.image ?? "",
      );
    },
  );
}
