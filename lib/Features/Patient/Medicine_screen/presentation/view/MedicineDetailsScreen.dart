import 'package:flutter/material.dart';
import 'package:healthforecast/Core/Utils/App%20Textstyle.dart';

import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/Responsive.dart';

class MedicineDetailsScreen extends StatefulWidget {
  const MedicineDetailsScreen({super.key});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medical Reports',
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
                      tag: "Medical",
                      child: Center(
                          child: Image.network(
                        "https://i-cf65.ch-static.com/content/dam/cf-consumer-healthcare/panadol-reborn/en_IE/redesign/product-packshots/Panadol-Base-12s-(3D).png.rendition.380.463.png?auto=format",
                        width: MediaQueryHelper.sizeFromWidth(context, 1),
                        height: MediaQueryHelper.sizeFromHeight(context, 3),
                      )),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Panadol",
                              style:
                                  AppTextStyles.titleText.copyWith(fontSize: 22),
                            ),
                            Text(
                              "30 \$",
                              style: AppTextStyles.titleText4
                                  .copyWith(fontSize: 20, color: AppColors.black),
                            ),
                          ],
                        ),
                        Text(
                          "Heart treatment",
                          style: AppTextStyles.titleText
                              .copyWith(fontSize: 20, color: AppColors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Get effective pain relief with Panadol 500 mg Film-Coated Tablets, which releases its medicine up to 5x faster than standard paracetamol Panadol Extra Soluble tablets are used for fast pain relief of headaches, toothache, backache, rheumatic and muscle pains and period pain. It also relieves sore throat pain and the feverishness, aches and pains of colds and flu.",
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
