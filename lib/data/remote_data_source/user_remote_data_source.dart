import 'package:dartz/dartz.dart';
import 'package:healthforecast/data/models/diegnose_model.dart';
import 'package:healthforecast/data/models/medical_record.dart';
 import 'package:healthforecast/data/network/api_client/api_user_client.dart';
import 'package:healthforecast/data/network/errors/error_handler.dart';
import '../models/article_model.dart';
import '../models/medical_model.dart';
import '../models/user_model.dart';
import '../network/errors/failure.dart';

abstract class UserRemoteDataSource {
   Future<Either<Failure,List<ArticleModel>>> getArticles();
   Future<Either<Failure,List<MedicalModel>>> getMedicals();
   Future<Either<Failure,UserModel>> getProfile();
   Future<Either<Failure,void>> updateProfile(UserModel userModel);
   Future<Either<Failure, DiagnoseModel>> diagnose(DiagnoseRequest body);
   Future<Either<Failure, String>> gemini(String baseUrl ,String question);
   Future<Either<Failure, List<MedicalRecord>>> getMedicalRecords();
   Future<Either<Failure,String>> getApiUrl();


}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  ApiUserClient apiClient ;
  UserRemoteDataSourceImpl(this.apiClient);



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
  Future<Either<Failure, List<MedicalModel>>> getMedicals() async{
    try{
      var response =await apiClient.getMedicals();
      return Right(response);
    } catch (e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async{
    try{
      var response = await apiClient.getProfile();
      return Right(response);
    }
    catch(e){
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(UserModel userModel)async{
    try {
      var response =await apiClient.updateProfile(userModel);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, DiagnoseModel>> diagnose(DiagnoseRequest body) async {
    try {
      var response = await apiClient.diagnose(body);
      await apiClient.addMedical(MedicalRecord(title: response.label, diagnose: response , date: DateTime.now()));
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }



  @override
  Future<Either<Failure, List<MedicalRecord>>> getMedicalRecords()async{
   try {
     var response = await apiClient.getMedicalRecords();
     return Right(response);
   } catch (e) {
     return Left(ErrorHandler.handle(e).failure);
   }
  }

  @override
  Future<Either<Failure, String>> gemini(String baseUrl,String question) async{
    try {
      var response = await apiClient.gemini(baseUrl,question);
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, String>> getApiUrl() async{
    try {
      var response = await apiClient.getApiUrl();
      return Right(response);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }


}