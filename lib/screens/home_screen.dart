import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_dimensions.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String userRole;

  const HomePage({
    super.key,
    required this.userName,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false, // No back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Greeting Icon
                const Icon(
                  Iconsax.user,
                  size: 80,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: AppDimensions.paddingM),

                // Welcome Message
                Text(
                  'Welcome, $userName!',
                  style: AppTextStyles.pageTitle.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.paddingS),

                // Role Display
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Text(
                    'Role: $userRole',
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingL),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  height: AppDimensions.buttonHeightL,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to login
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusL),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      "Logout",
                      style: AppTextStyles.buttonPrimary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}