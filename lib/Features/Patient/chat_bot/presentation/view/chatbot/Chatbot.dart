import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Core%20Components.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/manager/chat_bot_controller.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/view/chatbot/Messages.dart';
import '../../../../../../Core/Utils/App Colors.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gemini"),
      ),
      body: GetBuilder(
        init: ChatController(),
        builder: (controller) =>  Obx(
            ()=> Column(
            children: [
              Expanded(child: MessagesScreen(messages: controller.getMessages)),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 70,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Type a message to Gemini...',
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            controller: controller.questionController,
                          ),
                        ),
                      controller.loading.value?
                          const LoadingWidget()
                          :CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: IconButton(
                              icon: const Icon(
                                Icons.send_outlined,
                                color: AppColors.white,
                              ),
                              // iconSize: 25,

                              onPressed: (){
                                controller.gemini();
                              }),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
