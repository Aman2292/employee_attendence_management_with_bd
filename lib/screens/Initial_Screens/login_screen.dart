import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_dimensions.dart';
import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<Map<String, dynamic>> _login(String email, String password) async {
    print('Attempting login with email: $email'); // 🔍 Debug

    final url =
        Uri.parse('https://274c-103-175-135-69.ngrok-free.app/auth/login');
    print('Request URL: $url'); // 🔍 Debug

    final body = jsonEncode({'email': email, 'password': password});
    print('Request Body: $body'); // 🔍 Debug

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('Response Status Code: ${response.statusCode}'); // 🔍 Debug
    print('Response Body: ${response.body}'); // 🔍 Debug

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {'token': data['token'], 'user': data['user']};
    } else {
      final error = jsonDecode(response.body);
      return {'error': error['message'] ?? 'Login failed'};
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Iconsax.arrow_left_1),
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
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Your email',
                  prefixIcon: _iconWithDivider(Iconsax.sms),
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
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: _iconWithDivider(Iconsax.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.paddingS),

              // Remember Me & Forgot Password
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _rememberMe = !_rememberMe),
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.darkBackground),
                        color: _rememberMe
                            ? AppColors.buttonColor
                            : Colors.transparent,
                      ),
                      child: _rememberMe
                          ? const Icon(Icons.check,
                              size: 14, color: Colors.black)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Remember me", style: AppTextStyles.bodyRegular),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {}, // Forgot password logic
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.paddingM),

              // Connect Button
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeightL,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      _showErrorDialog('Please enter both email and password.');
                      return;
                    }

                    setState(() {
                      // You must make _isLoading mutable (non-final)
                    });

                    final result = await _login(email, password);

                    if (result.containsKey('error')) {
                      _showErrorDialog(result['error']);
                    } else {
                      // ✅ Navigate to HomePage on successful login
                      Navigator.pushNamed(
                        context,
                        '/home',
                        arguments: {
                          'name': result['user']['name'],
                          'role': result['user']['role']
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusL),
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

              const SizedBox(height: AppDimensions.paddingL),

              // Privacy and Sign Up
              Center(
                child: Column(
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
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        "Don't have an account? Sign up",
                        style: AppTextStyles.bodyRegular.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Only used in input fields
  Widget _iconWithDivider(IconData icon) {
    return Container(
      width: 55,
      padding: const EdgeInsets.only(left: 12, right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25),
          const VerticalDivider(
            thickness: 1,
            width: 8,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
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
