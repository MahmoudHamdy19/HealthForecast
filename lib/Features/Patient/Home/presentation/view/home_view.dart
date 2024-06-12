import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Admin/AdminMedicationScreen/controller/medical_controller.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/manger/medical_record_controller.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/view/question/question.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/view/MedicalRecordsScreen.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/view/chatbot/Chatbot.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../manger/Medical_Bloc.dart';
import '../manger/Medical_States.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        Get.lazyPut(() => MedicalRecordController(),);
        return MedicalCubit();
      },
      child: BlocConsumer<MedicalCubit, MedicalStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MedicalCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              tooltip: 'Gemini',
              onPressed: () {
                navigateTo(context, const ChatBot());
              },
              child: const Icon(Icons.chat_outlined,
                  color: Colors.white, size: 25),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                Get.find<MedicalRecordController>().getMedicalRecords();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      const SizedBox(
                        height: 50,
                        width: 180,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: 280,
                            child: Text(
                              "Let us diagnose your condition !",
                              style: AppTextStyles.titleText3
                                  .copyWith(color: AppColors.black, fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff428DFC).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                           Column(
                             children: [
                               const SizedBox(height: 60.0,),
                               Container(
                                 decoration: const BoxDecoration(
                                   color: Colors.white,
                                   shape: BoxShape.circle,
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(20),
                                   child: SizedBox(
                                     height: 50,
                                     width: 50,
                                     child: Image.asset(
                                       cubit.categories[0].img,
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                            const SizedBox(height: 30.0,),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 3, 10, 2),
                                  child: InkWell(
                                    onTap: () {
                                      //الذهاب للاسئلة
                                      navigateTo(context,
                                            MedicalExaminationView());
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xff428DFC),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      height: 40.0,
                                      width:150,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceAround,
                                        children: [
                                          Text(
                                            'Diagnose',
                                            style: AppTextStyles
                                                .titleText4
                                                .copyWith(
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                      Text(' Medical Records', style: AppTextStyles.titleText4.copyWith(
                        fontSize: 24,
                        color: Colors.black87,
                      )),
                        const MedicalRecordsTab()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
