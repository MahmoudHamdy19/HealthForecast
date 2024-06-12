import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/manger/medical_record_controller.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/view/question/HealthAdvisorScreen.dart';
import 'package:healthforecast/Features/Patient/Medical_Records/presentation/view/Reports.dart';
import 'package:healthforecast/data/models/diegnose_model.dart';
import 'package:healthforecast/data/remote_data_source/user_remote_data_source.dart';

import '../../../../Admin/AddItemsScreen/presentation/view/AddNewItem.dart';

class QuestionController extends GetxController{
  Map<String, List<Map<String,dynamic>>> heartQuestionsWithOptions = {
    "What is the age of the patient?": [
      {"Less than 40 years":35},
      {"40-49 years":45},
      {"50-59 years":55},
      {"60 years and above":65}
    ],
    "What type of chest pain does the patient experience?": [
      {"Typical angina":3},
      {"Atypical angina":2},
      {"Non-anginal":1},
      {"Asymptomatic":0}
    ],
    "What is the patient's serum cholesterol level (in mg/dl)?": [
      {"Below 150 mg/dl":100},
      {"150-199 mg/dl":170},
      {"200-249 mg/dl":220},
      {"Above 250 mg/dl":300}
    ],
    "What is the maximum heart rate achieved by the patient?": [
      {'Below 100 bpm':90},
      {'100-119 bpm':110},
      {'120-139 bpm':130},
      {'Above 140 bpm':170}
    ],
    "Does the patient experience exercise-induced angina?": [
      {"Yes":1},
      {"No":0}
    ],
    "What is the ST depression induced by exercise relative to rest?": [
      {"Below -1":-2.6},
      {"-1 to 0":-1.3},
      {"0 to 1":0.9},
      {"Above 1":2.6}
    ],
    "Does the patient have a blood disorder called thalassemia?": [
      {"Normal":1},
      {"Reversible defect":2},
      {"Fixed defect":0}
    ]
  };
  Map<String,List<Map<String,dynamic>>> diabetesQuestionsWithOptions = {
    "What is the age of the patient?": [
      {"Less than 40 years":35},
      {"40-49 years":45},
      {"50-59 years":55},
      {"60 years and above":65}
    ],
    "Does the patient have a family history of diabetes?": [
      {"No":0},
      {"Yes":1}
    ],
    "Has the patient been diagnosed with high blood pressure?": [
      {"No":0},
      {"Yes":1}
    ],
    "What is the patient's Body Mass Index (BMI)?": [
      {"Below 18.5 (Underweight)":17} ,
      {"18.5-24.9 (Normal weight)":20},
      {"25-29.9 (Overweight)":27},
      {"Above 30 (Obese)":35}
    ],
    "How many hours does the patient sleep per day?": [
      {"Less than 6 hours":5},
      {"6-8 hours":7},
      {"8-10 hours":9},
      {"More than 10 hours":12}
    ],
    "Does the patient take regular medicines?": [
      {"No":0},
      {"Yes":1}
    ],
    "How often does the patient experience stress?": [
      {"Not at all":0},
      {"Slightly":1},
      {"Very often":2},
      {"Always":3}
    ],
    "What is the patient's blood pressure level?": [
      {"Low":0},
      {"Normal":1},
      {"High":2},
    ],
    "How many pregnancies has the patient had (for female patients)?": [
      {"None":0},
      {"1-2":1},
      {"3-4":3},
      {"5 or more":5}
    ],
    "Does the patient have prediabetes?": [
      {"No":0},
      {"Yes":1}
    ],
    "How often does the patient urinate?": [
      {"Not much":0},
      {"Quite often":1}
    ]
  };
/*  Map<String,List<Map<String,dynamic>>> fristQuestionsWithOptions = {
    "What Diagnose does the patient have?": [
      {"Diabetes":0},
      {"Heart Disease":1},
    ]
  };*/

  Map<String,List<Map<String,dynamic>>> fristQuestionsWithOptions = {
    "Have you experienced any chest pain or discomfort, especially during physical activity or stress?": [
      {"Yes":0},
      {"No":1},
    ],
    "Are you currently taking any medications for heart-related conditions?": [
      {"Yes":0},
      {"No":1},
    ],
    "Have you experienced frequent urination, especially at night?": [
      {"Yes":0},
      {"No":1},
    ],
    "Do you often feel thirsty, even after drinking fluids?": [
      {"Yes":0},
      {"No":1},
    ],
  };
  int scoreDiabetes = 0;
  int scoreHeart = 0;
  int scoreCount = 0;
  int calculateScore(int score) {
    if(scoreCount<2){
      scoreHeart += score;
    }else {
      scoreDiabetes += score;
    }
    scoreCount++;
    if(scoreCount>=4){
     if(scoreHeart<scoreDiabetes){
       return 1;
     } else {
       return 2;
     }
    }else{
      return 0;
    }
    
  }


  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  //String? baseURl = CacheHelper.getData('baseUrl');
  RxBool loading = false.obs ;

  int flag = 0 ;
  RxList<String> messages = <String>[].obs;
  List<String>  currentOptions = [] ;
  RxInt currentQui = 0.obs ;
  List<double> answers = [];

  RxList<Map<String,dynamic>>?  getCurrentOptions ;
   setAnswer(double answer) {
     if(flag!=0) {
       answers.add(answer);
     }
   }

   postAnswers()async{
     loading.value = true ;

     (await remoteDataSource.getApiUrl()).fold((l) {
       Get.defaultDialog(
         title: "Error",
         content: Text(l.message),
         actions: [
           ElevatedButton(
             child: const Text("Ok"),
             onPressed: () {
               Get.back();
             },
           )
         ],
       );
       loading.value = false;
     }, (baseURl) async {
       (await remoteDataSource.diagnose(DiagnoseRequest(answers: answers, baseURl: baseURl, isDiabetes: flag==1))).fold((l){
         showCustomDialog(ontap: (){},
             message: l.message);
       },(r){
         showCustomDialog(ontap: (){
           loading.value = false ;
           if(r.label=='Has UCI Heart Disease' || r.label=='Diabetic'){
             navigateAndReplace(Get.context!,HealthAdvisorScreen(type: flag==1?typeList[0]:flag==1?typeList[1]:typeList[2])) ;
           }else{
             navigateAndReplace(Get.context!,const ReportsScreen()) ;
           }
           Get.find<MedicalRecordController>().getMedicalRecords();
         }, message:
         r.label=='Diabetic'?'You are Diabetic':
         r.label=='Not Diabetic'? 'You are not Diabetic':
             r.label=='Has UCI Heart Disease'? 'You have Heart Disease' :
             'You have no Heart Disease'
         );
       }) ;
     });


   }

   @override
  void onInit() {
    super.onInit();
    messages.add(fristQuestionsWithOptions.keys.toList()[0]);
    getCurrentOptions = RxList<Map<String,dynamic>>(fristQuestionsWithOptions
     [fristQuestionsWithOptions.keys.toList()[0]]??[]);
  }

   @override
  void onReady() {
    super.onReady();
  }

  addMessage(String message) {
      messages.add(message);
  }

  getNextQuestion(String message) {
     addMessage(message);
    if(flag==0){
     /* if(messages[1]=='Diabetes') {
        flag = 1;
      }else{
         flag = 2;
      }*/

      addMessage(fristQuestionsWithOptions.keys.toList()[scoreCount]);
      getCurrentOptions?.value =  fristQuestionsWithOptions[fristQuestionsWithOptions.keys.toList()[scoreCount]]??[] ;
      flag = calculateScore(message=='Yes' ? 1 : 0);
    }
    else {
      currentQui.value++;
    }
      if(flag==1){
        if(currentQui.value == diabetesQuestionsWithOptions.keys.toList().length){
          getCurrentOptions?.value = [];
          print(answers) ;
          postAnswers();
        }else {
          addMessage(diabetesQuestionsWithOptions.keys.toList()[currentQui.value]);
          getCurrentOptions?.value =  diabetesQuestionsWithOptions[diabetesQuestionsWithOptions.keys.toList()[currentQui.value]]??[] ;
        }
      } else if(flag==2) {
        if(currentQui.value == heartQuestionsWithOptions.keys.toList().length){
          getCurrentOptions?.value = [];
          print(answers) ;
          postAnswers();
        }else {
          addMessage(heartQuestionsWithOptions.keys.toList()[currentQui.value]);
          getCurrentOptions?.value =  heartQuestionsWithOptions[heartQuestionsWithOptions.keys.toList()[currentQui.value]]??[];
        }
      }

    }

}