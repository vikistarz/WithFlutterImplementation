class LogInRequestModel {
  final String emailOrPhone;
  final String password;

  LogInRequestModel({required this.emailOrPhone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'emailOrPhone': emailOrPhone,
      'password': password,
    };
  }
}