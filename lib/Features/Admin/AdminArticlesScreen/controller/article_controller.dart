import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/data/models/article_model.dart';
import 'package:healthforecast/data/remote_data_source/remote_data_source.dart';
import 'package:image_picker/image_picker.dart';

class ArticleController extends GetxController {
  RxBool loading = false.obs;
  RemoteDataSource remoteDataSource = Get.find<RemoteDataSourceImpl>();
  RxList<ArticleModel> articles = <ArticleModel>[].obs;
  addArticle(ArticleModel articleModel) async{
    loading.value = true;
    (await remoteDataSource.addArticle(articleModel,XFile(articleModel.image!))).fold((l) {
      loading.value = false;
      showCustomDialog(ontap: () {

      }, message: l.message);
    }, (r){
      loading.value = false;
      getArticles();
      showCustomDialog(ontap: () {
        Get.back();
      }, message:'Article added successfully');
    });
  }

  getArticles() async {
    loading.value = true;
    (await remoteDataSource.getArticles()).fold((l) {
      loading.value = false;
      showCustomDialog(ontap: () {
        Get.back();
      }, message: l.message);
    },(r) {
      articles.value = r;
      loading.value = false;
    }) ;
  }

  deleteArticle(String id) async {
    (await remoteDataSource.deleteArticle(id)).fold((l) {
      showCustomDialog(ontap: () {
        Get.back();
      }, message: l.message);
    }, (r) {
      showCustomDialog(ontap: (){
        getArticles();
      }, message: 'Article deleted successfully');
    });
  }
  @override
  void onInit() {
    getArticles();
    super.onInit();
  }
}