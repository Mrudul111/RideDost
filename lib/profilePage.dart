import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:token/api/jsonAPI.dart';

import 'dashboard.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final _key = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool picked = false;
  bool updatePhoto = false;
  Map<String, dynamic>? profile = {};
  Future<void> fetchProfileInfo() async {
    try {
      String? token = tkn;

      if (token == null) {
        print("Token is null");
        return; // Return early to avoid making the API request
      }

      final response = await getProfileInfo(token);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null && responseData is Map<String, dynamic>) {
          setState(() {
            profile = responseData;
            final vendorInfo = profile!['vendorInfo'][0];
            updateProfile['name'] = profile?['vendorInfo'][0]['name'];
            updateProfile['phoneNumber'] = profile?['vendorInfo'][0]['phoneNumber'];
            updateProfile['gender'] = profile?['vendorInfo'][0]['gender'];
            updateProfile['DOB'] = profile?['vendorInfo'][0]['DOB'];
            updateProfile['address'] = profile?['vendorInfo'][0]['address'];
            updateProfile['profileImage'] = vendorInfo['profileImage'];
            print(updateProfile);
          });
          return;
        } else {
          print("Invalid response data format");
        }
      } else {
        print("Error fetching profile. Status code: ${response.statusCode}");
      }
      return;
    } catch (error) {
      print("Error fetching profile: $error");
    }
  }
  Future<void>? _profileFuture;
  Map<String, dynamic> updateProfile = {
    'name': '',
    'gender': '',
    'address': '',
    'DOB':'',
    'phoneNumber':'',
    'profileImage': ''
  };
  @override
  @override
  void initState() {
    // apicall();
    super.initState();
    fetchProfileInfo();
    _profileFuture = fetchProfileInfo();

  }
void apicall() async{
    await fetchProfileInfo();
    if (profile != null && profile!['vendorInfo'] is List<dynamic> && profile!['vendorInfo'].isNotEmpty) {
      print(updateProfile);
    }
  }
  bool update = false;
  bool url_changed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Personal Info",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: "DM Sans",
                        color: Color(0xff0f172a),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        // _key.currentState?.save();
                        print(updateProfile);
                        updateInfo(updateProfile!, tkn!);
                      },
                      child: Container(
                        width: 91,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xff3574f2),
                        ),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "DM Sans",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),

                FutureBuilder<void>(
                  future: _profileFuture,
                  builder: (context,snapshot){

                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Text("Error: ${snapshot.error}");

                    }
                    else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 10,),
                                      Container(
                                          width: 232,
                                          height: 184,
                                          child: updatePhoto?  GestureDetector(
                                            onTap: () async{
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
                                                    updateProfile?['profileImage'] = parsedResponse['secure_url'];
                                                    url_changed = true;
                                                    setState(() {

                                                    });

                                                  } else {
                                                    print('Image upload failed. Status code: ${response.statusCode}, Response: $responseBody');
                                                  }
                                                }
                                                await uploadImage(path);
                                              }

                                            },
                                            child: !url_changed?  Container(
                                              // Display the "Choose file" button
                                              decoration: BoxDecoration(
                                                color: Color(0xfff5f8fb),
                                                border: Border.all(color: Color(0xffcbd5e1)),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Center(
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
                                            ) :Container(
                                              // Display the picked image
                                              decoration: BoxDecoration(
                                                color: Color(0xfff5f8fb),
                                                border: Border.all(color: Color(0xffcbd5e1)),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Image.network('${updateProfile['profileImage']}',fit: BoxFit.fill,), // Use the 'img' variable here
                                            )
                                          ):
                                          Container(
                                            // Display the picked image
                                            decoration: BoxDecoration(
                                              color: Color(0xfff5f8fb),
                                              border: Border.all(color: Color(0xffcbd5e1)),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: url_changed?Image.network('${updateProfile?['profileImage']}',fit: BoxFit.fill,): Image.network('${profile?['vendorInfo'][0]['profileImage']}',fit: BoxFit.fill,), // Use the 'img' variable here
                                          )

                                      ),

                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        updatePhoto = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name",
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
                                          readOnly: !update,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter this field';
                                            }
                                            return null;
                                          },



                                          onFieldSubmitted: (value){
                                            updateProfile?['name'] = value;
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
                                              hintText: "${profile?['vendorInfo'][0]['name']}",
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
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        update = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Gender",
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
                                          readOnly: !update,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          onSaved: (value){
                                            updateProfile?['gender'] = value;
                                          },
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
                                              hintText: "${profile?['vendorInfo'][0]['gender']}",
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
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        update = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Date of Birth",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          fontFamily: "DM Sans",
                                          color: Color(0xff0f172a),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        child: Container(
                                          width: 309,
                                          height: 86,

                                          child: TextFormField(
                                            readOnly: !update,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter this field';
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (value){
                                              updateProfile?['DOB'] = value;
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
                                                hintText: "${profile?['vendorInfo'][0]['DOB']}",
                                                hintStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color: Color(0xff64748b),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        update = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    "Email",
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
                                      readOnly: !update,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter this field';
                                        }
                                        return null;
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
                                          hintText: "${profile?['vendorInfo'][0]['email']}",
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
                                children: [
                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Phone number",
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
                                          readOnly: !update,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter this field';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (value){
                                            updateProfile?['phoneNumber'] = value;
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
                                              hintText: "${profile?['vendorInfo'][0]['phoneNumber']}",
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
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        update = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
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
                                        height: 70,
                                        child: TextFormField(
                                          readOnly: !update,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter this field';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (value){
                                            updateProfile?['address'] = value;
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
                                              hintText: "${profile?['vendorInfo'][0]['address']}",
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
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        update = true;
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 20,
                                      child: Icon(Icons.edit_outlined,color: Color(0xff3574f2),),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
