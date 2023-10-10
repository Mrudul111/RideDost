import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:token/api/jsonAPI.dart';
import 'dashboard.dart';
RegExp indianPhoneNumber = RegExp(r'^(91-|0)?[6-9]\d{9}$');
RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);


Map<String, dynamic> userData = {
  'companyName': '',
  'companyOwner': '',
  'name': '',
  'phoneNumber': '',
  'email': '',
  'presentageValue': '',
  'id_proof': '',
  'companyLogo': '',
  'address': '',
  'thresholdvalue': '',
};
bool isSuccesfull = false;

class AddVendor extends StatefulWidget {
  const AddVendor({Key? key}) : super(key: key);

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  final _key = GlobalKey<FormState>();
  bool url_change = false;
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SnackBar(
            content: Text(
              'Product is added'
            )
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F2F2),
        iconTheme: IconThemeData(
          color: Color(0xff133039),
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buisness Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: "DM Sans",
                    color: Color(0xff0f172a),
                  ),
                ),
                SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },


                            onSaved: (newValue) {
                              userData['companyName'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Company Name",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Company Owner",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },

                            onSaved: (newValue) {
                              userData['companyOwner'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Company Owner",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company Logo",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 70,
                          child: GestureDetector(
                            onTap: () async {
                              final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                String path = pickedImage.path;
                                Future<void> uploadImage(String imagePath) async {
                                  final cloudName = 'dlrgh9gam';
                                  final apiKey = '254299893452357';
                                  final apiSecret = '4mZorIis9DEEdRy2MkrqO-6lapo';

                                  final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

                                  final request = http.MultipartRequest('POST', uri)
                                    ..fields['upload_preset'] = 'imageridedost'
                                    ..headers['Authorization'] = 'Basic ${base64Encode('$apiKey:$apiSecret'.codeUnits)}'
                                    ..files.add(await http.MultipartFile.fromPath('file', imagePath));

                                  final response = await request.send();
                                  final responseBody = await response.stream.bytesToString();

                                  if (response.statusCode == 200) {
                                    print('Image uploaded successfully: $responseBody');
                                    Map<String, dynamic> parsedResponse = json.decode(responseBody);
                                    setState(() {
                                      userData['companyLogo'] = parsedResponse['secure_url'];
                                      url_change = true;
                                    });
                                  } else {
                                    print('Image upload failed. Status code: ${response.statusCode}, Response: $responseBody');
                                  }
                                }
                                uploadImage(path);
                              }
                            },
                            child: url_change
                                ? Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff5f8fb),
                                border: Border.all(color: Color(0xffcbd5e1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Uploaded",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Color(0xff64748b),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.upload,
                                      size: 18,
                                      color: Color(0xff5d6b98),
                                    ),
                                  )
                                ],
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff5f8fb),
                                border: Border.all(color: Color(0xffcbd5e1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Choose file",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Color(0xff64748b),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.upload,
                                      size: 18,
                                      color: Color(0xff5d6b98),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Percentage",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },

                            onSaved: (newValue) {
                              userData['presentageValue'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Percentage",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Coupon Threshold",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },
                            onSaved: (value){
                              userData['thresholdvalue'] = value;
                            },

                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Coupon Threshold",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 309,
                          height: 86,
                          child: TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },
                            onSaved:(value){
                              userData['address'] = value;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),

                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Address",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            if (_key.currentState!.validate()) {
                              _key.currentState?.save();
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => OwnerDetails()));
                            }
                          },
                          child: Container(
                            height: 58,
                            width: 245,
                            decoration: BoxDecoration(
                              color: Color(0xff3574f2),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "next",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: "DM Sans",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class OwnerDetails extends StatefulWidget {
  const OwnerDetails({Key? key}) : super(key: key);

  @override
  State<OwnerDetails> createState() => _OwnerDetailsState();
}

class _OwnerDetailsState extends State<OwnerDetails> {
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool url_change  = false;
  Future<http.Response> addVendor(Map<String, dynamic> userData, String token) async {
    final String baseUrl = apiUrl;
    final Uri uri = Uri.parse(baseUrl + '/admin/add');
    print(userData);
    try {
      final http.Response response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(userData), // Use the userData directly as the body
      );
      if(response.statusCode==201){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added Vendor Successfully',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vendor add Unsuccessfully',style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ),
        );
      }
      return response;

    } catch (error) {
      throw error;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF2F2F2),
        iconTheme: IconThemeData(
          color: Color(0xff133039),
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Owner Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: "DM Sans",
                    color: Color(0xff0f172a),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              userData['name'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Full Name",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID Proof",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 309,
                          height: 46.3,
                          child: GestureDetector(
                            onTap: () async {
                              final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                String url = "";
                                String path = pickedImage.path;
                                Future<void> uploadImage(String imagePath) async {
                                  final cloudName = 'dlrgh9gam';
                                  final apiKey = '254299893452357';
                                  final apiSecret = '4mZorIis9DEEdRy2MkrqO-6lapo';

                                  final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

                                  final request = http.MultipartRequest('POST', uri)
                                    ..fields['upload_preset'] = 'imageridedost'
                                    ..headers['Authorization'] = 'Basic ${base64Encode('$apiKey:$apiSecret'.codeUnits)}'
                                    ..files.add(await http.MultipartFile.fromPath('file', imagePath));

                                  final response = await request.send();
                                  final responseBody = await response.stream.bytesToString();

                                  if (response.statusCode == 200) {
                                    print('Image uploaded successfully: $responseBody');
                                    Map<String, dynamic> parsedResponse = json.decode(responseBody);
                                    setState(() {
                                      userData['id_proof'] = parsedResponse['secure_url'];
                                      url_change = true; // Add this variable to track if the ID proof is uploaded
                                    });
                                  } else {
                                    print('Image upload failed. Status code: ${response.statusCode}, Response: $responseBody');
                                  }
                                }
                                uploadImage(path);
                              }
                            },
                            child: url_change
                                ? Container(
                              // Display the "Uploaded" container
                              decoration: BoxDecoration(
                                color: Color(0xfff5f8fb),
                                border: Border.all(color: Color(0xffcbd5e1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "ID Proof Uploaded",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Color(0xff64748b),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 18,
                                      color: Colors.green, // Change the color to indicate success
                                    ),
                                  )
                                ],
                              ),
                            )
                                : Container(
                              // Display the "ID Proof" container
                              decoration: BoxDecoration(
                                color: Color(0xfff5f8fb),
                                border: Border.all(color: Color(0xffcbd5e1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "ID Proof",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Color(0xff64748b),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.upload,
                                      size: 18,
                                      color: Color(0xff5d6b98),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        ,
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              if(!indianPhoneNumber.hasMatch(value)){
                                return 'Please add a valid number';
                              }

                              return null;
                            },
                            onSaved: (newValue) {
                              userData['phoneNumber'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "+91 5245XXXX74",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email ID",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            fontFamily: "DM Sans",
                            color: Color(0xff0f172a),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 309,
                          height: 70,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              if(!emailRegex.hasMatch(value)){
                                return 'Enter valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              userData['email'] = newValue;
                            },
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff5f8fb),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.9, color: Color(0xffcbd5e1)),
                                ),
                                hintText: "Email ID",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff64748b),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              _key.currentState?.save();
                              print(userData);
                              await addVendor(userData, tkn!);
                            }
                          },
                          child: Container(
                            height: 58,
                            width: 245,
                            decoration: BoxDecoration(
                                color: Color(0xff3574f2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily: "DM Sans",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}