import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:token/api/jsonAPI.dart';
import 'package:token/request.dart';

import 'Global/colors.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  Color dynamicFontColor(String status) {
    if (status == "reject" || status=='STATUS' || status=='rejected') {
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
    if (status == "reject"|| status=='STATUS' || status=='rejected') {
      return Color.fromRGBO(255, 87, 87, 0.1);
    } else if (status == "pending") {
      return Color(0xfffa857);
    } else if (status == "requested") {
      return Colors.lightBlueAccent;
    } else {
      return Color.fromRGBO(87, 255, 134, 0.1);
    }
  }
  Widget buildRequestItem(
      String vendorName, String vendorId, String couponDate,String status) {
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
  Widget build(BuildContext context) {
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
            fontSize: 16,
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
                SizedBox(height: 20),
                SingleChildScrollView(
                  key: ValueKey<bool>(true),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 335,
                      height: 449,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.0),
                        shrinkWrap: true,
                        itemCount: details['request'].length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final firstRequestItem = details['request'][index];
                          final user = firstRequestItem['user'];
                          final name = user['name'];
                          final couponValue = firstRequestItem['CouponValue'];
                          final amount = firstRequestItem['amount'];
                            return GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.only(
                                            topLeft:
                                            Radius.circular(
                                                34),
                                            topRight:
                                            Radius.circular(
                                                34))),
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                            MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets
                                              .symmetric(
                                              vertical: 20,
                                              horizontal: 30),
                                          height: 375,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.only(
                                                  topLeft: Radius
                                                      .circular(
                                                      34),
                                                  topRight: Radius
                                                      .circular(
                                                      34))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        firstRequestItem['sendor']['vendorName'],
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          25,
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                          color: Color(
                                                              0xff150b3d),
                                                        ),
                                                      ),
                                                      Text(
                                                        "used by $name",
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          15,
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                          color: Color(
                                                              0xff737784),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 48,
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            6),
                                                        color: Color(
                                                            0xff3574f2)),
                                                    child: Center(
                                                      child: Text(
                                                        "$couponValue\nPTS",
                                                        style:
                                                        TextStyle(
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                          fontSize:
                                                          11,
                                                          color: Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              DottedBorder(
                                                color: Color(0xff737784),//color of dotted/dash line
                                                strokeWidth: 3, //thickness of dash/dots
                                                dashPattern: [10,6],
                                                child: Container(
                                                  width: 297,
                                                  height: 50.13,
                                                  child: Center(
                                                    child: Text(
                                                      firstRequestItem['coupon']['couponCode'],
                                                      style: TextStyle(
                                                        fontFamily:
                                                        "SF Pro Display",
                                                        color: Color(
                                                            0xff150b3d),
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
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
                                                        Icons
                                                            .access_time_outlined,
                                                        color: Color(
                                                            0xff737784),
                                                        size: 13.66,
                                                      ),
                                                      Text(
                                                        "20 days left",
                                                        style:
                                                        TextStyle(
                                                          color: Color(
                                                              0xff737784),
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontSize:
                                                          13.66,
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 10),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .local_offer_outlined,
                                                        color: Color(
                                                            0xff737784),
                                                        size: 13.66,
                                                      ),
                                                      Text(
                                                        "$amount",
                                                        style:
                                                        TextStyle(
                                                          color: Color(
                                                              0xff737784),
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontSize:
                                                          13.66,
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.refresh,
                                                        color: Color(
                                                            0xff737784),
                                                        size: 13.66,
                                                      ),
                                                      Text(
                                                        firstRequestItem['sendor']['status'],
                                                        style:
                                                        TextStyle(
                                                          color: Color(
                                                              0xff737784),
                                                          fontFamily:
                                                          "SF Pro Display",
                                                          fontSize:
                                                          13.66,
                                                          fontWeight:
                                                          FontWeight
                                                              .w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (firstRequestItem['sendor']['status'] == 'pending') {
                                                    // Update the status in your data source
                                                    setState(() {
                                                      firstRequestItem['sendor']['status'] = 'requested';
                                                    });

                                                    // You may also send a request here if needed.
                                                     sendRequest(firstRequestItem['coupon']['couponCode'], tkn!);
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 327,
                                                  height: 56,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: firstRequestItem['sendor']['status'] ==
                                                        "pending"
                                                        ? Color(
                                                        0xff3574f2)
                                                        : Colors
                                                        .white,
                                                    border: Border.all(
                                                        color: Color(
                                                            0xff3574f2)),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        30),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      firstRequestItem['sendor']['status'] ==
                                                          "pending"
                                                          ? "Approve"
                                                          : "Go back",
                                                      style:
                                                      TextStyle(
                                                        color: firstRequestItem['sendor']['status'] ==
                                                            "pending"
                                                            ? Colors
                                                            .white
                                                            : Color(
                                                            0xff3574f2),
                                                        fontFamily:
                                                        "SF Pro Display",
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    "Have any issue?",
                                                    style: TextStyle(
                                                      color: Color(
                                                          0xff737784),
                                                      fontFamily:
                                                      "SF Pro Display",
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Contact Us",
                                                    style: TextStyle(
                                                      color: Color(
                                                          0xff1d3a70),
                                                      fontFamily:
                                                      "SF Pro Display",
                                                      fontSize: 16.94,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
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
                              child: buildRequestItem(user['name'],
                                  firstRequestItem['coupon']['couponCode'], firstRequestItem['sendor']['Date'],firstRequestItem['sendor']['status']),
                            );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
