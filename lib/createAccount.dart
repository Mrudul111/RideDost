import 'package:flutter/material.dart';

import 'api/jsonAPI.dart';
import 'dashboard.dart';

class newAccount extends StatefulWidget {
  const newAccount({super.key});

  @override
  State<newAccount> createState() => _newAccountState();
}

class _newAccountState extends State<newAccount> {
  Text t1(){
    return      Text(
      "Finance app ",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: "SF Pro Display",
        color: Color(0xff3866f2),
      ),
    );
  }
  Text t2(){
    return Text(
      "the safest and most ",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: "SF Pro Display",
        color: Color(0xff1d3a70),
      ),
    );
  }
  Text t3(){
    return Text(
      "trusted ",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: "SF Pro Display",
        color: Color(0xff3866f2),
      ),
    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void createUser() async {
    try {
      final response = await newUser(userData);

      if (response.statusCode == 201) {
        // Show a SnackBar with a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User created successfully!'),
          ),
        );
      } else {
        // Show a SnackBar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create user. Please try again.${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      // Show a SnackBar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    }
  }
  final _key = GlobalKey<FormState>();

  Map<String, dynamic> userData = {

    'name': '',
    'email': '',
    'DOB': '',
    'mobile': '',

  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 390,height:457,child: Image.asset("assets/images/createAcc.png")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      t1(),
                      t2(),
                    ],
                  ),
                  t3(),
                ],
              ),
              SizedBox(height: 20,),
              Form(
                key: _key,
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          userData['name'] = value;
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
                            hintText: "Username",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xff64748b),
                            )),
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
                          userData['email'] = value;
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
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xff64748b),
                            )),
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
                          userData['DOB'] = value;
                        },
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),

                        keyboardType: TextInputType.datetime,
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
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xff64748b),
                            )),
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
                          userData['mobile'] = value;
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
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xff64748b),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 309,
                      height: 56.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF3574F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if(_key.currentState!.validate()){
                            _key.currentState?.save();
                            print(userData);
                            createUser();
                          }
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
                    SizedBox(height: 50,),
                  ],
                ),
              ))

            ],
          ),
        ),
      ),
    );
  }
}
