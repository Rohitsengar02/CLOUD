class AppConfig {
  static const String devBaseUrl = 'http://localhost:5001/api';
  static const String prodBaseUrl = 'https://urbanproxbackend.onrender.com/api';

  // Toggle this to switch environments
  static const bool isProduction = false;

  static String get baseUrl => isProduction ? prodBaseUrl : devBaseUrl;
}
