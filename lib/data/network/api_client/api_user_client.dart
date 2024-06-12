import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthforecast/data/models/article_model.dart';
import 'package:healthforecast/data/models/medical_model.dart';
import 'package:healthforecast/data/models/medical_record.dart';
import 'package:healthforecast/data/models/user_model.dart';
import '../../models/diegnose_model.dart';
import 'package:http/http.dart' as http;

class ApiUserClient {
  FirebaseAuth auth ;
  FirebaseFirestore firestore ;

  ApiUserClient(this.auth, this.firestore);

  Future<UserModel> getProfile() async{
    var response = await firestore.collection("users").doc(auth.currentUser!.uid).get();
    return UserModel.fromJson(response.data()!);
  }

  Future<void> updateProfile(UserModel userModel) async{
    await firestore.collection("users").doc(auth.currentUser!.uid).update(userModel.toJson());
  }

  Future<List<ArticleModel>> getArticles() async{
    var response = await firestore.collection("articles").get();
    return response.docs.map((e) {
      var articleModel = ArticleModel.fromJson(e.data());
      articleModel.id = e.id;
      return articleModel;
    }).toList();
  }

  Future<List<MedicalModel>> getMedicals() async{
    var response = await firestore.collection("medicals").get();
    return response.docs.map((e) {
      var medicalModel = MedicalModel.fromJson(e.data());
      medicalModel.id = e.id;
      return medicalModel;
    }).toList();
  }

  Future<DiagnoseModel> diagnose(DiagnoseRequest body) async {
    final url = Uri.parse('${body.baseURl}/${body.isDiabetes?'diabetec':'heart'}'); // Construct the URL
    final response = await http.post(
      url,
      body: jsonEncode(body.toMap()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return DiagnoseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to diagnose: ${response.reasonPhrase}');
    }
  }

  Future<void> addMedical(MedicalRecord medical) async{
   await  firestore.collection("users").doc(auth.currentUser!.uid).collection("MedicalRecords").add(medical.toJson());
  }

  Future<List<MedicalRecord>> getMedicalRecords() async{
    return await firestore.collection("users").doc(auth.currentUser!.uid).collection("MedicalRecords").get().then((value) => value.docs.map((e) => MedicalRecord.fromJson(e.data())).toList());
  }

  Future<String> gemini(baseUrl,String question) async {
    final url = Uri.parse('$baseUrl/gemini'); // Construct the URL
    final response = await http.post(
      url,
      body: jsonEncode({
        'question': question,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'].toString();
    } else {
      throw Exception('Failed to diagnose: ${response.reasonPhrase}');
    }
  }

  Future<String> getApiUrl () async{
    var response = await firestore.collection('Api').doc('0').get();
    return response.data()!['url'];
  }

}

