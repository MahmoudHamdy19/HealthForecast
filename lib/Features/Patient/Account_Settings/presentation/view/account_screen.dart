
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Shared_preferences.dart';
import 'package:healthforecast/Features/Patient/Account_Settings/presentation/manger/profile_setting_controller.dart';
import 'package:healthforecast/Features/Patient/Account_Settings/presentation/view/edit%20healh.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Core/UI/showMyDialog.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/Assets Manager.dart';
import '../../../../../Core/Utils/Shared Methods.dart';
import '../widgets/forward_button.dart';
import '../widgets/setting_item.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;
  ProfileSettingController profileSettingController = Get.find<ProfileSettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Settings' , style: AppTextStyles.titleText.copyWith(
            fontSize: 22,
            color: AppColors.black
        ),),
        centerTitle: true,
      ),
      body: Obx(
        ()=> SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Account" , style: AppTextStyles.titleText.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black
                )
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(AssetsManager.heart, width: 70, height: 70),
                      const SizedBox(width: 20),
                       Expanded(
                         flex: 5,
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            profileSettingController.user.value.name??'',
                                style: AppTextStyles.titleText.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  overflow: TextOverflow.ellipsis
                                )
                            ),
                            const SizedBox(height: 10),
                             Text(
                                 profileSettingController.user.value.email??'',
                             style: AppTextStyles.subTitle.copyWith(
                               fontSize: 14
                             )
                            )
                          ],
                      ),
                       ),


                    ],
                  ),
                ),
                const SizedBox(height: 40),
                 Text(
                  "Settings", style: AppTextStyles.titleText.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.black
                )),

                const SizedBox(height: 20),
                SettingItem(
                  title: "Health File",
                  icon: Iconsax.folder,
                  bgColor: Colors.blue.shade100,
                  iconColor: Colors.blue,
                  onTap: () {
                    navigateTo(context, MedicalFileView());
                  },
                ),

                const SizedBox(height: 20),
                SettingItem(
                  title: "Log Out",
                  icon: Icons.output_sharp,
                  bgColor: Colors.red,
                  iconColor: Colors.white,
                  onTap: () {
                    showMyDialog(
                        context: context,
                        ontap: () {
                          signout(context)   ;                         },
                        message: "log out");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
