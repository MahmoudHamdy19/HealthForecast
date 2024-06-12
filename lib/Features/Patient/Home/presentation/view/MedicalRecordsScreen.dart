import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Admin/AddItemsScreen/presentation/view/add_new_article.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/manger/medical_record_controller.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/view/question/HealthAdvisorScreen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/Assets Manager.dart';
import '../../../../../Core/Utils/Core Components.dart';
import '../../../../../Core/Utils/Responsive.dart';

class MedicalRecordsTab extends GetWidget<MedicalRecordController> {
  const MedicalRecordsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>controller.isLoading.value? const Center(
        child: CircularProgressIndicator(),
      ) : Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.91,
            child: CustomTabBar(
              itemPadding: const EdgeInsets.all(12),
              backgroundColor: AppColors.grey,
              disableShadow: true,
              tabs: const [
                'Positive Cases',
                'Negative Cases',
              ],
              selectedIndex:controller.currentTabIdx.value,
              onTabChanged: controller.onTabChanged,
            ),
          ),
          controller.currentTabIdx.value == 0
              ?ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.medicalsPos.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child:CustomCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 20,
                          ),
                          color: Colors.grey.shade100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Image.asset(
                                AssetsManager.heart,
                                width: MediaQueryHelper.sizeFromWidth(context, 6),
                                height: 60,
                              )),
                              const SizedBox(width: 22),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.medicalsPos[index].title??'',
                                      style: AppTextStyles.titleText
                                          .copyWith(fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        "By answering the questions, you ${controller.medicalsPos[index].diagnose?.label} ",
                                        style: AppTextStyles.titleText2
                                            .copyWith(fontSize: 17),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat.yMEd()
                                              .format(controller.medicalsPos[index].date??DateTime.now()),
                                          style: AppTextStyles.titleText2
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColors.black),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            navigateTo(
                                                context, HealthAdvisorScreen(type:controller.medicalsPos[index].title!.contains('Diabetic')?typeList[0]:
                                            controller.medicalsPos[index].title!.contains('Heart')?typeList[1]:typeList[2],));
                                          },
                                          child: const Icon(
                                            Iconsax.arrow_circle_right,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
              );
            },
          ) :ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.medicalsNag.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child:CustomCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 20,
                    ),
                    color: Colors.grey.shade100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                              AssetsManager.heart,
                              width: MediaQueryHelper.sizeFromWidth(context, 6),
                              height: 60,
                            )),
                        const SizedBox(width: 22),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.medicalsNag[index].title??'',
                                style: AppTextStyles.titleText
                                    .copyWith(fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0),
                                child: Text(
                                  "By answering the questions, you ${controller.medicalsNag[index].title}",
                                  style: AppTextStyles.titleText2
                                      .copyWith(fontSize: 17),
                                ),
                              ),
                              Text(
                                DateFormat.yMEd().format(controller.medicalsNag[index].date??DateTime.now()),
                                style: AppTextStyles.titleText2.copyWith(
                                    fontSize: 16, color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              );
            },
          )
        ],
      ),
    );
  }
}
