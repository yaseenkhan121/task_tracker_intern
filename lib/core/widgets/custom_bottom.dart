import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;

  const CustomGradientButton({
    required this.text,
    required this.onPressed,
    this.height = 55,
    this.borderRadius = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      // The BoxDecoration applies the custom purple gradient and rounded corners
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [AppColors.primaryLightPurple, AppColors.primaryPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // Adds the required subtle shadow for a lifted effect
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        // Use Material widget with transparent color to allow InkWell ripple effects
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: Text(
              text,
              // Uses the white, semi-bold text style defined in AppStyles
              style: AppStyles.buttonText,
            ),
          ),
        ),
      ),
    );
  }
}