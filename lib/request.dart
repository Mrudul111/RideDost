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
  @override
  void initState() {
    // TODO: implement initState
    fetchRequested();
    is1Active = true;
    super.initState();
  }

  String status = "STATUS";
  String dropdownStatus = "Pending";
  String dropdownStatus2 = "Requested";

  Color dynamicFontColor(String status) {
    if (status == "STATUS") {
      return FCColors.brightRed;
    } else if (status == "Pending") {
      return Color(0xfff2a715);
    } else if (status == "Requested") {
      return Color(0xff157bf2);
    } else {
      return Color(0xff07c53c);
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
  Map<String, dynamic> requested = {};
  Widget buildRequestItem2(
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
                    color: dropdownStatus2 == "Requested"
                        ? Colors.lightBlueAccent.shade100
                        : Color(0xff57ff86),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '$dropdownStatus2',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: dynamicFontColor(dropdownStatus2),
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
  Future<void> fetchRequested() async {
    try {
      String? token = tkn;
      final response = await approvedList(token!);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          requested = responseData;
        });
        print(requested);
      } else {
        print("Error fetching vendors. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching vendors: $error");
    }
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
                                    final vendors = vendorDetails['vendors'] as List<dynamic>?;
                                    if (vendors != null && index < vendors.length) {
                                      final vendor = vendors[index];
                                      final String id = vendor['_id'];
                                      return GestureDetector(
                                        onTap: () {

                                          Future<dynamic> getAllVendorsDetails(String token) async {
                                            try {
                                              final response = await http.get(
                                                Uri.parse('https://fierce-lime-pajamas.cyclic.app/admin/settle/coupon/$id'),
                                                headers: {
                                                  'Authorization': 'Bearer $token',
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
                                          Future<void> fetchVendorsDetails() async {
                                            try {
                                              String? token = tkn;
                                              final response = await getAllVendorsDetails(tkn!);

                                              if (response.statusCode == 200) {
                                                final responseData = jsonDecode(response.body);
                                                setState(() {
                                                  details = responseData; // Initialize the vendorDetails map with the parsed JSON data
                                                });
                                                print(details);
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>list()));


                                              } else {
                                                print(response.body);
                                                print("Error fetching vendors. Status code: ${response.statusCode}");
                                              }
                                            } catch (error) {
                                              print("Error fetching vendors: $error");
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
                        : Container(
                            child: SingleChildScrollView(
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
                                    itemCount: 3,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
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
                                                                  "Sardars",
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
                                                                  "used by Gaurav",
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
                                                                  "500\nPTS",
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
                                                                "YWHJ-4RR7-A25K",
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
                                                                  "1500",
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
                                                                  "$dropdownStatus2",
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
                                                          onTap: () {
                                                            setState(() {
                                                              dropdownStatus2 =
                                                                  "Approved";
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 327,
                                                            height: 56,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: dropdownStatus2 ==
                                                                      "Requested"
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
                                                                dropdownStatus2 ==
                                                                        "Requested"
                                                                    ? "Approve"
                                                                    : "Go back",
                                                                style:
                                                                    TextStyle(
                                                                  color: dropdownStatus2 ==
                                                                          "Requested"
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
                                        child: buildRequestItem2('Vendor Name',
                                            "vendor id", "21st JUN 2022"),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )),
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