import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool phoneValid = false;
  final _key = GlobalKey<FormState>();
  bool isLoading = false;
  String selectedCountryCode = '+91';
  String phno = "";
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential authResult) async {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authResult);
        debugPrint(
            "User automatically verified and signed in: ${userCredential.user!.uid}");
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        debugPrint(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      };

      final PhoneCodeSent codeSent =
          (String verificationId, int? resendToken) async {
        final String? smsCode = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerificationPage(verificationId: verificationId),
          ),
        );
        if (smsCode != null) {
          final AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          // Handle the user sign-in here.
          debugPrint(
              "User verified and signed in: ${userCredential.user!.uid}");
        } else {
          debugPrint('SMS code not entered. User canceled.');
        }
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verificationId) {
        // This callback will be triggered when the verification code auto-retrieval
        // times out and needs to be manually entered by the user.
        debugPrint(
            'Phone code auto-retrieval timed out. Verification ID: $verificationId');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      debugPrint('Failed to verify phone number: $e');
    }
  }

  Future<void> saveUserDataToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedInState();
  }

  void _checkLoggedInState() async {
    // Check if the user is already logged in
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to the dashboard page
      Navigator.pushNamedAndRemoveUntil(
          context, '/dashboard', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Phone number',
              style: TextStyle(
                fontFamily: "Plus Jakarta Sans",
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                if (val!.isEmpty || val.length != 10) {
                  return 'Invalid phone number';
                }
                return null;
              },
              onSaved: (val) {
                phno = val!;
              },
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: "Plus Jakarta Sans",
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                suffixIconColor: phno.length == 10 ? Colors.green : Colors.red,
                hintText: "Enter mobile number",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(80, 44, 44, 1),
                  fontFamily: "Plus Jakarta Sans",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 0.88,
                    color: HexColor.fromHex("#E1E1E1"),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 0.88,
                    color: HexColor.fromHex("#E1E1E1"),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    width: 0.88,
                    color: HexColor.fromHex("#E1E1E1"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3574F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  _key.currentState!.save();
                  setState(() {
                    isLoading = true;
                  });
                  final user = await signInWithPhoneNumber(selectedCountryCode+phno);
                  setState(() {
                    isLoading = false;
                  });

                }
              },
              child:  Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            )
          ],
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
                children:
                    List.generate(6, (index) => _buildOTPTextField(index)),
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
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard', (route) => false);
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
