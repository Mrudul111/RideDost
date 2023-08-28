import 'package:flutter/material.dart';

class createAccount extends StatefulWidget {
  const createAccount({super.key});

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/Home-2.png", fit: BoxFit.contain),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Cash on Delivery or E-payment",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "SF Pro Display",
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Our delivery will ensure your items are delivered right to the door steps',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF474A56),
                      fontSize: 14,
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                SizedBox(
                  width: 327,
                  height: 56.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF3574F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/createaccount');
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontFamily: "Mazzart",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 327,
                  height: 56.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFFFFFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Color(0xff3574f2))),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    child: Text(
                      "Sign in as guest",
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
    );
  }
}

class newAccount extends StatefulWidget {
  const newAccount({super.key});

  @override
  State<newAccount> createState() => _newAccountState();
}

class _newAccountState extends State<newAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/createAcc.png"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Finance app ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: Color(0xff3866f2),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "the safest and most ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                          color: Color(0xff1d3a70),
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
    );
  }
}
