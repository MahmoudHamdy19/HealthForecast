import 'package:flutter/material.dart';
import 'package:healthforecast/Core/Utils/App%20Textstyle.dart';
import 'package:healthforecast/Core/Utils/Core%20Components.dart';
import 'package:healthforecast/Features/Patient/Medicine_screen/presentation/view/MedicineScreen.dart';
import '../../../../../../Core/Utils/App Colors.dart';

class HealthAdvisorScreen extends StatelessWidget {
   HealthAdvisorScreen({super.key, required this.type});
  String type ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Advisor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomCard(
                color: Colors.grey.shade100,
                child:   Column(
                  children: [
                    Text(
                      'You are diagnosed with $type we wish you a speedy recovery',
                      style: const TextStyle(fontSize: 24.0,color: AppColors.primaryColor,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please make sure to see your doctor',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Suggested medication :",
                    style: AppTextStyles.titleText.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black)),
              ),
            ),
            MedicineScreen(type: type,),
          ],
        ),
      ),
    );
  }
}
