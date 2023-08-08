import 'dart:convert'; // Import the 'dart:convert' library to handle JSON data
import 'package:http/http.dart' as http;

final String apiUrl = "https://token-web-backend.el.r.appspot.com"; // Replace with your API URL

Future<bool> onLogin(String number) async {
  try {
    // Make the POST request
    final response = await http.post(Uri.parse(apiUrl + "/admin/login/" + number));

    if (response.statusCode == 200) {
      // Successful response, parse the data here
      final data = response.body;
      print(data);
      // final token = responseData['token']; // Extract the 'token' from the response
      // print("Token: $token");

      // Return the token (if needed in your application)
      return true;
    } else {
      // Handle other status codes, if needed
      print("Error: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  }
}