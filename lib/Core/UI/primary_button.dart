import 'package:flutter/material.dart';

import '../../Core/Utils/Core Components.dart';
import '../Utils/App Colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;
  final bool disabled;
  bool? isBorder;

  PrimaryButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.backgroundColor = AppColors.greenYellow,
      this.foregroundColor = AppColors.black,
      this.isLoading = false,
      this.disabled = false,
      this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(

        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          shadowColor: Colors.transparent,
          disabledBackgroundColor:backgroundColor,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child: isLoading
            ? LoadingWidget(
                type: LoadingType.threeBounce,
                color: foregroundColor,
                size: 18,
              )
            : Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: isBorder == true ? 17 : 18,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ),
              ),
      ),
    );
  }
}
