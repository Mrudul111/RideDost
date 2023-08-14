import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class productListing extends StatefulWidget {
  const productListing({super.key});

  @override
  State<productListing> createState() => _productListingState();
}

class _productListingState extends State<productListing> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfff9fafc),
        iconTheme: IconThemeData(
          color: Color(0xFFF2F2F2),
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
                      height: 46.3,
                      child: GestureDetector(
                          onTap: () async {
                            final pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedImage != null) {}
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
                    SizedBox(
                      height: 30,
                    ),
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
                      height: 46.3,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter this field';
                          }
                          return null;
                        },
                        onSaved: (newValue) {},
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
                    SizedBox(
                      height: 30,
                    ),
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
                      height: 46.3,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter this field';
                          }
                          return null;
                        },
                        onSaved: (newValue) {},
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
                    SizedBox(
                      height: 30,
                    ),
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
                      height: 86,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter this field';
                          }
                          return null;
                        },
                        onSaved: (newValue) {},
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
                    SizedBox(
                      height: 30,
                    ),
                    Row(
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
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/vendor'));
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
