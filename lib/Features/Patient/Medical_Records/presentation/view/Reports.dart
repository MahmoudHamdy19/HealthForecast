 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Patient/Medical_Records/presentation/controller/article_controller.dart';
 import 'package:healthforecast/Features/Patient/Medical_Records/presentation/view/ReportDetails.dart';
import 'package:healthforecast/Features/Patient/Medical_Records/presentation/widgets/ReportsWidget.dart';

class ReportsScreen extends GetWidget<UserArticleController>{

  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medical Articles"),
      ),
      body: Obx(
        () => controller.isLoading.value? const Center(
          child: CircularProgressIndicator(),
        ) : ListView.builder(
            itemCount: controller.articles.length,
          itemBuilder: (context, index) {
              var article = controller.articles[index];
            return InkWell(
              onTap: () {
                navigateTo(
                  context,
                  ReportDetailsScreen(
                      name: article.name??'',
                      description:
                          article.description??'',
                      type:article.type??'',
                      date:article.date!,
                      deleteIcon: () {},
                      image:article.image!),
                );
              },
              child: ReportsWidget(
                  name: article.name??'',
            description:
            article.description??'',
            type:article.type??'',
            date:article.date!,
            deleteIcon: () {},
            image:article.image!, ),
            );
          },
        ),
      ),
    );
  }
}
