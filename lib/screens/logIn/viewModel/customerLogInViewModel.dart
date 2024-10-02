import 'package:cross_platform_application/screens/logIn/model/loginRequestModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CustomerLoginViewModel {
  Future<String?> login(LogInRequestModel myLogInRequestModel) async {
    final url = Uri.parse(
        "https://server.handiwork.com.ng/api/auth/login/customer"); // Replace with your API URL
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(myLogInRequestModel.toJson()),
      );

          if (response.statusCode == 200) {
            // Handle success (e.g., parse the token)
            final Map<String, dynamic> responseData = json.decode(response.body);
             return responseData['token'];

          } else {
            // Handle errors
            final Map<String, dynamic> errorData = json.decode(response.body);
            return errorData['error'] ?? 'Unknown error occurred'; // Adjust the key based on your API's error structure
            // print('Login failed, status code: ${response.statusCode}');
            // print('Error message: $errorMessage');
            // final Map<String, dynamic> responseData = json.decode(response.);
            // return responseData['error'];
          }
        } catch (e) {
          // Handle exceptions
          return 'No internet connection';
        }
      }

}