import 'package:flutter/material.dart';
import 'package:task_tracker_intern/core/widgets/custom_bottom.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
// FIX: Changed to two levels up (../../) - adjust if your path is different


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ----------------------------------------
              // 1. Image/Illustration Area
              // ----------------------------------------
              Expanded(
                child: Center(
                  // Placeholder for the main illustration
                  child: Image.asset(
                    'assets/images/taskdo_welcome_illustration.png',
                    // Adjust height relative to screen for responsive layout
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ----------------------------------------
              // 2. Title and Description
              // ----------------------------------------
              const Text(
                'Taskdo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryText,
                ),
              ),

              const SizedBox(height: 10),

              // Descriptive Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Plan what you will do to be more organized for today, tomorrow and beyond',
                  textAlign: TextAlign.center,
                  style: AppStyles.secondaryBodyText.copyWith(fontSize: 14),
                ),
              ),

              const SizedBox(height: 50),

              // ----------------------------------------
              // 3. Action Buttons
              // ----------------------------------------
              // Login Button (Uses the Custom Gradient Button)
              CustomGradientButton(
                text: 'Login',
                onPressed: () {
                  // TODO: Navigate to Login Screen or Main Dashboard
                },
              ),

              const SizedBox(height: 15),

              // Sign Up Button (Text button with primary color)
              TextButton(
                onPressed: () {
                  // TODO: Navigate to Sign Up Screen
                },
                child: Text(
                  'Sign Up',
                  style: AppStyles.bodyText.copyWith(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.w600, // Matches the design's prominence
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}