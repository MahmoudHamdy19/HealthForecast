import 'package:dartz/dartz.dart';
import 'package:healthforecast/data/network/api_client/api_client.dart';
import 'package:healthforecast/data/network/errors/error_handler.dart';
import 'package:image_picker/image_picker.dart';

import '../models/article_model.dart';
import '../models/medical_model.dart';
import '../models/user_model.dart';
import '../network/errors/failure.dart';

abstract class RemoteDataSource {
  Future<Either<Failure,void>> register(UserModel user,String password);
  Future<Either<Failure,UserModel>> login(String email,String password);
  Future<Either<Failure,void>> logout();
  Future<Either<Failure,void>> addArticle(ArticleModel articleModel , XFile file);
  Future<Either<Failure,List<ArticleModel>>> getArticles();
  Future<Either<Failure,void>> deleteArticle(String id);
  Future<Either<Failure,void>> addMedical (MedicalModel medicalModel,XFile file);
  Future<Either<Failure,List<MedicalModel>>> getMedicals();
  Future<Either<Failure,void>> deleteMedical (String id);
  Future<Either<Failure,void>> saveApiUrl(String url);
  Future<Either<Failure,String>> getApiUrl();
  Future<Either<Failure,void>> forgetPassword(String email);

}

class RemoteDataSourceImpl implements RemoteDataSource {

  ApiClient apiClient ;
  RemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async{
   try{
     var response = await apiClient.login(email, password);
     return Right(response);
   }
   catch(e){
     return Left(ErrorHandler.handle(e).failure);
   }
  }

  @override
  Future<Either<Failure, void>> register(UserModel user, String password) async{
    try{
      var response = await apiClient.register(user, password);
      return Right(response);
    } catch(e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addArticle(ArticleModel articleModel, XFile file) async{
   try {
     var response =await apiClient.addArticle(articleModel, file);
     return Right(response);
     } catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() async{
    try {
      var response = await apiClient.getArticles();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }

  }

  @override
  Future<Either<Failure, void>> deleteArticle(String id) async{
   try {
     var response = await apiClient.deleteArticle(id);
     return Right(response);
   } catch (e) {
     return Left(ErrorHandler.handle(e).failure);
   }
  }

  @override
  Future<Either<Failure, void>> addMedical(MedicalModel medicalModel, XFile file) async{
    try {
      var response = await apiClient.addMedical(medicalModel, file);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedical(String id) async{
     try {
       var response =  await apiClient.deleteMedical(id);
       return Right(response);
     }  catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
  }

  @override
  Future<Either<Failure, List<MedicalModel>>> getMedicals() async{
   try{
     var response =await apiClient.getMedicals();
     return Right(response);
   } catch (e){
     return Left(ErrorHandler.handle(e).failure);
   }
  }

  @override
  Future<Either<Failure, String>> getApiUrl() async{
    try{
      var response =await apiClient.getApiUrl();
      return Right(response);
    } catch (e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> saveApiUrl(String url) async{
    try{
      var response =await apiClient.saveApiUrl(url);
      return Right(response);
    } catch (e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async{
    try{
      var response =await apiClient.logout();
      return Right(response);
    } catch (e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async{
    try{
      var response =await apiClient.forgetPassword(email);
      return Right(response);
    } catch (e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }
 
}