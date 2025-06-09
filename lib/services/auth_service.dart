// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AuthService {
//   final storage = const FlutterSecureStorage();
//   final String baseUrl = 'https://274c-103-175-135-69.ngrok-free.app'; // Replace with your backend URL

//   Future<void> login(String email, String password) async {
//     final url = Uri.parse('$baseUrl/auth/login');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     final responseData = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       await storage.write(key: 'token', value: responseData['token']);
//       await storage.write(key: 'user_role', value: responseData['user']['role']);
//     } else {
//       throw Exception(responseData['error'] ?? 'Login failed');
//     }
//   }

//   Future<void> logout() async {
//     await storage.delete(key: 'token');
//     await storage.delete(key: 'user_role');
//   }

//   Future<String?> getToken() async {
//     return await storage.read(key: 'token');
//   }

//   Future<String?> getUserRole() async {
//     return await storage.read(key: 'user_role');
//   }
// }