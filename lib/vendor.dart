import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:token/productlisting.dart';
import 'package:token/profilePage.dart';
import 'Global/colors.dart';
import 'addvendor.dart';
import 'api/jsonAPI.dart';
import 'dashboard.dart';
import 'login.dart';

class VendorList extends StatefulWidget {
  final ValueNotifier<String> activeFilter;

  const VendorList({Key? key, required this.activeFilter}) : super(key: key);
  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  ValueNotifier<String> activeFilter = ValueNotifier<String>('New Vendor');
  bool toggleValue = true;
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  @override
  void initState() {
    setState(() {
      is1Active = true;
      is2Active = false;
      fetchValid(currentPage);
      fetchPending(currentPage);
      fetchVendors(currentPage);
    });
    super.initState();
  }

  bool is1Active = false;
  bool is2Active = false;
  GlobalKey _listKey = GlobalKey();
  GlobalKey _otherListKey = GlobalKey();
  int totalpages = 1;
  int currentPage = 0;

  int totalpages2 = 1;
  int currentPage2 = 0;

  int totalpages3 = 1;
  int currentPage3 = 0;
  int c = 0;
  List<dynamic> vendors = [];
  List<dynamic> pending = [];
  List<dynamic> valid = [];

  Color dynamicFontColor(String status) {
    if (status == "reject") {
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
    if (status == "reject") {
      return Color.fromRGBO(255, 87, 87, 0.1);
    } else if (status == "pending") {
      return Color(0xfffa857);
    } else if (status == "requested") {
      return Colors.lightBlueAccent;
    } else {
      return Color.fromRGBO(87, 255, 134, 0.1);
    }
  }// Initialize an empty map

  Future<List<Map<String, dynamic>>> fetchVendors(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;

      final response = await getVendors(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['vendorsList'] != null &&
            responseData['vendorsList'] is List) {
          final List<Map<String, dynamic>> fetchedVendors =
              List.from(responseData['vendorsList']);
          totalpages = responseData['totalPages'];
          print(fetchedVendors);

          return fetchedVendors; // Return the fetched data
        } else {
          print("Error fetching coupons: Invalid data format");
          // Return an empty list or handle the error case as needed
          return [];
        }
      } else{
        // Return an empty list or handle the error case as needed
        return [];
      }
    } catch (error) {
      print("Error fetching Vendors: $error");
      // Return an empty list or handle the error case as needed
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> fetchValid(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;

      final response = await validVendor(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['vendorsList'] != null &&
            responseData['vendorsList'] is List) {
          final List<Map<String, dynamic>> fetchedVendors =
          List.from(responseData['vendorsList']);
          totalpages = responseData['totalPages'];
          print(fetchedVendors);

          return fetchedVendors; // Return the fetched data
        } else {
          print("Error fetching coupons: Invalid data format");
          // Return an empty list or handle the error case as needed
          return [];
        }
      } else{
        // Return an empty list or handle the error case as needed
        return [];
      }
    } catch (error) {
      print("Error fetching Vendors: $error");
      // Return an empty list or handle the error case as needed
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> fetchSuspended(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;
      final response = await suspendVendor(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['vendorsList'] != null &&
            responseData['vendorsList'] is List) {
          final List<Map<String, dynamic>> fetchedCoupons =
              List.from(responseData['vendorsList']);
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

  Future<List<Map<String, dynamic>>> fetchPending(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;
      final response = await pendingVendor(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['vendorsList'] != null &&
            responseData['vendorsList'] is List) {
          final List<Map<String, dynamic>> fetchedCoupons =
              List.from(responseData['vendorsList']);
          totalpages = responseData['totalPages'];
          print(responseData['vendorsList']);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff1d3a70),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFF2F2F2),
          title: Text(
            "New Vendor",
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff1d3a70)),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  is1Active = true;
                                  is2Active = false;
                                });
                              },
                              child: Container(
                                height: 31,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: is1Active
                                      ? Color(0xff2c2c2c)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: is1Active
                                            ? Colors.white
                                            : Color(0xff828282)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  is1Active = false;
                                  is2Active = true;
                                });
                              },
                              child: Container(
                                height: 31,
                                width: 97,
                                decoration: BoxDecoration(
                                    color: is2Active
                                        ? Color(0xff2c2c2c)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    "New Vendor",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: is2Active
                                            ? Colors.white
                                            : Color(0xff828282)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Icon(Icons.filter_list_alt),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(34),
                                        topRight: Radius.circular(34))),
                                builder: (context) {
                                  return filterPopUp(
                                    activeFilter: activeFilter,
                                  );
                                });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ValueListenableBuilder<String>(
                        valueListenable: activeFilter,
                        builder: (context, filter, child) {
                          int trigger = 1;
                          if (filter == "New Vendor") {
                            return SizedBox(
                              height: 348,
                              width: 375,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: totalpages,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentPage = page + 1;
                                    });
                                  },
                                  itemBuilder: (context, pageIndex) {
                                    return FutureBuilder<
                                        List<Map<String, dynamic>>?>(
                                      future: fetchVendors(currentPage),
                                      builder: (context, snapshot) {
                                        print(
                                            "Connection State: ${snapshot.connectionState}");
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
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
                                          vendors = snapshot.data ?? [];
                                          return ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(height: 16.0),
                                            shrinkWrap: true,
                                            itemCount: vendors.length,
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              if (vendors != null &&
                                                  index < vendors.length) {
                                                if (is1Active == false &&
                                                    is2Active == true) {
                                                  vendors = List.from(
                                                      vendors.reversed);
                                                }
                                                final vendor = vendors[index];
                                                return Container(
                                                  height: 77,
                                                  width: 327,
                                                  decoration: BoxDecoration(
                                                    color: Color(0XFFFFFFFF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          CircleAvatar(
                                                              radius: 30,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://static.vecteezy.com/system/resources/previews/014/212/681/original/female-user-profile-avatar-is-a-woman-a-character-for-a-screen-saver-with-emotions-for-website-and-mobile-app-design-illustration-on-a-white-isolated-background-vector.jpg')),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                vendor[
                                                                    'name'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14,
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 80,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color: dynamicBGColor(
                                                                        vendor[
                                                                            'status'])),
                                                                child: Center(
                                                                  child: Text(
                                                                    vendor[
                                                                        'status'],
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                            "DM Sans",
                                                                        color:
                                                                            dynamicFontColor(vendor['status'])),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container())
                                                    ],
                                                  ),
                                                );
                                              }
                                              else if (vendors != null && vendors.isEmpty) {
                                                return Center(
                                                  child: Text("No data available"),
                                                );
                                              }
                                              else{
                                                return CircularProgressIndicator();
                                              }
                                            },
                                          );
                                        }
                                        else {
                                          // Handle no data case
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    );
                                  }),
                            );
                          }
                          else if (filter == "Approved Vendor") {
                            return SizedBox(
                              height: 348,
                              width: 375,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: totalpages2,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentPage2 = page + 1;
                                    });
                                  },
                                  itemBuilder: (context, pageIndex) {
                                    return FutureBuilder<
                                        List<Map<String, dynamic>>?>(
                                      future: fetchValid(currentPage2),
                                      builder: (context, snapshot) {
                                        print(
                                            "Connection State: ${snapshot.connectionState}");
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
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
                                          valid = snapshot.data ?? [];
                                          return ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder:
                                                (context, index) =>
                                                SizedBox(height: 16.0),
                                            shrinkWrap: true,
                                            itemCount: valid.length,
                                            physics:
                                            AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              if (valid != null &&
                                                  index < valid.length) {
                                                final vendor = valid[index];
                                                return Container(
                                                  height: 77,
                                                  width: 327,
                                                  decoration: BoxDecoration(
                                                    color: Color(0XFFFFFFFF),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          CircleAvatar(
                                                              radius: 30,
                                                              backgroundImage:
                                                              NetworkImage(
                                                                  'https://static.vecteezy.com/system/resources/previews/014/212/681/original/female-user-profile-avatar-is-a-woman-a-character-for-a-screen-saver-with-emotions-for-website-and-mobile-app-design-illustration-on-a-white-isolated-background-vector.jpg')),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                vendor[
                                                                'name'],
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  14,
                                                                  fontFamily:
                                                                  'DM Sans',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 80,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        15),
                                                                    color: dynamicBGColor(
                                                                        vendor[
                                                                        'status'])),
                                                                child: Center(
                                                                  child: Text(
                                                                    vendor[
                                                                    'status'],
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                        "DM Sans",
                                                                        color:
                                                                        dynamicFontColor(vendor['status'])),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(10.0),
                                                          child: Container())
                                                    ],
                                                  ),
                                                );
                                              }
                                              else if (valid != null && valid.isEmpty) {
                                                return Center(
                                                  child: Text("No data available"),
                                                );
                                              }
                                              else{
                                                return CircularProgressIndicator();
                                              }
                                            },
                                          );
                                        }
                                        else {
                                          // Handle no data case
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    );
                                  }),
                            );
                          } else {
                            return SizedBox(
                              height: 348,
                              width: 375,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: totalpages3,
                                  onPageChanged: (int page) {
                                    setState(() {
                                      currentPage3 = page + 1;
                                    });
                                  },
                                  itemBuilder: (context, pageIndex) {
                                    if(vendors.isEmpty){
                                      return Center(
                                        child: Text("No data available"),
                                      );
                                    }
                                    return FutureBuilder<
                                        List<Map<String, dynamic>>?>(
                                      future: fetchPending(currentPage),
                                      builder: (context, snapshot) {
                                        print(
                                            "Connection State: ${snapshot.connectionState}");
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
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
                                          pending = snapshot.data ?? [];
                                          return ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder:
                                                (context, index) =>
                                                SizedBox(height: 16.0),
                                            shrinkWrap: true,
                                            itemCount: pending.length,
                                            physics:
                                            AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              int c = 0;
                                              if (pending != null &&
                                                  index < pending.length) {
                                                final vendor = pending[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
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
                                                                    vertical: 20,
                                                                    horizontal:
                                                                    30),
                                                                height: 250,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft: Radius
                                                                            .circular(
                                                                            34),
                                                                        topRight:
                                                                        Radius.circular(
                                                                            34))),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                                  children: [
                                                                    Container(
                                                                      height: 6,
                                                                      width: 60,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xffdfe2be),
                                                                          borderRadius: BorderRadius.circular(10)),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 20,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                vendor['name'],
                                                                                style:
                                                                                TextStyle(
                                                                                  fontSize: 25,
                                                                                  fontFamily: "SF Pro Display",
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: Color(0xff150b3d),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                vendor['_id'],
                                                                                style:
                                                                                TextStyle(
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
                                                                    ),
                                                                    SizedBox(
                                                                      height: 30,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Row(
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

                                                                                // rejectVendor(id, tkn, reason);
                                                                              },
                                                                              child:
                                                                              Container(
                                                                                width:
                                                                                150,
                                                                                height:
                                                                                28,
                                                                                decoration:
                                                                                BoxDecoration(
                                                                                  color:
                                                                                  Colors.white,
                                                                                  border:
                                                                                  Border.all(color: Color(0xff3574f2)),
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(30),
                                                                                ),
                                                                                child:
                                                                                Center(
                                                                                  child:
                                                                                  Text(
                                                                                    "Reject",
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
                                                                            GestureDetector(
                                                                              onTap:
                                                                                  () async{
                                                                                 await approveVendor(
                                                                                    vendor['_id'],
                                                                                    tkn!);
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
                                                                                  color:
                                                                                  Color(0xff3574f2),
                                                                                  border:
                                                                                  Border.all(color: Color(0xff3574f2)),
                                                                                  borderRadius:
                                                                                  BorderRadius.circular(30),
                                                                                ),
                                                                                child:
                                                                                Center(
                                                                                  child:
                                                                                  Text(
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
                                                                        ),
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
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                      setState(() {

                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 77,
                                                    width: 327,
                                                    decoration: BoxDecoration(
                                                      color: Color(0XFFFFFFFF),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          15),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            CircleAvatar(
                                                                radius: 30,
                                                                backgroundImage:
                                                                NetworkImage(
                                                                    'https://static.vecteezy.com/system/resources/previews/014/212/681/original/female-user-profile-avatar-is-a-woman-a-character-for-a-screen-saver-with-emotions-for-website-and-mobile-app-design-illustration-on-a-white-isolated-background-vector.jpg')),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  vendor[
                                                                  'name'],
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    14,
                                                                    fontFamily:
                                                                    'DM Sans',
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 80,
                                                                  height: 20,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          15),
                                                                      color: dynamicBGColor(
                                                                          vendor[
                                                                          'status'])),
                                                                  child: Center(
                                                                    child: Text(
                                                                      vendor[
                                                                      'status'],
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                          "DM Sans",
                                                                          color:
                                                                          dynamicFontColor(vendor['status'])),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                            child: Container())
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              else if (pending != null && pending.isEmpty) {
                                                return Center(
                                                  child: Text("No data available"),
                                                );
                                              }
                                              else{
                                                return CircularProgressIndicator();
                                              }
                                            },
                                          );
                                        }
                                        else {
                                          // Handle no data case
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    );
                                  }),
                            );
                          }
                        }),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(34),
                                    topRight: Radius.circular(34))),
                            builder: (context) {
                              return floatingButtonPopUp();
                            });
                      },
                      child: Icon(
                        Icons.add,
                      ),
                      backgroundColor: Color(0xff111322),
                    ))
              ],
            ),
          ),
        ));
  }
}

class VendorListItem extends StatefulWidget {
  const VendorListItem({Key? key}) : super(key: key);

  @override
  State<VendorListItem> createState() => _VendorListItemState();
}

class _VendorListItemState extends State<VendorListItem> {
  bool toggleValue = true;
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      width: 327,
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/en/3/34/Jimmy_McGill_BCS_S3.png"),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: toggleValue ? Colors.green : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Vendor Name",
                    style: TextStyle(
                      fontSize: 16.25,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 20, // Reduced height
                    width: 40, // Reduced width
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15.0), // Adjusted border radius
                      color: toggleValue ? Colors.green : Colors.grey,
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          child: InkWell(
                            onTap: toggleButton,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 30),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: toggleValue
                                  ? Icon(Icons.circle,
                                      color: Colors.white,
                                      size: 15,
                                      key: UniqueKey())
                                  : Icon(Icons.circle,
                                      color: Colors.white,
                                      size: 15,
                                      key: UniqueKey()),
                            ),
                          ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          top: 2,
                          left: toggleValue ? 20 : 0,
                          right: toggleValue ? 0.0 : 20,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.delete_outline_outlined, color: Color(0xff524b6b))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class filterPopUp extends StatefulWidget {
  final ValueNotifier<String> activeFilter;

  const filterPopUp({Key? key, required this.activeFilter}) : super(key: key);

  @override
  State<filterPopUp> createState() => _filterPopUpState();
}

class _filterPopUpState extends State<filterPopUp> {
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  void initState() {
    super.initState();
    // Set the initial filter value based on the activeFilter
    if (widget.activeFilter.value == "New Vendor") {
      setState(() {
        isClicked1 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: 875,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: 400,
        decoration: BoxDecoration(
            color: Color(0xfff2f2f2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34), topRight: Radius.circular(34))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                    color: Color(0xffdfe2be),
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked1 = true;
                    isClicked2 = false;
                    isClicked3 = false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked1
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked1
                            ? Icon(Icons.check,
                                color: Color(0xff3574f2), size: 10)
                            : Icon(null)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "New Vendor",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DM Sans"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked2 = true;
                    isClicked1 = false;
                    isClicked3 = false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked2
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked2
                            ? Icon(Icons.check,
                                color: Color(0xff3574f2), size: 10)
                            : Icon(null)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Approved Vendor",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DM Sans"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked3 = true;
                    isClicked2 = false;
                    isClicked1 = false;
                  });
                },
                child: Row(
                  children: [
                    Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked3
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked3
                            ? Icon(
                                Icons.check,
                                color: Color(0xff3574f2),
                                size: 10,
                              )
                            : Icon(null)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Pending",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DM Sans"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                width: 335,
                color: Color(0xffdee1e7),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked1 = false;
                        isClicked2 = false;
                        isClicked3 = false;
                        widget.activeFilter.value = "New Vendor";
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      width: 75,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff3c3c3c)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isClicked1) {
                          widget.activeFilter.value = "New Vendor";
                        } else if (isClicked2) {
                          widget.activeFilter.value = "Approved Vendor";
                        } else if (isClicked3) {
                          widget.activeFilter.value = "Pending";
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff3574F2),
                      ),
                      child: Center(
                        child: Text(
                          "APPLY NOW",
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
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

class floatingButtonPopUp extends StatefulWidget {
  const floatingButtonPopUp({Key? key}) : super(key: key);

  @override
  State<floatingButtonPopUp> createState() => _floatingButtonPopUpState();
}

class _floatingButtonPopUpState extends State<floatingButtonPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(34), topRight: Radius.circular(34))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 6,
              width: 60,
              decoration: BoxDecoration(
                  color: Color(0xffdfe2be),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffeff7ff)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15)),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddVendor()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_outlined,
                      color: Color(0xff3574f2),
                      size: 27,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add Vendor',
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3574f2),
                          fontSize: 16.0),
                    ),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffeff7ff)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 15)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => productListing()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_upload_outlined,
                      color: Color(0xff3574f2),
                      size: 27,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Product Listing',
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3574f2),
                          fontSize: 16.0),
                    ),
                  ],
                )),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
