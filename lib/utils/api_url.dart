class ApiUrl {
  //BASE URl
  static String baseUrl = "http://192.168.0.104:5000/api";
  static String backbaseUrl = "http://10.0.2.2:8000/api";

  //AUTHENTICATION
  static String popularBook = "$baseUrl/popular";
  static String allBook = "$baseUrl/books";
  static String recommend = "$baseUrl/recommend";
  static String login = "$backbaseUrl/auth/login";
  static String register = "$backbaseUrl/auth/register";
  static String comments = "$backbaseUrl/books/comments";
  static String getComments = "$backbaseUrl/books/getcomments";
}
