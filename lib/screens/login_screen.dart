import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppDimensions.paddingL),

              // Heading
              Text('Log in', style: AppTextStyles.pageTitle),

              const SizedBox(height: AppDimensions.paddingS),

              // Terms
              RichText(
                text: TextSpan(
                  text: 'By logging in, you agree to our ',
                  style: AppTextStyles.bodyRegular,
                  children: [
                    TextSpan(
                      text: 'Terms of Use.',
                      style: AppTextStyles.bodyRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Email field
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Your email',
                  prefixIcon: const Icon(Iconsax.sms),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingS),

              // Info text
              Text(
                'We will send you an e-mail with a login link.',
                style: AppTextStyles.bodySmall,
              ),

              const SizedBox(height: AppDimensions.paddingS),

              // Password field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Iconsax.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Connect Button
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightL,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                  ),
                  child: Text(
                    'Connect',
                    style: AppTextStyles.buttonPrimary,
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingL),

              // OR divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  const SizedBox(width: 8),
                  Text('Or', style: AppTextStyles.bodySmall),
                  const SizedBox(width: 8),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Google Sign In
              _socialLoginButton(
                icon: Iconsax.gallery,
                label: 'Sign in with Google',
                onTap: () {},
              ),

              const SizedBox(height: AppDimensions.paddingS),

              // Facebook Sign In
              _socialLoginButton(
                icon: Iconsax.activity,
                label: 'Sign in with Facebook',
                onTap: () {},
              ),

              const Spacer(),

              // Privacy and Sign Up
              Column(
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'For more information, please see our ',
                      style: AppTextStyles.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Privacy policy.',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Sign Up Screen
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: AppTextStyles.bodyRegular.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightL,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: AppColors.textDark),
        label: Text(label, style: AppTextStyles.bodyRegular),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
        ),
      ),
    );
  }
}
