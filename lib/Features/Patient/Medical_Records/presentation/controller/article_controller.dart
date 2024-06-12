import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/data/models/article_model.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

class UserArticleController extends GetxController {
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  RxList<ArticleModel> articles = <ArticleModel>[].obs;
  RxBool isLoading = false.obs;
  getArticle()async{
    isLoading.value=true;
    (await userRemoteDataSource.getArticles()).fold((l) {
      isLoading.value=false;
      showCustomDialog(ontap: (){
        Get.back();
      }, message: l.message);
    }, (r) {
      articles.value=r;
      isLoading.value=false;
    });
  }

  @override
  void onInit() {
    getArticle();
    super.onInit();
  }

}