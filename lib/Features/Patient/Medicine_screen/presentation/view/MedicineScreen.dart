import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Patient/Medicine_screen/presentation/manager/medicine_controller.dart';

import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/Core Components.dart';
import '../../../../../Core/Utils/Shared Methods.dart';
import '../../../../../data/models/medical_model.dart';
import '../../../../Admin/AddItemsScreen/presentation/view/AddNewItem.dart';
import 'MedicineDetailsScreen.dart';


class MedicineScreen extends StatelessWidget {
  String type ;
   MedicineScreen({super.key,required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicineController>(
      init:MedicineController(),
        builder:(controller) =>Obx(() => controller.isLoading.value ? const Center(
          child: CircularProgressIndicator(),
        ):
        (type==typeList[0]? _body(controller.medicalsDiabetes):
        type==typeList[1]? _body(controller.medicalsHeart): _body(controller.medicalsColon)))
    );
  }
  _body(List<MedicalModel> list) =>ListView.builder(
    physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (context, index) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 24),
          child: InkWell(
            onTap: () {
              navigateTo(context, const MedicineDetailsScreen());
            },
            child: CustomCard(
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 20,
              ),
              color: Colors.grey.shade100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: "Medical",
                    child: Center(
                        child: CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: 50,
                          child: Image.network(
                           list[index].image??'',
                            fit: BoxFit.fill,

                          ),
                        )),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].name??'',
                          style:
                          AppTextStyles.titleText.copyWith(fontSize: 22),
                        ),
                        Text(
                         list[index].type??'',
                          style: AppTextStyles.titleText
                              .copyWith(fontSize: 20, color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            maxLines: 2,
                            list[index].description??'',
                            style: AppTextStyles.titleText2.copyWith(
                                fontSize: 17,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Text(
                         '\$${list[index].price??''}',
                          style:AppTextStyles.titleText4
                              .copyWith(fontSize: 18, color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    },
  );
}


