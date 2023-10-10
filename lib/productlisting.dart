import 'dart:convert';

import 'package:barcode_scanner/classical_components/barcode_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'api/jsonAPI.dart';
import 'dashboard.dart';


class productListing extends StatefulWidget {
  const productListing({super.key});

  @override
  State<productListing> createState() => _productListingState();
}

class _productListingState extends State<productListing> {
  final _key = GlobalKey<FormState>();
  Map<String, dynamic> userData = {
    'name': '',
    'productimage': '',
    'price': '',
    'rating': '',
    'description': '',
  };
  Future<http.Response> addProduct(Map<String, dynamic> userData, String token) async {
    final String baseUrl = 'https://token-web-backend.el.r.appspot.com/admin/product';
    final Uri uri = Uri.parse(baseUrl);
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
      print(response.body);
      if(response.statusCode!=201){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product add Unsuccessfully',style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added Product Successfully',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
        });
      }
      print(response.statusCode);
      return response;

    } catch (error) {
      throw error;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff2f2f2),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Listing",
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
                          "Product image",
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
                                      userData['productimage'] = parsedResponse['secure_url'];
                                    } else {
                                      print('Image upload failed. Status code: ${response.statusCode}, Response: $responseBody');
                                    }
                                  }
                                  uploadImage(path);
                                }
                              },
                              child: Container(
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
                                        "choose file",
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
                              )),
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
                          "Product Name",
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
                                hintText: "Product name",
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
                          "Product Price",
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
                              userData['price'] = newValue;
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
                                hintText: "Product Price",
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
                          "Listing Overview / Description",
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
                          height: 60,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              userData['description'] = newValue;
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
                                hintText: "overview",
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
                          "Rating",
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
                          height: 86,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter this field';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              userData['rating'] = newValue;
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
                                hintText: "Rating",
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              _key.currentState?.save();
                              addProduct(userData, tkn!);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

