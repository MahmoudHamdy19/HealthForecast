import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Admin/AdminArticlesScreen/controller/article_controller.dart';
import 'package:healthforecast/data/models/article_model.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../Core/Ui/primary_button.dart';
import '../../../../../../../Core/Utils/App Textstyle.dart';
import '../../../../../Core/Utils/App Colors.dart';
import '../../../../../Core/Utils/Core Components.dart';
import '../../../../../Core/Utils/Responsive.dart';
import '../../../../../Core/Utils/top_snackbars.dart';
import '../../widget/ChooseImageBottomSheet.dart';
import '../../widget/PictureSourceButton.dart';
import '../../widget/Select.dart';
import '../manger/patient_diagnosis_cubit.dart';

class AddNewArticleScreen extends StatefulWidget {

  const AddNewArticleScreen({
    super.key,
   });

  @override
  State<AddNewArticleScreen> createState() => _AddNewArticleScreenState();
}

class _AddNewArticleScreenState extends State<AddNewArticleScreen> {
  void _pickImage() async {
    final pickedImagePath = await const ChooseImageBottomSheet().show(context);
    print(pickedImagePath);
    if (pickedImagePath == null) return;
    setState(() => _pickedImagePath = pickedImagePath);
  }

  String? _pickedImagePath;
  String? _selectedType;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ArticleController articleController = Get.put(ArticleController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add New Article",
                style: AppTextStyles.titleText3
                    .copyWith(fontSize: 18, color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 40),
                  child: Column(
                    children: [
                      PictureSourceButton(
                        icon: Iconsax.camera,
                        label: 'upload / take picture',
                        onTap: _pickImage,
                      ),
                      const SizedBox(height: 30),
                      if (_pickedImagePath != null)
                        Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  File(_pickedImagePath!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      selectNameOrOrder(
                        selecteString: _selectedType,
                        ontap: () {
                          _openDropdownMenu(
                            context,
                          );
                        },
                        title: 'نوع المرض ',
                      ),
                      TextFieldTemplate(
                        name: 'Name',
                        controller: nameController,
                        label: 'Enter The Name',
                        leadingIconColor: AppColors.greenYellow,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Name ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFieldTemplate(
                          minLines: 15,
                          maxLines: null,
                          controller: descriptionController,
                          name: 'description',
                          label: 'Enter The Description',
                          leadingIconColor: AppColors.greenYellow,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Description';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        ()=> PrimaryButton(
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          label: 'Add',
                          isLoading: articleController.loading.value,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _pickedImagePath == null
                                  ? TopSnackbars().error(
                                      context: context,
                                      message:
                                          "You must choose or take a photo")
                                  : _selectedType == null
                                      ? TopSnackbars().error(
                                          context: context,
                                          message:
                                              "The type of disease must be selected")
                                      : {
                                          articleController.addArticle(ArticleModel(
                                           nameController.text,
                                          descriptionController.text,
                                              _selectedType,
                                              DateTime.now(),
                                              _pickedImagePath,)),
                                        };
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _openDropdownMenu(BuildContext context) async {
    final selectedItem = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.025 * MediaQueryHelper.sizeFromHeight(context, 1),
              ),
              Row(
                children: [
                  const Spacer(),
                  Container(
                    height: 6,
                    width: 0.15 * MediaQueryHelper.sizeFromWidth(context, 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.mediumGrey),
                  ),
                  const Spacer(),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: typeList.map((name) {
                  return ListTile(
                    title: Text(
                      name.toString(),
                      style: AppTextStyles.titleText2.copyWith(fontSize: 20),
                    ),
                    onTap: () {
                      print("name.id.toString()");
                      Navigator.pop(context, name.toString());
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );

    if (selectedItem != null) {
      setState(() {
        print(_selectedType);
        _selectedType = selectedItem;
      });
    }
  }
}

List<String> typeList = ["Diabetes", "Heart Disease", "Colon Disease"];
