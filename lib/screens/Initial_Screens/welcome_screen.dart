import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_dimensions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: Column(
          children: [
            // Top Image Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimensions.radiusXXL),
                  bottomRight: Radius.circular(AppDimensions.radiusXXL ),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/welcome_screen_.png',
                  height: 500,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL),
              child: Text(
                'Welcome to UnSquare \n Attendence App.',
                style: AppTextStyles.pageTitle,
              ),
            ),

            const SizedBox(height: AppDimensions.paddingS),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL),
              child: Text(
                'Be Punctual to the working place.',
                style: AppTextStyles.bodyRegular,
              ),
            ),

            const Spacer(),

            // Log In Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL),
              child: SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightL,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusL),
                    ),
                  ),
                  child: Text('Log in', style: AppTextStyles.buttonPrimary),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingS),

            // Sign Up Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingL),
              child: SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightL,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    side: const BorderSide(color: AppColors.success),
                  ),
                  child: Text(
                    'Sign up',
                    style: AppTextStyles.buttonPrimary.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingL),
          ],
        ),
      ),
    );
  }
}
