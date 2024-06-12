import 'package:flutter/material.dart';
import 'package:healthforecast/Core/Utils/App%20Textstyle.dart';

import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/Responsive.dart';

class ReportDetailsScreen extends StatefulWidget {
  const ReportDetailsScreen(
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
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Articles',
          style: AppTextStyles.titleText
              .copyWith(fontSize: 22, color: AppColors.black),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "Report",
                      child: Center(
                          child: Image.network(widget.image,
                            width: MediaQueryHelper.sizeFromWidth(context, 1),
                            height: MediaQueryHelper.sizeFromHeight(context, 3),
                          )),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                                                widget.name,
                          style:
                          AppTextStyles.titleText.copyWith(fontSize: 22),
                        ),
                        Text(
                            widget.type,
                          style: AppTextStyles.titleText
                              .copyWith(fontSize: 20, color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            widget.description,
                            style:
                            AppTextStyles.titleText2.copyWith(fontSize:20),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
