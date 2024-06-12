import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/Core Components.dart';


class ReportsWidget extends StatelessWidget {
  const ReportsWidget(
      {super.key,
        required this.name,
        required this.description,
        required this.type,
        required this.date,
        required this.deleteIcon,
        required this.image,
        this.price});

  final String name;
  final String image;
  final String? price;
  final String type;
  final String description;
  final DateTime date;
  final Function()? deleteIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: CustomCard(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        color: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "Report",
              child: Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 50,
                    backgroundImage: NetworkImage(
                      image,
                    ),
                  )),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.titleText.copyWith(fontSize: 20),
                  ),
                  Text(
                    type,
                    style: AppTextStyles.titleText
                        .copyWith(fontSize: 18, color: AppColors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      description,
                      maxLines: 2,
                      style: AppTextStyles.titleText2.copyWith(
                          fontSize: 17, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  price!=null
                      ? Text(
                    price!,
                    style: AppTextStyles.titleText4
                        .copyWith(fontSize: 18, color: AppColors.black),
                  )
                      : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMEd().format(date),
                        style: AppTextStyles.titleText2
                            .copyWith(fontSize: 16, ),
                      ),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
