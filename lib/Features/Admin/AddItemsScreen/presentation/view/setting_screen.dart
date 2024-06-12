import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/App%20Colors.dart';
import 'package:healthforecast/Features/Admin/AddItemsScreen/presentation/manger/setting_controller.dart';

import '../../../../../Core/UI/showMyDialog.dart';

class SettingScreen  extends StatelessWidget {
  const SettingScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingController(),
      builder: (controller)=> Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ) ,
        body:   Center(
          child: Obx(
                ()=>controller.isLoading.value ?const CircularProgressIndicator() :SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text('You Must update api url every time you want to use it , You can find api url in the Google driver API file',style: TextStyle(
                      fontSize: 18 ,),textAlign: TextAlign.center,),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    controller: controller.baseUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Api url',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: Icon(Icons.link),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      controller.saveApiUrl();
                    },
                        style: ElevatedButton.styleFrom(backgroundColor:AppColors.primaryColor,foregroundColor: Colors.white) ,
                        child: const Text('Save')),
                  ),
                  const SizedBox(height: 20.0,),
                  // logout text button
                  ElevatedButton(onPressed: (){
                    showMyDialog(
                        context: context,
                        ontap: () {
                          controller.logOut();               },
                        message: "log out");
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white) ,
                      child: const Text('Logout'),),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
