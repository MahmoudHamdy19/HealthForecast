import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../Core/Utils/App Colors.dart';
import '../../../../Core/Utils/App Textstyle.dart';

Widget selectNameOrOrder({
  required String? selecteString,
  required String? title,
  required Function()? ontap,
}) {
  print(selecteString);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mediumGrey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            selecteString == null
                ? const Text(
                    "ٍSelect the type of disease",
                    style: TextStyle(
                      color: AppColors.mediumGrey,
                      fontSize: 15,
                    ),
                  )
                : Text(selecteString,
                    style: AppTextStyles.titleText
                        .copyWith(fontSize: 15, color: AppColors.mediumGrey)),
            Icon(Iconsax.arrow_square_down),
          ],
        ),
      ),
    ),
  );
}
