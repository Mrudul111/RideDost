import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:flutter/services.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 216.8,
                height: 131,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Asset 6 1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      "Explore the app",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "DM Sans",
                          fontSize: 32,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  Center(
                    child: const Text(

                      'Now your finances are in one place and always under control',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF474A56),
                        fontSize: 18,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 353,
                    height: 56.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF3574F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child:  Text(
                        "Sign in",
                        style: TextStyle(
                          fontFamily: "Mazzart",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 353,
                    height: 56.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Color(0xff3574f2))
                        ),

                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/newaccount');
                      },
                      child:  Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: "Mazzart",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3574f2),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationPage extends StatefulWidget {
  final String verificationId;

  const VerificationPage({required this.verificationId, Key? key})
      : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late List<TextEditingController> _smsCodeControllers;
  late List<FocusNode> _focusNodes;
  late FocusNode _currentFocusNode;
  bool _isWrongOTP = false;

  @override
  void initState() {
    super.initState();
    _smsCodeControllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());
    _currentFocusNode = _focusNodes[0];

    // Paste OTP from clipboard
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _pasteOTPFromClipboard();
    });
  }

  @override
  void dispose() {
    for (var controller in _smsCodeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
      ),
      body: GestureDetector(
        onTap: () {
          _currentFocusNode.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please enter the verification code sent to your phone.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOTPTextField(index)),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  final smsCode = _smsCodeControllers
                      .map((controller) => controller.text.trim())
                      .join('');

                  // Verify the entered OTP with Firebase
                  if (smsCode.isNotEmpty) {
                    _verifyOTP(smsCode);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Verify',
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
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Resend OTP logic
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPTextField(int index) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: _smsCodeControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18.0),
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            _focusNextField(index);
          } else {
            _focusPreviousField(index);
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: '',
          border: InputBorder.none,
        ),
        focusNode: _focusNodes[index],
      ),
    );
  }

  void _focusNextField(int index) {
    if (index < _smsCodeControllers.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      _currentFocusNode.unfocus();
    }
  }

  void _focusPreviousField(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _pasteOTPFromClipboard() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    final clipboardText = clipboardData?.text ?? '';
    if (clipboardText.length == 6) {
      for (var i = 0; i < clipboardText.length; i++) {
        _smsCodeControllers[i].text = clipboardText[i];
        if (i < _smsCodeControllers.length - 1) {
          _focusNextField(i);
        } else {
          _currentFocusNode.unfocus();
        }
      }
    }
  }

  // Function to verify the OTP using Firebase
  void _verifyOTP(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      // Sign in with the credential
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // If the verification is successful, userCredential.user will be non-null
      if (userCredential.user != null) {
        // Verification successful, navigate back with the entered OTP
        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
      } else {
        // Verification failed, show error message
        setState(() {
          _isWrongOTP = true;
        });
      }
    } catch (e) {
      // Handle any errors that occurred during verification
      setState(() {
        _isWrongOTP = true;
      });
      print('Error verifying OTP: $e');
    }
  }
}

