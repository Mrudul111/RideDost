import 'dart:convert'; // Import the 'dart:convert' library to handle JSON data
import 'package:http/http.dart' as http;
import 'package:token/dashboard.dart';
import '../login.dart';

final String apiUrl = "https://token-web-backend.el.r.appspot.com"; // Replace with your API URL
Future<String?> Login(String number) async {
  try {
    // Make the POST request
    final response = await http.post(Uri.parse(apiUrl + "/admin/login/" + number));

    if (response.statusCode == 200) {
      // Successful response, parse the data here
      final responseData = jsonDecode(response.body); // Parse JSON response
      final token = responseData['token']; // Extract the 'token' from the response
      print("Token: $token");

      // Return the token (if needed in your application)
      return token;
    } else {
      // Handle other status codes, if needed
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}
Future<String?> Login2(String number) async {
  try {
    // Make the POST request
    final response = await http.post(Uri.parse(apiUrl + "/admin/login/" + number));

    if (response.statusCode == 200) {
      // Successful response, parse the data here
      final responseData = jsonDecode(response.body); // Parse JSON response
      final token = responseData['token']; // Extract the 'token' from the response
      print("Token before modification: $token");

      // Remove the last character from the token
      String modifiedToken = token.substring(0, token.length - 1);
      print("Modified Token: $modifiedToken");

      // Return the modified token (if needed in your application)
      return modifiedToken;
    } else {
      // Handle other status codes, if needed
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Error: $e");
    return null;
  }
}

Future<dynamic> getAllVendors(String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/vendor'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  } catch (error) {
    // print(error);
    print(error);
    return {'status': false};
    // throw error;
  }
}

Future<http.Response> getAllCoupons(String token) async {
  final String baseUrl = apiUrl; // Replace with your actual base URL
  final String url = '$baseUrl/admin/coupons';

  try {
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> sendRequest(String couponCode, String token) async {
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app/'; // Replace with your actual base URL
  final url = Uri.parse('$baseUrl/admin/settle/send/$couponCode');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}

// Future<void> handleSendRequest(String couponCode) async {
//   print(couponCode);
//
//   // Replace with your actual base URL
//   final baseUrl = 'YOUR_BASE_URL_HERE';
//   final url = Uri.parse('$baseUrl/admin/settle/send/$couponCode');
//   final token = tkn;
//
//   try {
//     final response = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       print(response.body);
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       final coupons = data['coupons'];
//
//       setCoupons(coupons);
//       fetchVendors();
//     }
//   } catch (error) {
//     print(error);
//   } finally {
//     dispatch(setFetching(false));
//   }
// }


