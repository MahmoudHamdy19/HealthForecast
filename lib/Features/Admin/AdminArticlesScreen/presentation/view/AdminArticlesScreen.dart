import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Admin/AddItemsScreen/presentation/view/add_new_article.dart';
import 'package:healthforecast/Features/Admin/AdminArticlesScreen/controller/article_controller.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/Login_Screen.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Core/UI/showMyDialog.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/Shared Methods.dart';
import '../../widget/ArticlesContainer.dart';

class AdminArticlesScreen extends GetWidget<ArticleController> {
  const AdminArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () {
                showMyDialog(
                    context: context,
                    ontap: () {
                      navigateAndFinished(context, LoginScreen());
                    },
                    message: "Log Out");
              },
              child: const Icon(
                Icons.output_sharp,
                color: AppColors.red,
                size: 25,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(
                context, const AddNewArticleScreen());
          },
          tooltip: "Add New Articles",
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Iconsax.add,
            color: AppColors.white,
            size: 35,
          )),
      body: Obx(()=>SingleChildScrollView(
          child: controller.loading.value ? const Center(
            child: CircularProgressIndicator(),
          ): _body(),
        ),
      ),
    );
  }

  _body()=>ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: controller.articles.length,
    itemBuilder: (context, index) {
      var article = controller.articles[index];
      return ArticlesContainer(
          name: article.name??'',
          description:
          article.description??'',
          type: article.type??'',
          date:article.date??DateTime.now(),
          deleteIcon: () {
            controller.deleteArticle(article.id??'');
          },
          image: article.image??'');
    },
  );
}

/***
 *
 *
 *  ArticlesContainer(
    name: "Effects of diabetes in women",
    description:
    "High blood sugar levels in the body affect the immune system’s ability to respond to pathogens such as bacteria, viruses, and fungi.",
    type: "Diabetes",
    date: DateTime.now(),
    deleteIcon: () {},
    image:
    "https://d14d5nk8lue86f.cloudfront.net/s3fs-public/styles/header_image/public/2017-10/10.16.17.Gestational%20Diabetes.CVD%20Risk.jpg?itok=xdZXylEm");
 *
 *
 *
 *
 *
 *
 * ****/
