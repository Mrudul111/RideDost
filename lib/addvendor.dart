import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
String? _companyLogoImageBase64;
String? idImageBase64;

Map<String, dynamic> userData = {
  'companyName': '', // Set this value when user enters the company name
  'couponValue': '', // Set this value when user enters the coupon value
  'couponThreshold': '', // Set this value when user enters7987432366
  'address': '',
  'companyLogo':_companyLogoImageBase64 ?? '',
  'name': '',
  'ID Proof': idImageBase64 ?? '',
  'phno':'',
  'email': '',
  // Set this value when user enters the address
  // Add more fields as needed
};
Future<http.Response> addVendor(Map<String, dynamic> userData, String token) async {
  final String baseUrl = 'https://token-web-backend.el.r.appspot.com';
  final String endpoint = '/admin/add';
  final Uri uri = Uri.parse(baseUrl + endpoint);

  try {
    final http.Response response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: userData, // Use the userData directly as the body
    );
    print(response.statusCode);
    return response;
  } catch (error) {
    throw error;
  }
}

class AddVendor extends StatefulWidget {
  const AddVendor({Key? key}) : super(key: key);

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  final _key = GlobalKey<FormState>();
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
                            onTap: () async{
                              final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                final imageBytes = await pickedImage.readAsBytes();
                                final base64Image = base64Encode(imageBytes);
                                setState(() {
                                  _companyLogoImageBase64 = base64Image;
                                });
                              }

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff5f8fb),
                                border: Border.all(
                                  color: Color(0xffcbd5e1)
                                ),
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
                                    child: Icon(Icons.upload,size: 18, color: Color(0xff5d6b98),),
                                  )
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Coupon Value",
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
                              userData['couponValue'] = newValue;
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
                                hintText: "Coupon Value",
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

                            onSaved: (newValue) {
                              userData['couponThreshold'] = newValue;
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

                            onSaved: (newValue) {
                              userData['address'] = newValue;
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
                                final pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  final imageBytes = await pickedImage.readAsBytes();
                                  final base64Image = base64Encode(imageBytes);
                                  setState(() {
                                    idImageBase64 = base64Image;
                                  });
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
                              return null;
                            },
                            onSaved: (newValue) {
                              userData['phno'] = newValue;
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
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              addVendor(userData,tkn!);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/dashboard'));
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