import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
 import 'package:healthforecast/Core/Utils/App%20Textstyle.dart';
import 'package:healthforecast/Features/Patient/Home/presentation/manger/question_controller.dart';
 import '../../../../../../Core/Utils/App Colors.dart';

class MedicalExaminationView extends StatelessWidget {
    MedicalExaminationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Examination',
          style: AppTextStyles.titleText
              .copyWith(fontSize: 22, color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body:GetBuilder<QuestionController>(
        init: QuestionController(),
          builder: (controller) => Obx(()=> controller.loading.value ? const Center(
              child: CircularProgressIndicator()
          )  :  Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      if(index%2 != 0){
                        return AnimationSenderItem(title:controller.messages.reversed.toList()[index]);
                      }
                      return AnimationItem(title: controller.messages.reversed.toList()[index]);
                    } ,
                    itemCount: controller.messages.length,
                  ),
                ) ,
                Wrap(
                    spacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      for(Map<String,dynamic> item in controller.getCurrentOptions??[])
                        ElevatedButton(onPressed: (){
                          controller.setAnswer(double.parse(item.values.first.toString()));
                          controller.getNextQuestion(item.keys.first) ;
                        },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white
                            ),
                            child: Text(item.keys.first)
                        ),
                    ]
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration:   InputDecoration(
                          hintText: 'Type your answer here',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: IconButton(onPressed: (){

                          }, icon: const Icon(Icons.send))
                      )
                  ),
                )
              ]
          ),)
        )
    );
  }
}

class AnimationItem extends StatefulWidget {
  String title;

  AnimationItem({super.key, required this.title});

  @override
  State<AnimationItem> createState() => _AnimationItemState();
}

class _AnimationItemState extends State<AnimationItem> {
  bool start = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 20), () {
      setState(() {
        start = false;
      }) ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              constraints: const BoxConstraints(
                maxWidth: 350,
              ) ,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              decoration:   BoxDecoration(
                gradient: LinearGradient(
                  colors: !start ? [
                    Colors.grey,
                    Colors.grey,
                  ] :  [
                    AppColors.primaryColor,
                    Colors.grey
                  ]
                ) ,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(0),
                  ),
                  color:Color(0xffdfdfdf)),
              child: Text(widget.title,
                style: AppTextStyles.subTitle.apply(
                    color: AppColors.black,
                    overflow: TextOverflow.visible
                ),
              )),
        ],
      ),
    );
  }
}

class AnimationSenderItem extends StatefulWidget {
  String title;
   AnimationSenderItem({super.key,required this.title});

  @override
  State<AnimationSenderItem> createState() => _AnimationSenderItemState();
}

class _AnimationSenderItemState extends State<AnimationSenderItem> {
  bool start = true;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 20), () {
      setState(() {
        start = false;
      }) ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              constraints: const BoxConstraints(
                maxWidth: 350,
              ) ,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              decoration:   BoxDecoration(
                  gradient: LinearGradient(
                      colors: !start ? [
                        AppColors.primaryColor,
                        AppColors.primaryColor,
                      ] :  [
                        AppColors.primaryColor,
                        Colors.grey
                      ]
                  ) ,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color:Color(0xffdfdfdf)),
              child: Text(widget.title,
                style: AppTextStyles.subTitle.apply(
                    color: AppColors.black,
                    overflow: TextOverflow.visible
                ),
              )),
        ],
      ),
    );
  }
}


