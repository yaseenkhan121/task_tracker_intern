import 'package:flutter/material.dart';
import 'package:task_tracker_intern/core/widgets/custom_bottom.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Reusable text input field component
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: AppStyles.bodyText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.secondaryBodyText,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: AppColors.secondaryText),
          // Add toggle visibility for password
          suffixIcon: isPassword
              ? IconButton(
            icon: const Icon(Icons.visibility_off_outlined, color: AppColors.secondaryText),
            onPressed: () {
              // TODO: Implement password visibility toggle state
            },
          )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText),
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to WelcomeScreen
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Welcome Back',
                      style: AppStyles.heading1.copyWith(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sign in to access your awesome tasks and projects.',
                      style: AppStyles.secondaryBodyText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),

                    // --- Form Inputs ---
                    _buildTextField(
                      hintText: 'Email',
                      icon: Icons.mail_outline,
                    ),
                    _buildTextField(
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to Forgot Password screen
                          debugPrint('Forgot Password tapped');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppStyles.secondaryBodyText.copyWith(
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Login Button (Custom Gradient Button)
                    CustomGradientButton(
                      text: 'Login',
                      onPressed: () {
                        // TODO: Implement login logic
                        // After successful login, navigate to MainDashboard:
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                    ),

                    const SizedBox(height: 30),

                    // Divider or 'Or' section (Optional, but common in login flows)
                    const Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.secondaryText)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('OR', style: AppStyles.secondaryBodyText),
                        ),
                        Expanded(child: Divider(color: AppColors.secondaryText)),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to Sign Up Screen
                            debugPrint('Navigate to Sign Up');
                          },
                          child: Text(
                            "Sign Up",
                            style: AppStyles.bodyText.copyWith(
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}