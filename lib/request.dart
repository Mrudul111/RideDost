import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'Global/colors.dart';
import 'api/jsonAPI.dart';
import 'dashboard.dart';
import 'list.dart';
import 'login.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

int show = 0;
Map<String, dynamic> details = {};
class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  bool is1Active = false;
  bool is2Active = false;
  bool is3Active = false;
  int currentPage = 0;
  int totalpage = 0;
  int totalpage2 = 0;
  int _container = 0;
  int currentPage2 = 0;
  @override
  void initState() {
    // TODO: implement initState
    fetchRequested(currentPage);
    fetchPaymentSettlement(currentPage2);
    is1Active = true;
    super.initState();
  }

  String status = "STATUS";
  String dropdownStatus = "Pending";
  String dropdownStatus2 = "pending";

  Color dynamicFontColor(String status) {
    if (status == "STATUS") {
      return FCColors.brightRed;
    } else if (status == "pending") {
      return Color(0xfff2a715);
    } else if (status == "requested") {
      return Color(0xff157bf2);
    } else {
      return Color(0xff07c53c);
    }
  }
  Color dynamicBGColor(String status) {
    if (status == "STATUS") {
      return FCColors.brightRed;
    } else if (status == "pending") {
      return Color(0xfffa857);
    } else if (status == "requested") {
      return Colors.lightBlueAccent;
    } else {
      return Color.fromRGBO(87, 255, 134, 0.1);
    }
  }

  Widget buildTopButtons(String text, bool isActive, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          is1Active = text == "Send Request" ? true : false;
          is2Active = text == "Approve" ? true : false;
          is3Active = text == "Payment Settlement" ? true : false;
        });
      },
      child: Container(
        height: 31,
        width: screenWidth * 0.35,
        decoration: BoxDecoration(
          color: isActive ? Color(0xff2c2c2c) : Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: isActive ? Colors.white : Color(0xff828282)),
          ),
        ),
      ),
    );
  }

  Widget buildRequestItem(
      String vendorName, String vendorId, String couponDate) {
    return Container(
      width: 335,
      height: 139,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://static.wikia.nocookie.net/breakingbad/images/8/8e/BCS_S6_Portrait_Jimmy.jpg/revision/latest/scale-to-width-down/350?cb=20220802210840"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vendorName,
                          style: TextStyle(
                            color: HexColor.fromHex("#150A33"),
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          vendorId,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff524b6b),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: dropdownStatus == "Pending"
                        ? Color(0xfffa857)
                        : Colors.lightBlueAccent.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '$dropdownStatus',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dynamicFontColor(dropdownStatus),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Coupon Date",
                      style: TextStyle(
                          fontFamily: "DM Sans",
                          fontSize: 9.21,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff737784)),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xff737784),
                          size: 9,
                        ),
                        Text(
                          couponDate,
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 9.21,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff737784)),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  child: Text(
                    'view details',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff3574f2),
                      fontFamily: 'DM Sans',
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> requested = [];
  List<dynamic> settle = [];
  Widget buildRequestItem2(
      String vendorName, String vendorId, String couponDate,String user, String status) {
    return Container(
      width: 335,
      height: 139,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Requested by",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12,

                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          vendorName,
                          style: TextStyle(
                            color: HexColor.fromHex("#150A33"),
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          vendorId,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff524b6b),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: dynamicBGColor(status),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dynamicFontColor(status),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 144.39,
                  height: 30.19,

                  decoration: BoxDecoration(
                    color: Color.fromRGBO(93, 107, 152, 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Used by $user",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff5d6b98),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    'view details',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff3574f2),
                      fontFamily: 'DM Sans',
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildRequestItem3(
      String vendorName, String couponCode,String user) {
    return Container(
      width: 335,
      height: 139,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Requested by",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 12,

                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          vendorName,
                          style: TextStyle(
                            color: HexColor.fromHex("#150A33"),
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          user,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff524b6b),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dynamicFontColor(status),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 144.39,
                  height: 30.19,

                  decoration: BoxDecoration(
                    color: Color.fromRGBO(93, 107, 152, 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Requested to $user",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff5d6b98),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Text(
                    'view details',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff3574f2),
                      fontFamily: 'DM Sans',
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchRequested(int currentPage) async {
    try {
      String? token = tkn;
      final response = await approvedList(currentPage, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        String s = "";
        if(role=="1"){
          s = "itemsToSend";
        }
        else{
          s = 'data';
        }
        if (responseData[s] != null &&
            responseData[s] is List) {
          final List<Map<String, dynamic>> fetchedRequests =
              List.from(responseData[s]);
          totalpage = responseData['totalPages'];
          return fetchedRequests; // Return the fetched data
        } else {
          print("Error fetching requested data: Invalid data format");
        }
      } else {
        print(
            "Error fetching requested data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching requested data: $error");
    }

    // Return an empty list or handle the error case as needed
    return [];
  }
  Future<List<Map<String, dynamic>>> fetchPaymentSettlement(int currentPage) async {
    try {
      String? token = tkn;
      final response = await paymentSettlement(currentPage, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['settlements'] != null &&
            responseData['settlements'] is List) {
          final List<Map<String, dynamic>> fetch =
          List.from(responseData['settlements']);
          print(responseData['settlements'].length);
          totalpage2 = responseData['totalPages'];
          return fetch; // Return the fetched data
        } else {
          print("Error fetching requested data: Invalid data format");
        }
      } else {
        print(
            "Error fetching requested data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching requested data: $error");
    }

    // Return an empty list or handle the error case as needed
    return [];
  }
  Row choose(String rvid, String svid, String rstatus, String sstatus, String role,String superadminvid, String superadminstatus, String dropdown,String id){

    if(rvid==superadminvid && rstatus!='accepted' && sstatus!='accepted' && rstatus!='pending'){
      print("1");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  dropdownStatus2 == "Requested" ? "Approve" : "Go back",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid==superadminvid && rstatus=='pending' && sstatus=='requested' && superadminstatus=='pending' && role=="1" ){
      print("2");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () async{
              await vendorAcceptRequest(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid==superadminvid && rstatus=='pending' && sstatus=='pending' && superadminstatus=='accepted' && role=="1"){
      print("3");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Go back",
                  style: TextStyle(
                    color: Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
        ],
      );
    }
    if(rvid!=superadminvid && rstatus=='accepted' && sstatus=='requested' && superadminstatus=='requestedback' && role=="2"){
      print("4");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              300,
              height:
              56,
              decoration:
              BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Go back",
                  style: TextStyle(
                    color:Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid==superadminvid && rstatus=='pending' && sstatus=='pending' && superadminstatus=='accepted' && role=="2"){
      print("5");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () async{
              await vendorAcceptRequest(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid!=superadminvid && svid!=superadminvid && svid!=rvid  && rstatus=='pending' && sstatus=='requested' && superadminstatus=='pending' && role=="1"){
      print("6");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () async{
              await forwardRequest(id,tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Forward Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(svid==superadminvid && svid!=rvid  && rstatus=='pending' && sstatus=='requested' && superadminstatus=='pending' && role=="1"){
      print("7");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Go back",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(svid==superadminvid && svid!=rvid && rvid!=superadminvid && rstatus=='pending' && sstatus=='requested' && superadminstatus=='pending' && role=="2"){
      print("8");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () async{
              await vendorAcceptRequest(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(svid==superadminvid && svid!=rvid && rvid!=superadminvid && rstatus=='accepted' && sstatus=='pending' && superadminstatus=='pending' && role=="1"){
      print("9");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () async{
              await vendorAcceptRequest(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(svid==superadminvid && svid!=rvid && rvid!=superadminvid && rstatus=='accepted' && sstatus=='pending' && superadminstatus=='pending' && role=="2"){
      print("10");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Go back",
                  style: TextStyle(
                    color: Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
        ],
      );
    }
    if(superadminstatus=='returning'&&rstatus=='accepted'){
      print("11");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              300,
              height:
              56,
              decoration:
              BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Go back",
                  style: TextStyle(
                    color:Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid!=superadminvid && svid!=superadminvid && svid!=rvid  && rstatus=='pending' && sstatus=='requested' && superadminstatus=='forwarded' && role=="2"){
      print("12");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () {
              setState(() {
                dropdownStatus2 = "Approved";
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color: dropdownStatus2 == "Requested" ? Color(0xff3574f2) : Colors.white,
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: dropdownStatus2 == "Requested" ? Colors.white : Color(0xff3574f2),
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            15,
          ),
          GestureDetector(
            onTap:
                () async{
              await vendorAcceptRequest(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              150,
              height:
              28,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Approve",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if(rvid!=superadminvid && svid!=superadminvid && svid!=rvid  && rstatus=='accepted' && sstatus=='requested' && superadminstatus=='requestedback' && role=="1"){
      print("12");
      return Row(
        mainAxisAlignment:
        MainAxisAlignment
            .center,
        crossAxisAlignment:
        CrossAxisAlignment
            .center,
        children: [
          GestureDetector(
            onTap:
                () async{
              await adminReturn(id, tkn!);
              setState(() {
                Navigator.pop(context);
              });
            },
            child:
            Container(
              width:
              346,
              height:
              56,
              decoration:
              BoxDecoration(
                color:Color(0xff3574f2),
                border: Border.all(color: Color(0xff3574f2)),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
              Center(
                child: Text(
                  "Return",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Request",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.04,
            fontFamily: "SF Pro Display",
            color: Color(0xff1d3a70),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xFF6b7280),
        selectedItemColor: Color(0xFF1D3A70),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: Color(0xFF6b7280),
        ),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'My Card',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(child: Icon(Icons.qr_code_scanner), radius: 25),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Icon(Icons.show_chart),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 24,
              height: 24,
              child: Icon(Icons.person_outline_outlined),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildTopButtons("Send Request", is1Active, screenWidth),
                      SizedBox(width: screenWidth * 0.01),
                      buildTopButtons("Approve", is2Active, screenWidth),
                      SizedBox(width: screenWidth * 0.01),
                      buildTopButtons(
                          "Payment Settlement", is3Active, screenWidth),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: is1Active
                        ? SingleChildScrollView(
                            key: ValueKey<bool>(true),
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Container(
                                width: 335,
                                height: 449,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16.0),
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final vendors = vendorDetails['vendorsList']
                                        as List<dynamic>?;
                                    if (vendors != null &&
                                        index < vendors.length) {
                                      final vendor = vendors[index];
                                      final String id = vendor['_id'];
                                      return GestureDetector(
                                        onTap: () {
                                          Future<dynamic> getAllVendorsDetails(
                                              String token) async {
                                            try {
                                              final response = await http.get(
                                                Uri.parse(
                                                    'https://fierce-lime-pajamas.cyclic.app/admin/settle/coupon/$id'),
                                                headers: {
                                                  'Authorization':
                                                      'Bearer $token',
                                                },
                                              );
                                              return response;
                                            } catch (error) {
                                              // print(error);
                                              print(error);
                                              return {'status': false};
                                              // throw error;
                                            }
                                          }

                                          Future<void>
                                              fetchVendorsDetails() async {
                                            try {
                                              String? token = tkn;
                                              final response =
                                                  await getAllVendorsDetails(
                                                      tkn!);

                                              if (response.statusCode == 200) {
                                                final responseData =
                                                    jsonDecode(response.body);
                                                setState(() {
                                                  details =
                                                      responseData; // Initialize the vendorDetails map with the parsed JSON data
                                                });
                                                print(details);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            list()));
                                              } else {
                                                print(response.body);
                                                print(
                                                    "Error fetching vendors. Status code: ${response.statusCode}");
                                              }
                                            } catch (error) {
                                              print(
                                                  "Error fetching vendors: $error");
                                            }
                                          }

                                          fetchVendorsDetails();
                                        },
                                        child: buildRequestItem(vendor['name'],
                                            vendor['_id'], "21st JUN 2022"),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          )
                        : is2Active? Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: Container(
                                  width: 335,
                                  height: 449,
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: totalpage, // Number of pages
                                    onPageChanged: (int page) {
                                      setState(() {
                                        currentPage = page + 1;
                                      });
                                      print("current page $page");
                                    },
                                    itemBuilder: (context, pageIndex) {
                                      return FutureBuilder<
                                              List<Map<String, dynamic>>?>(
                                          future: fetchRequested(currentPage),
                                          builder: (context, snapshot) {
                                            print(
                                                "Connection State: ${snapshot.connectionState}");
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              // While waiting for data, display a loading screen
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              // Handle error if necessary
                                              return Center(
                                                child:
                                                    Text("Error fetching data"),
                                              );
                                            } else {
                                              requested = snapshot.data ?? [];
                                              return ListView.separated(
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(height: 16.0),
                                                shrinkWrap: true,
                                                itemCount: requested.length,
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  final req = requested[index];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          34),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          34))),
                                                          builder: (context) {
                                                            return Padding(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        30),
                                                                height: 375,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                34),
                                                                        topRight:
                                                                            Radius.circular(34))),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              req['sendor']['vendorName'],
                                                                              style: TextStyle(
                                                                                fontSize: 25,
                                                                                fontFamily: "SF Pro Display",
                                                                                fontWeight: FontWeight.w700,
                                                                                color: Color(0xff150b3d),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "used by ${req['user']['name']}",
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                fontFamily: "SF Pro Display",
                                                                                fontWeight: FontWeight.w300,
                                                                                color: Color(0xff737784),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    DottedBorder(
                                                                      color: Color(
                                                                          0xff737784), //color of dotted/dash line
                                                                      strokeWidth:
                                                                          3, //thickness of dash/dots
                                                                      dashPattern: [
                                                                        10,
                                                                        6
                                                                      ],
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            297,
                                                                        height:
                                                                            50.13,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            req['coupon']['couponCode'],
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: "SF Pro Display",
                                                                              color: Color(0xff150b3d),
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 22.7,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.access_time_outlined,
                                                                              color: Color(0xff737784),
                                                                              size: 13.66,
                                                                            ),
                                                                            Text(
                                                                              "20 days left",
                                                                              style: TextStyle(
                                                                                color: Color(0xff737784),
                                                                                fontFamily: "SF Pro Display",
                                                                                fontSize: 13.66,
                                                                                fontWeight: FontWeight.w300,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.refresh,
                                                                              color: Color(0xff737784),
                                                                              size: 13.66,
                                                                            ),
                                                                            Text(
                                                                              role=="1"?req['superAdmin']['status']:req['receiver']['status'],
                                                                              style: TextStyle(
                                                                                color: Color(0xff737784),
                                                                                fontFamily: "SF Pro Display",
                                                                                fontSize: 13.66,
                                                                                fontWeight: FontWeight.w300,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    choose(req['receiver']['vendorId'], req['sendor']['vendorId'], req['receiver']['status'], req['sendor']['status'], role, req['superAdmin']['adminId'], req['superAdmin']['status'],req['sendor']['status'],req['_id'] ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "Have any issue?",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff737784),
                                                                            fontFamily:
                                                                                "SF Pro Display",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "Contact Us",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff1d3a70),
                                                                            fontFamily:
                                                                                "SF Pro Display",
                                                                            fontSize:
                                                                                16.94,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: buildRequestItem2(
                                                    req['sendor']['vendorName'],
                                                        req['sendor']['vendorId'],
                                                        req['sendor']['Date'],req['user']['name'],role=="1"?req['superAdmin']['status']:req['receiver']['status']),
                                                  );
                                                },
                                              );
                                            }
                                          });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ): Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Container(
                            width: 335,
                            height: 449,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: totalpage2, // Number of pages
                              onPageChanged: (int page) {
                                setState(() {
                                  currentPage2 = page + 1;
                                });
                                print("current page $page");
                              },
                              itemBuilder: (context, pageIndex) {
                                return FutureBuilder<
                                    List<Map<String, dynamic>>?>(
                                    future: fetchRequested(currentPage2),
                                    builder: (context, snapshot) {
                                      print(
                                          "Connection State: ${snapshot.connectionState}");
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // While waiting for data, display a loading screen
                                        return Center(
                                          child:
                                          CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        // Handle error if necessary
                                        return Center(
                                          child:
                                          Text("Error fetching data"),
                                        );
                                      } else {
                                        settle = snapshot.data ?? [];
                                        return ListView.separated(
                                          separatorBuilder:
                                              (context, index) =>
                                              SizedBox(height: 16.0),
                                          shrinkWrap: true,
                                          itemCount: settle.length,
                                          physics:
                                          AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final set = settle[index];
                                            return buildRequestItem3('vendorName',set['coupon']['couponCode'],set['user']['name']);
                                          },
                                        );
                                      }
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                    ))
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double width;
  final double dashLength;
  final double spaceLength;

  DashedBorderPainter({
    required this.color,
    this.width = 1.0,
    this.dashLength = 3.0,
    this.spaceLength = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    final dashSpaceTotal = dashLength + spaceLength;
    final numDashes = (size.width / dashSpaceTotal).floor();

    final yOffset = size.height / 2;
    final startX = 0.0;
    final endX = size.width;

    for (var i = 0; i < numDashes; i++) {
      final x = startX + i * dashSpaceTotal;
      canvas.drawLine(
        Offset(x, yOffset),
        Offset(x + dashLength, yOffset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
