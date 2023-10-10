import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import the 'dart:convert' library to handle JSON data

import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:token/api/jsonAPI.dart';

import 'dashboard.dart';

class checkoutPage extends StatefulWidget {
  const checkoutPage({super.key});

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {
  final _key = GlobalKey<FormState>();

  Map<String, dynamic> userData = {
    'phoneNumber': '',
    'amount': 0,
    'coupon': ''
  };
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String result = '';

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  Future<http.Response> checkout(Map<String, dynamic> userData, String token) async {
    // Replace with your actual base URL
    final url = Uri.parse('${apiUrl}/admin/checkout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(userData),
      );

      if(response.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Checkout Successfully',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
        });
      }
      else{
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Checkout Unsuccessfully',style: TextStyle(color: Colors.white),),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: "DM Sans",
            color: Color(0xff1d3a70),
          ),
        ),
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: Form(
        key: _key,
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        fontFamily: "DM Sans",
                        color: Colors.black,
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
                          userData['phoneNumber'] = newValue;
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
                            hintText: "+91 64894 XXXX",
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
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        fontFamily: "DM Sans",
                        color: Colors.black,
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
                          userData['amount'] = newValue;
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
                            hintText: "4800 rs",
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Coupon Code",
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
                            child:TextFormField(
                              onSaved: (newValue) {
                                userData['coupon'] = newValue;
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
                                  hintText: result,
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
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () async{
                        var res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SimpleBarcodeScannerPage(),
                            ));
                        setState(() {
                          if (res is String) {
                            result = res ;
                          }
                        });
                      },
                        child: Icon(Icons.camera_alt)
                    )
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    if(_key.currentState!.validate()){
                      _key.currentState!.save();
                      print(userData);
                      checkout(userData, tkn!);
                    };
                  },
                  child: Container(
                    width: 309,
                    height: 40,
                    
                    decoration: BoxDecoration(
                      color: Color(0xff3574f2),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Center(
                      child: Text(
                        "Confirm Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
