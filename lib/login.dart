import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:token/dashboard.dart';

import 'api/adminApi.dart';
import 'api/jsonAPI.dart';
String phno = "";


class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _otpSent = false;
  late String _verificationId = "";
  bool _isWrongOTP = false;

  Future<void> _sendOtp() async {
    final phoneNumber = "+91" + _mobileController.text.trim();
    await signInWithPhoneNumber(phoneNumber);

    setState(() {
      _otpSent = true;
    });
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification should not happen in this scenario
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Phone number verification failed: $e");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Timeout, do nothing
        },
      );
    } catch (e) {
      print('Failed to verify phone number: $e');
    }
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      // Perform OTP verification
      final smsCode = _otpController.text.trim();
      await onLogin(phno);
    }
  }

  // Future<void> _verifyOTP(String smsCode) async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: smsCode,
  //     );
  //
  //     final UserCredential userCredential =
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     if (userCredential.user != null) {
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => DashboardScreen()));
  //     } else {
  //       // Verification failed, show error message
  //       setState(() {
  //         _isWrongOTP = true;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _isWrongOTP = true;
  //     });
  //     print('Error verifying OTP: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length != 10) {
                    return 'Invalid phone number';
                  }
                  return null;
                },
                onSaved: (value){
                  phno = value!;
                  print(phno);
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save(); // Save the form data

                  // Use the phno variable for further processing
                  final token = await onLogin(phno);
                  if(token){
                    Navigator.pushNamed(context, '/dashboard');
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _otpSent ? 'Verify OTP' : 'Send OTP',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 4.0,
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            if (_isWrongOTP)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Wrong OTP. Please try again.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
