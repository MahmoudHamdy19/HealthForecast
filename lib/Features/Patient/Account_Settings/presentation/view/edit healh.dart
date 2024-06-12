import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/Responsive.dart';
import 'package:healthforecast/Features/Patient/Account_Settings/presentation/manger/profile_setting_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../Core/UI/primary_button.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/Core Components.dart';

class MedicalFileView extends StatefulWidget {
  const MedicalFileView({Key? key}) : super(key: key);
  @override
  State<MedicalFileView> createState() => _MedicalFileViewState();
}

class _MedicalFileViewState extends State<MedicalFileView> {
  ProfileSettingController controller = Get.find<ProfileSettingController>();

  DateTime? _startDate;
  var myFormat = DateFormat('dd-MM-yyyy');
  DateTime? selectedDate = DateTime.now();
  TextEditingController startData = TextEditingController();
  @override
  void initState() {
    _startDate = controller.user.value.personalInfo?.dateOfBirth;
    startData.text =_startDate!=null? myFormat.format(_startDate!) : '';
     super.initState();
  }

  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical File',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form (
            key: _key,
            child: Column(
              children: [
                Row(children: <Widget>[
                  const Expanded(child: Divider()),
                  Text(
                    "Personal information",
                    style: AppTextStyles.titleText.copyWith(fontSize: 18),
                  ),
                  const Expanded(child: Divider()),
                ]),
                const SizedBox(
                  height: 20,
                ),
                TextFieldTemplate(
                  titel: "Full Name",
                  name: 'Full Name',
                  controller: controller.fullNameController,
                  label: 'Enter The Full Name',
                  leadingIconColor: AppColors.greenYellow,
                  enableFocusBorder: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Full Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldTemplate(
                  titel: "ID Number",
                  name: 'ID Number',
                  controller: controller.idNumberController,
                  label: 'Enter The ID Number',
                  leadingIconColor: AppColors.greenYellow,
                  enableFocusBorder: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your ID Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _selectStartDate(context);
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: TextFieldTemplate(
                      titel: "Date of birth",
                      name: 'Date of birth',
                      controller: startData,
                      label: 'Enter The ID Date of birth',
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      leadingIcon: Icons.date_range_outlined,
                      boolleadingIcon: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  const Expanded(child: Divider()),
                  Text(
                    "Health information",
                    style: AppTextStyles.titleText.copyWith(fontSize: 18),
                  ),
                  const Expanded(child: Divider()),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFieldTemplate(
                        titel: "height",
                        name: 'height',
                        controller: controller.heightController,
                        label: 'Enter The height',
                        leadingIconColor: AppColors.greenYellow,
                        enableFocusBorder: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your height';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFieldTemplate(
                        titel: "weight",
                        name: 'weight',
                        controller: controller.weightController,
                        label: 'Enter The weight',
                        leadingIconColor: AppColors.greenYellow,
                        enableFocusBorder: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your weight';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: MediaQueryHelper.sizeFromWidth(context, 2.3),
                    child: TextFieldTemplate(
                      titel: "blood type",
                      name: 'blood type',
                      controller: controller.bloodController,
                      label: 'Enter The blood type',
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your blood type';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldTemplate(
                  titel: " Medical Allergies",
                  name: ' Medical Allergies',
                  controller:controller. medicalAllergiesController,
                  label: 'Enter The  Medical Allergies',
                  leadingIconColor: AppColors.greenYellow,
                  enableFocusBorder: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your  Medical Allergies';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldTemplate(
                  titel: " Medical Diseases",
                  name: ' Medical Diseases',
                  controller: controller.medicalDiseasesController,
                  label: 'Enter The  Medical Diseases',
                  leadingIconColor: AppColors.greenYellow,
                  enableFocusBorder: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your  Medical Diseases';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Obx(
                    ()=> PrimaryButton(
                      isLoading: controller.isLoading.value,
                      label: 'Save Changes',
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        if(_key.currentState!.validate()){
                          controller.updateProfile(_startDate!);
                        }

                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        startData.text = myFormat.format(picked);
      });
    }
  }
}
