import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String role = "Employee";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Iconsax.arrow_left),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Heading
                  Text("Sign up", style: AppTextStyles.pageTitle),

                  const SizedBox(height: AppDimensions.paddingS),
                  Text("Please fill the form to create an account.",
                      style: AppTextStyles.bodyRegular),

                  const SizedBox(height: AppDimensions.paddingL),

                  // Name
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Iconsax.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Email
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Iconsax.sms),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Password
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Iconsax.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Role (disabled dropdown)
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: const Icon(Iconsax.security_user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                    ),
                    child: Text(role),
                  ),

                  const SizedBox(height: AppDimensions.paddingL),

                  // Sign Up button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeightL,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                        ),
                      ),
                      child: Text("Sign Up", style: AppTextStyles.buttonPrimary),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Navigation to Login
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyRegular,
                          children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Log In",
                              style: AppTextStyles.bodyRegular.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
