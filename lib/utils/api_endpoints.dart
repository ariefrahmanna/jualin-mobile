class ApiEndpoints {
  static final String ngrokUrl = 'https://8f8f-36-69-141-140.ngrok-free.app';  //change after running ngrok
  static final String baseUrl = '$ngrokUrl/api/';
  static AuthEndpoints authEndpoints = AuthEndpoints();
}

class AuthEndpoints {
  final String register = 'register';
  final String login = 'login';
}
