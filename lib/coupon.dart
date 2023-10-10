import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'api/jsonAPI.dart';
import 'login.dart';

List<dynamic> coupons = []; // Initialize an empty list for coupons

class Coupon extends StatefulWidget {
  const Coupon({Key? key}) : super(key: key);

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  bool is1Active = false;
  bool is2Active = false;
  String day = "Today";
  List<dynamic> settle = [];
  int selectedContainer = 0;
  int totalpages = 1;
  int currentPage = 0;
  int totalpage2 = 1;
  int currentPage2 = 0;
  Future<List<Map<String, dynamic>>> fetchCoupons(int page) async {
    print("page in fetchCoupon $page");
    try {

      final response = await getAllCoupons(page, tkn);
      print(tkn);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['couponlist'] != null && responseData['couponlist'] is List) {
          final List<Map<String, dynamic>> fetchedCoupons =
          List.from(responseData['couponlist']);
          totalpages = responseData['totalPages'];
          return fetchedCoupons; // Return the fetched data
        } else {
          print("Error fetching coupons: Invalid data format");
          // Return an empty list or handle the error case as needed
          return [];
        }
      } else {
        print("Error fetching coupons. Status code: ${response.statusCode}");
        // Return an empty list or handle the error case as needed
        return [];
      }
    } catch (error) {
      print("Error fetching coupons: $error");
      // Return an empty list or handle the error case as needed
      return [];
    }
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
          totalpage2 = responseData['totalPages'];
          print("total pages $totalpage2");
          return fetch; // Return the fetched data
        } else {
          print("Error fetching requested data: Invalid data format");
        }
      } else {
        print(
            "Payment settlement ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching requested data: $error");
    }

    // Return an empty list or handle the error case as needed
    return [];
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchCoupons(currentPage);
    super.initState();
  }

  void showPopupMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          331.06, 387.43, 0, 0), // Adjust the position as needed
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: Text('Today'),
          value: 'Today',
        ),
        PopupMenuItem(
          child: Text('Tomorrow'),
          value: 'Tomorrow',
        ),
        PopupMenuItem(
          child: Text('Before'),
          value: 'Before',
        ),
      ],
    );

    if (result != null) {
      setState(() {
        day = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1d3a70),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 21),
                  width: double.infinity,
                  height: 200,
                  color: Color(0xff1d3a70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Total Points",
                        style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5dbef5)),
                      ),
                      Row(
                        children: [
                          Text(
                            "RD 12,256.00",
                            style: TextStyle(
                                fontFamily: "DM Sans",
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Color(0xff7789a9),
                            child: Icon(
                              Icons.refresh_sharp,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Linda Marsh . LIN-120RD",
                        style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff9da8be)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                is1Active = true;
                                is2Active = false;
                              });
                              selectedContainer = 0;
                            },
                            child: Container(
                              width: 134.5,
                              height: 40.27,
                              decoration: BoxDecoration(
                                  color: is1Active || selectedContainer == 0
                                      ? Color(0xff334d8f)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0xff334d8f),
                                  )),
                              child: Center(
                                child: Text(
                                  "Rewards",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: is1Active || selectedContainer == 0
                                          ? Colors.white
                                          : Color(0xff334d8f)),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                is1Active = false;
                                is2Active = true;
                              });
                              selectedContainer = 1;
                            },
                            child: Container(
                              width: 134.5,
                              height: 40.27,
                              decoration: BoxDecoration(
                                  color: is2Active || selectedContainer != 0
                                      ? Color(0xff334d8f)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color(0xff334d8f),
                                  )),
                              child: Center(
                                child: Text(
                                  "Transactions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: is2Active
                                          ? Colors.white
                                          : Color(0xff334d8f)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 100),
                        child: selectedContainer == 0
                            ? SizedBox(
                            width: 351,
                            height: 357.31  ,

                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: totalpages, // Number of pages
                              onPageChanged: (int page) {
                                setState(() {
                                  currentPage2 = page+1;
                                });
                                print("current page $page");
                              },
                              itemBuilder: (context, pageIndex) {
                                return FutureBuilder<List<Map<String, dynamic>>?>(
                                  future: fetchCoupons(currentPage2),
                                  builder: (context, snapshot) {
                                    print("Connection State: ${snapshot.connectionState}");
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      // While waiting for data, display a loading screen
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      // Handle error if necessary
                                      return Center(
                                        child: Text("Error fetching data"),
                                      );
                                    }
                                    else if (snapshot.hasData) {
                                      // Data has been loaded, display your content
                                      coupons = snapshot.data ?? [];
                                      return Container(
                                        key: ValueKey<int>(selectedContainer),
                                        width: 325,
                                        height: 315,
                                        child: Center(
                                          child: GridView.builder(
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                              2, // Number of columns in the grid
                                              mainAxisSpacing:
                                              10.0, // Spacing between rows
                                              crossAxisSpacing:
                                              10.0, // Spacing between columns
                                            ),
                                            itemCount: coupons
                                                .length, // Number of items in the grid
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              final coupon = coupons[index];
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
                                                                          "Store Name",
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
                                                                          coupon[
                                                                          'couponCode'],
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
                                                                          coupon['point'] +
                                                                              "\nPTS",
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
                                                                  height: 50,
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
                                                                        coupon[
                                                                        'couponCode'],
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
                                                                          "No minimum purchase",
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
                                                                    showModalBottomSheet(
                                                                        context:
                                                                        context,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft:
                                                                                Radius.circular(
                                                                                    34),
                                                                                topRight:
                                                                                Radius.circular(
                                                                                    34))),
                                                                        builder:
                                                                            (context) {
                                                                          return QR();
                                                                        });
                                                                  },
                                                                  child: Container(
                                                                    width: 327,
                                                                    height: 56,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Color(
                                                                          0xff3574f2),
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        "Generate QR Code",
                                                                        style:
                                                                        TextStyle(
                                                                          color: Colors
                                                                              .white,
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
                                                child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(6),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Apple Store",
                                                          style: TextStyle(
                                                            fontFamily:
                                                            "SF Pro Display",
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          coupon['couponCode'] ??
                                                              "No Coupon Code",
                                                          style: TextStyle(
                                                            fontFamily: "DM Sans",
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 8,
                                                            color: Color(0xff737784),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          width: 132.5,
                                                          height: 1,
                                                          color: Color(0xff737784),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Flat Rs 300 OFF on All Orders",
                                                          style: TextStyle(
                                                            fontFamily:
                                                            "SF Pro Display",
                                                            fontWeight: FontWeight.w300,
                                                            fontSize: 11,
                                                            color: Color(0xff150b3d),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
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
                                                                  "Generated",
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                    "SF Pro Display",
                                                                    fontWeight:
                                                                    FontWeight.w300,
                                                                    fontSize: 8,
                                                                    color: Color(
                                                                        0xff150b3d),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  coupon[
                                                                  'expirationDate'],
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                    "SF Pro Display",
                                                                    fontWeight:
                                                                    FontWeight.w700,
                                                                    fontSize: 10,
                                                                    color: Color(
                                                                        0xff3574F2),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              width: 30,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(6),
                                                                  color: Color(
                                                                      0xff3574f2)),
                                                              child: Center(
                                                                child: Text(
                                                                  coupon['point'] ??
                                                                      "0",
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                    "SF Pro Display",
                                                                    fontWeight:
                                                                    FontWeight.w300,
                                                                    fontSize: 11,
                                                                    color: Color(
                                                                        0xffffffff),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Handle no data case
                                      return Center(
                                        child: Text("No data available"),
                                      );
                                    }
                                  },
                                );
                              },
                            )

                        )
                            : Container(
                          child: Container(
                            width: 335,
                            height: 449,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: totalpage2, // Number of pages
                              onPageChanged: (int page) {
                                setState(() {
                                  currentPage2 = page+1;
                                });
                                print("current page $page");
                              },
                              itemBuilder: (context, pageIndex) {
                                return FutureBuilder<
                                    List<Map<String, dynamic>>?>(
                                    future: fetchPaymentSettlement(currentPage2),
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
                                            return Container(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Transactions History",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      width: 335,
                                                      height: 449,
                                                      child: ListView.separated(
                                                        separatorBuilder:
                                                            (context, index) =>
                                                            SizedBox(height: 16.0),
                                                        shrinkWrap: true,
                                                        itemCount: 4,
                                                        physics:
                                                        AlwaysScrollableScrollPhysics(),
                                                        itemBuilder: (context, index) {
                                                          print('bruh');
                                                          return Container(
                                                            width: 321.34,
                                                            height: 56.96,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 56.17,
                                                                      height: 56.17,
                                                                      decoration: BoxDecoration(
                                                                        color: Color(0xfff3ebd9),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            14),
                                                                      ),
                                                                      child: Center(
                                                                        child: Image.asset(
                                                                            'assets/images/icon.png'),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          set['coupon']['couponCode'],
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.w500,
                                                                            fontSize: 16.85,
                                                                            fontFamily: "DM Sans",
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Payment',
                                                                          style: TextStyle(
                                                                              fontFamily:
                                                                              "DM Sans",
                                                                              fontSize: 10.3,
                                                                              fontWeight:
                                                                              FontWeight.w500,
                                                                              color: Color(
                                                                                  0xff5a5b78)),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  '${set['amount']}',
                                                                  style: TextStyle(
                                                                    fontFamily: "DM Sans",
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 16.85,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )

                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    });
                              },
                            ),
                          ),
                        )
                        ,
                      ),
                    ),
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

class couponBar extends StatefulWidget {
  const couponBar({Key? key}) : super(key: key);

  @override
  State<couponBar> createState() => _couponBarState();
}

class _couponBarState extends State<couponBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: 375,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Store Name",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w700,
                        color: Color(0xff150b3d),
                      ),
                    ),
                    Text(
                      coupons[0]['couponCode'],
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w300,
                        color: Color(0xff737784),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff3574f2)),
                  child: Center(
                    child: Text(
                      "500\nPTS",
                      style: TextStyle(
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 297,
              height: 50.13,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff150b3d),
                  width: 2.0, // Adjust the border width as needed
                ),
              ),
              child: Center(
                child: Text(
                  "YWHJ-4RR7-A25K",
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    color: Color(0xff150b3d),
                    fontWeight: FontWeight.w700,
                    fontSize: 22.7,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      color: Color(0xff737784),
                      size: 13.66,
                    ),
                    Text(
                      "No minimum purchase",
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
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(34),
                            topRight: Radius.circular(34))),
                    builder: (context) {
                      return QR();
                    });
              },
              child: Container(
                width: 327,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xff3574f2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34))
                ),
                child: Center(
                  child: Text(
                    "Generate QR Code",
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have any issue?",
                  style: TextStyle(
                    color: Color(0xff737784),
                    fontFamily: "SF Pro Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Color(0xff1d3a70),
                    fontFamily: "SF Pro Display",
                    fontSize: 16.94,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QR extends StatefulWidget {
  const QR({Key? key}) : super(key: key);

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: 375,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Container(
              child: QrImageView(
                data: 'AWKS-KVFR',
                size: 200,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 327,
                height: 56,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xff3574f2))),
                child: Center(
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have any issue?",
                  style: TextStyle(
                    color: Color(0xff737784),
                    fontFamily: "SF Pro Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Color(0xff1d3a70),
                    fontFamily: "SF Pro Display",
                    fontSize: 16.94,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

