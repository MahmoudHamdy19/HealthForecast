
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthforecast/data/models/article_model.dart';
import 'package:healthforecast/data/models/medical_model.dart';
import 'package:healthforecast/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ApiClient {
  FirebaseAuth auth ;
  FirebaseFirestore firestore ;
  FirebaseStorage storage ;


  ApiClient(this.auth, this.firestore, this.storage);

  Future<void> register(UserModel user,String password) async{
     var response =  await auth.createUserWithEmailAndPassword(email: user.email!, password: password) ;
     user.uid = response.user!.uid;
     await firestore.collection("users").doc(response.user!.uid).set(user.toJson());
  }
  Future<void> logout() async{
   await auth.signOut();

  }

  Future<void> forgetPassword(String email)async{
  await auth.sendPasswordResetEmail(email: email);
  }
  Future<UserModel> login(String email,String password) async{
    var response = await auth.signInWithEmailAndPassword(email: email, password: password);
    var user = await firestore.collection("users").doc(response.user!.uid).get();
    return UserModel.fromJson(user.data()!);
  }

  Future<void> addArticle(ArticleModel articleModel , XFile file) async{
    var ref = storage.ref().child("articles/${file.name}");
    var response = await ref.putFile(File(file.path));
    var url = await response.ref.getDownloadURL();
    articleModel.image = url;
    await firestore.collection("articles").add(articleModel.toJson());
  }

  Future<List<ArticleModel>> getArticles() async{
    var response = await firestore.collection("articles").get();
    return response.docs.map((e) {
      var articleModel = ArticleModel.fromJson(e.data());
      articleModel.id = e.id;
      return articleModel;
    }).toList();
  }
  Future<void> deleteArticle(String id) async{
    await firestore.collection("articles").doc(id).delete();
  }
  Future<void> addMedical (MedicalModel medicalModel,XFile file) async{
    var ref = storage.ref(). child("medicals/${file.name}");
    var response = await ref.putFile(File(file.path));
    var url = await response.ref.getDownloadURL();
    medicalModel.image = url;
    await firestore.collection("medicals").add(medicalModel.toJson());
  }

  Future<List<MedicalModel>> getMedicals() async{
    var response = await firestore.collection("medicals").get();
    return response.docs.map((e) {
      var medicalModel = MedicalModel.fromJson(e.data());
      medicalModel.id = e.id;
      return medicalModel;
    }).toList();
  }
   Future<void> deleteMedical(String id) async{
    await firestore.collection("medicals").doc(id).delete();
   }

  Future<void> saveApiUrl (String url) async{
    await firestore.collection('Api').doc('0').set({'url': url});
  }

  Future<String> getApiUrl () async{
    var response = await firestore.collection('Api').doc('0').get();
    return response.data()!['url'];
  }
}