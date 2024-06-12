
import 'package:flutter/material.dart';
import '../../../../Core/Utils/App Textstyle.dart';
import '../../data/models/onBoarding_Model.dart';

class OnBoardingWidget extends StatelessWidget {
  final BoardingModel model;
  final double mediaQueryWidth;

  const OnBoardingWidget(this.model, this.mediaQueryWidth, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  model.image,
                  fit: BoxFit.fill,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        model.title,
                        style: AppTextStyles.titleText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.subtitle,
                  style: AppTextStyles.subTitle,
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 4,
          
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
