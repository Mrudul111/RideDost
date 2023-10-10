import 'dart:convert'; // Import the 'dart:convert' library to handle JSON data
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
String tkn = '';
String role = "";
Map<String, dynamic> decodedToken = JwtDecoder.decode(tkn!);
String uid = decodedToken['userId'];
final String apiUrl = "https://token-web-backend.el.r.appspot.com"; // Replace with your API URL
Future<String?> Login(String number) async {
  try {

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
      tkn = responseData['token']; // Extract the 'token' from the response
      // Remove the last character from the token
      role = tkn[tkn.length-1];
      String modifiedToken = tkn.substring(0, tkn.length - 1);
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
Future<dynamic> getVendors(int page,String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/vendor?page=${page}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  } catch (error) {
    // print(error);
    print(error);
    throw(error);
    // throw error;
  }
}
Future<http.Response> getAllCoupons(int page,String token) async {
  final String baseUrl = apiUrl;
  String url = "";
  if(role=='1'){
    url = '$apiUrl/admin/coupons/admincoupon?page=${page}';
  }
  if(role=='2'){
    url = '$apiUrl/admin/coupons/vendorcoupon?page=${page}';
  }
  if(role=='3'){
    url = '$apiUrl/admin/coupons/usercoupon?page=${page}';
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
  final url = Uri.parse('$apiUrl/admin/settle/send/$couponCode');

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
    url = '$apiUrl/admin/admin/recieved/request?page=${page}';
  }
  if(role=='2'){
    url = '$apiUrl/admin/vendor/recieved/request?page=${page}';
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
Future<http.Response> acceptRequest(String id, String token) async {

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
  final url = Uri.parse('$apiUrl/admin/forward/$id');

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
      Uri.parse('$apiUrl/admin/vendor/recieved/request/accept/$id'),
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
      Uri.parse('$apiUrl/admin/return/$id'),
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
    url = '$apiUrl/paymentsettlement/payment-settlements?page=${page}';
  }
  if(role=='2'){
    url = '$apiUrl/paymentsettlement/payment-settlements/vendor?page=${page}';
  }
  else if(role=='3'){
    url = '$apiUrl/paymentsettlement/user/payment-settlements/?page=${page}';
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
Future<http.Response> getProfileInfo(String token) async {
  final String baseUrl = apiUrl;
  String url = "";

  if(role=='1'){
    url = '$baseUrl/admin/personalInfo';
  }
  if(role=='2'){
    url = '$baseUrl/vendor/personalInfo';
  }
  if(role=='3'){
    url = '$baseUrl/user/personalInfo';
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
Future<http.Response> updateInfo(Map<String, dynamic> userData,String token) async {// Replace with your base URL
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app';
  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/personalInfo/update'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: json.encode(userData), // You can pass null or an empty object here
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}

Future<http.Response> getReports(int page,String token) async {
  final String baseUrl = apiUrl;
  String url = '$apiUrl/admin/dailyreport/generate-csvfile?page=${page}';
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

Future<http.Response> approveVendor(String id, String token) async {

  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/approval/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: jsonEncode(<String, dynamic>{}), // You can pass null or an empty object here
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> rejectVendor(String id, String token, String reason) async {

  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/vendor/recieved/request/rejected/${id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },

      body: {"reject_region":reason}, // You can pass null or an empty object here
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
Future<dynamic> suspendVendor(int page,String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/admin/vendor/suspendedlist?page=${page}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  } catch (error) {
    // print(error);
    print(error);
    throw(error);
    // throw error;
  }
}
Future<http.Response> getProduct(int page,String id,String token) async {
  final String baseUrl = apiUrl;
  String url = "";

  if(role=='1'|| role=='2'){
    url = '$apiUrl/admin/product/${id}?page=${page}';
  }
  if(role=='3'){
    url = '$apiUrl/admin/product/get/user?page=${page}';
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
Future<http.Response> editProduct(Map<String,dynamic> userData,String token,String id) async {
  print(id);
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app';
  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/product/update/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: json.encode(userData), // You can pass null or an empty object here
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> deleteProduct(String token, String id) async {
  final String baseUrl = apiUrl; // Replace with your base URL

  try {
    final response = await http.delete(
      Uri.parse('$baseUrl/admin/product/delete/$id'),
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
Future<dynamic> pendingVendor(int page,String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/vendor/pending?page=${page}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  } catch (error) {
    // print(error);
    print(error);
    throw(error);
    // throw error;
  }
}
Future<dynamic> validVendor(int page,String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/vendor/valid?page=${page}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  } catch (error) {
    // print(error);
    print(error);
    throw(error);
    // throw error;
  }
}
Future<http.Response> newUser(Map<String, dynamic> userData) async {
  final baseUrl = 'https://fierce-lime-pajamas.cyclic.app/'; // Replace with your actual base URL
  final url = Uri.parse('${apiUrl}/user/register');
  try {
    final response = await http.post(
      url,

      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );
    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      tkn = responseBody['token'];
    }
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
 // Replace with your API URL

Future<bool> onLogin(String number) async {
  try {
    // Make the POST request
    final response = await http.post(Uri.parse("$apiUrl/admin/login/" + number));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      final responseBody = json.decode(response.body);
      print(response.statusCode);
      final token = responseBody['token'];
      tkn = token.substring(0, token.length - 1);
      print(tkn);
      role = token[token.length-1];
      print(role);
      return true;
    }
    else {
      return userLogin(number);
    }
  } catch (e) {
    return false;
  }
}
Future<bool> userLogin(String number) async {
  try {
    // Make the POST request
    final response = await http.post(Uri.parse("$apiUrl/user/login/" + number));
    print(response.body);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['token'] as String;
      tkn = token.substring(0, token.length - 1);
      role = token[token.length-1];
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
Future<http.Response> suspend(String id, String token) async {

  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/vendor/suspended/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type if needed
      },
      body: jsonEncode(<String, dynamic>{}), // You can pass null or an empty object here
    );
    print(response.body);
    return response;
  } catch (error) {
    throw error;
  }
}
Future<http.Response> chartData(String token) async {

  String url = "";

  if(role=='1'){
    url = '$apiUrl/admin/payment/week-data/amount/admin';
  }
  else if(role=='2'){
    url = '$apiUrl/admin/payment/coupon/week-data/vendor';
  }
  else {
    url = '$apiUrl/admin/payment/coupon/week-data/user';

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
Future<dynamic> rejectedVendor(int page,String token) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/admin/vendor/rejected/request?page=${page}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  } catch (error) {
    // print(error);
    print(error);
    throw(error);
    // throw error;
  }
}

Future<http.Response> rejectRequest(String id, String token, String reason) async {

  try {
    final response = await http.patch(
      Uri.parse('$apiUrl/admin/vendor/recieved/request/rejected/${id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },

      body: jsonEncode({"reject_region": reason}), // You can pass null or an empty object here
    );
    print(response.statusCode);
    return response;
  } catch (error) {
    throw error;
  }
}

