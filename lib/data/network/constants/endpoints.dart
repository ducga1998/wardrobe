class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://localhost:5001";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";
  static const String login = baseUrl + "/api/v1/login";
  static const String register = baseUrl + "/api/v1/register";
  static const String logout = baseUrl + "/api/v1/logout";
}