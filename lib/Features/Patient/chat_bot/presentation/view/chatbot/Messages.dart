import 'package:flutter/material.dart';
import 'package:healthforecast/Core/Utils/App%20Textstyle.dart';
import 'package:healthforecast/Features/Patient/chat_bot/presentation/models/message_model.dart';

import '../../../../../../Core/Utils/App Colors.dart';


class MessagesScreen extends StatelessWidget {
  List<MessageModel>?  messages;
    MessagesScreen({Key? key, required this.messages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        reverse: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: messages![index].isUserMessage!
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(
                            20,
                          ),
                          topRight: const Radius.circular(20),
                          bottomRight: Radius.circular(
                              messages![index].isUserMessage! ? 0 : 20),
                          topLeft: Radius.circular(
                              messages![index].isUserMessage!? 20 : 0),
                        ),
                        color:messages![index].isUserMessage!
                            ? AppColors.primaryColor
                            : const Color(0xffdfdfdf)),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(
                        messages![index].message!,
                      style: AppTextStyles.subTitle.apply(
                        color: messages![index].isUserMessage!
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    )),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: messages!.length);
  }
}
