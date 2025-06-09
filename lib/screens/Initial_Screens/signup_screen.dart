import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedRole = "Employee";
  final List<String> _roles = ['Admin', 'Employee'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    print('Attempting signup with name: $name, email: $email'); // 🔍 Debug

    final url =
        Uri.parse('https://274c-103-175-135-69.ngrok-free.app/auth/signup');
    print('Request URL: $url'); // 🔍 Debug

    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'role': _selectedRole.toLowerCase()
    });
    print('Request Body: $body'); // 🔍 Debug

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Response Status Code: ${response.statusCode}'); // 🔍 Debug
      print('Response Body: ${response.body}'); // 🔍 Debug

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Signup successful: ${data['message']}'); // 🔍 Debug

        // Navigate to Login Screen
        Navigator.pushNamed(context, '/login');
      } else {
        final error = jsonDecode(response.body);
        _showErrorDialog(error['message'] ?? 'Signup failed');
      }
    } catch (e) {
      print('Error during signup: $e'); // 🔍 Debug
      _showErrorDialog('Something went wrong. Please try again.');
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
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Iconsax.arrow_left_1),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Title
                  Text("Sign Up", style: AppTextStyles.pageTitle),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text("Please fill the form to create your account.",
                      style: AppTextStyles.bodyRegular),
                  const SizedBox(height: AppDimensions.paddingL),

                  // Name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Iconsax.user),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Iconsax.sms),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Iconsax.lock),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    validator: (value) => value!.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Role Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    icon: const Icon(Iconsax.arrow_down_1),
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: const Icon(Iconsax.security_user),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusM),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    items: _roles
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingL),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeightL,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Form validated successfully'); // 🔍 Debug
                          _signup(); // Call signup function
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusL),
                        ),
                        elevation: 5, // Add shadow
                      ),
                      child:
                          Text("Sign Up", style: AppTextStyles.buttonPrimary),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),

                  // Navigate to Login
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
                  const SizedBox(height: AppDimensions.paddingL),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
