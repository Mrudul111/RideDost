import 'dart:convert';

import 'package:flutter/material.dart';

import 'Global/colors.dart';
import 'api/jsonAPI.dart';
import 'dashboard.dart';
List<dynamic> vendors = [];

Color dynamicFontColor(String status) {
  if (status == "reject") {
    return FCColors.brightRed;
  } else if (status == "pending" || status=='suspended') {
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
  } else if (status == "pending" || status=='suspended') {
    return Color(0xfffa857);
  } else if (status == "requested") {
    return Colors.lightBlueAccent;
  } else {
    return Color.fromRGBO(87, 255, 134, 0.1);
  }
}
class manageVendor extends StatefulWidget {
  const manageVendor({super.key});

  @override
  State<manageVendor> createState() => _manageVendorState();
}

class _manageVendorState extends State<manageVendor> {
  int c = 0;
  bool is1Active = true;
  bool is2Active = false;
  List<dynamic> suspended = [];
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    bool is1Active = true;
    bool is2Active = false;
    fetchVendors(1).then((data) {
      setState(() {
        totalpages = data.length; // Set totalpages based on the initial data
      });
    });
     fetchVendors(currentPage);

  }
  int trigger = 0;
  int totalpages = 2;
  int currentPage = 0;
  int totalpages2 = 2;
  int currentPage2 = 0;
  Future<List<Map<String, dynamic>>> fetchVendors(int page) async {
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

      } else {
        print("Error fetching Vendors. Status code: ${response.statusCode}");
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

      } else {
        print("Error fetching Vendors. Status code: ${response.statusCode}");
        // Return an empty list or handle the error case as needed
        return [];
      }
    } catch (error) {
      print("Error fetching Vendors: $error");
      // Return an empty list or handle the error case as needed
      return [];
    }
  }

  Widget buildTopButtons(String text, bool isActive, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          is1Active = text == "All" ? true : false;
          is2Active = text == "Suspended" ? true : false;
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
          "Vendor List",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            fontFamily: "SF Pro Display",
            color: Color(0xff1d3a70),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    buildTopButtons("All", is1Active, screenWidth),
                    SizedBox(width: screenWidth * 0.01),
                    buildTopButtons("Suspended", is2Active, screenWidth),
                  ],
                ),
                SizedBox(height: 30,),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 500,
                    width: 375,
                    child: (is1Active==true && is2Active==false)?PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: totalpages,
                        onPageChanged: (int page) {
                          setState(() {
                            currentPage = page + 1;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          return FutureBuilder<List<Map<String, dynamic>>?>(
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
                                      final vendor = vendors[index];
                                      return AnimatedSwitcher(
                                          duration: Duration(milliseconds: 3000),
                                        key: UniqueKey(),
                                        child: CustomCard(
                                          vendor: vendor,
                                          suspend: (id, token) {
                                            // Call your API here for the clicked card
                                            suspend(id, token);
                                            setState(() {

                                            });
                                          },
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                );
                              } else {
                                // Handle no data case
                                return Center(
                                  child: Text("No data available"),
                                );
                              }
                            },
                          );
                        }):
                    SizedBox(
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
                              future: fetchSuspended(currentPage2),
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
                                  suspended = snapshot.data ?? [];
                                  return ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder:
                                        (context, index) =>
                                        SizedBox(height: 16.0),
                                    shrinkWrap: true,
                                    itemCount: suspended.length,
                                    physics:
                                    AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (suspended != null &&
                                          index < suspended.length) {
                                        final vendor = suspended[index];
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
                                      else if (suspended != null && suspended.isEmpty) {
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
                    ),
                  ),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
class CustomCard extends StatefulWidget {
  final Map<String, dynamic> vendor;
  final Function(String id, String token) suspend;

  CustomCard({required this.vendor, required this.suspend});

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool toggleValue = true;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/014/212/681/original/female-user-profile-avatar-is-a-woman-a-character-for-a-screen-saver-with-emotions-for-website-and-mobile-app-design-illustration-on-a-white-isolated-background-vector.jpg',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.vendor['name'],
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
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
                                      ? Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 15,
                                    key: UniqueKey(),
                                  )
                                      : Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 15,
                                    key: UniqueKey(),
                                  ),
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
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: dynamicBGColor(widget.vendor['status'])),
                        child: Center(
                          child: Text(
                            widget.vendor['status'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "DM Sans",
                                color: dynamicFontColor(widget.vendor['status'])),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(),
          )
        ],
      ),
    );
  }

  void toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
      setState(() {

      });// Toggle the state
    });

    // Check if the toggle is off
    if (!toggleValue) {
      // Call your API here
      widget.suspend(widget.vendor['_id'], tkn);
      setState(() {

      });
    }
  }
}

