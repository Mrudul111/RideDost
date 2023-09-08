import 'dart:convert'; // Import the 'dart:convert' library to handle JSON data
import 'package:http/http.dart' as http;
import 'package:token/dashboard.dart';
import '../login.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

String role = "";
Map<String, dynamic> decodedToken = JwtDecoder.decode(tkn!);
String uid = decodedToken['userId'];
final String apiUrl = "https://fierce-lime-pajamas.cyclic.app"; // Replace with your API URL
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
      // Remove the last character from the token
      role = token[token.length-1];
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

Future<http.Response> getAllCoupons(int page,String token) async {
  final String baseUrl = apiUrl;
  String url = "";

  if(role=='1'){
    url = 'https://fierce-lime-pajamas.cyclic.app/admin/coupons/admincoupon?page=${page}';
  }
  if(role=='2'){
    url = 'https://fierce-lime-pajamas.cyclic.app/admin/coupons/vendorcoupon?page=${page}';
  }
  if(role=='3'){
    url = 'https://fierce-lime-pajamas.cyclic.app/admin/coupons/usercoupon?page=${page}';
  }
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
Future<http.Response> approvedList(int page,String token) async {

   String url = "";

  if(role=='1'){
    url = 'https://fierce-lime-pajamas.cyclic.app/admin/admin/recieved/request?page=${page}';
  }
  if(role=='2'){
    url = 'https://fierce-lime-pajamas.cyclic.app/admin/vendor/recieved/request?page=${page}';
  }

  try {
    final http.Response response = await http.get(
      Uri.parse(url),
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
Future<http.Response> acceptRequest(String id, String token) async {// Replace with your base URL

  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/vendor/received/request/accept/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: jsonEncode(<String, dynamic>{}), // You can pass null or an empty object here
    );

    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> forwardRequest(String id, String token) async {
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app'; // Replace with your actual base URL
  final url = Uri.parse('$baseUrl/admin/forward/$id');

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
Future<http.Response> vendorAcceptRequest(String id, String token) async {// Replace with your base URL
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app';
  print(token);
  print(id);
  try {
    final response = await http.patch(
      Uri.parse('$baseUrl/admin/vendor/recieved/request/accept/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> adminReturn(String id, String token) async {// Replace with your base URL
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app';
  try {
    final response = await http.patch(
      Uri.parse('$baseUrl/admin/return/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: jsonEncode(<String, dynamic>{}), // You can pass null or an empty object here
    );

    return response;
  } catch (error) {
    throw error;
  }
}


Future<http.Response> paymentSettlement(int page,String token) async {

  String url = "";

  if(role=='1'){
    url = 'https://fierce-lime-pajamas.cyclic.app/paymentsettlement/payment-settlements?page=${page}';
  }
  if(role=='2'){
    url = 'https://fierce-lime-pajamas.cyclic.app/paymentsettlement/payment-settlements/vendor?page=${page}';
  }

  try {
    final http.Response response = await http.get(
      Uri.parse(url),
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

