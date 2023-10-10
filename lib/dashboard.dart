// dashboard_screen.dart



import 'dart:convert';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:token/profilePage.dart';
import 'activity.dart';
import 'api/adminApi.dart';

import 'api/jsonAPI.dart';
import 'cameraQR.dart';
import 'login.dart';
import 'main.dart';
import 'myCard.dart';

String id = '';
List<dynamic> coupons = [];
Map<String, dynamic> vendorDetails = {};

int selectedIndex = 0;
final List<Widget> pages = [
  DashboardScreen(),
  myCard(),
  cameraQR(),
  activity(),
  profilePage()
];
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 0;
  int currentPage2 = 0;
  Map<String, dynamic>? profile = {};
  String username = "";


  int totalpages = 1;
  void initState() {
    super.initState();
    fetchProfileInfo();
    chartData(tkn);
    fetchVendors();
    fetchCoupons(currentPage2);
  }
   Map<dynamic, dynamic> chartValue = {};
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

  Future<void> fetchVendors() async {
    try {
      String? token = tkn;
      final response = await getAllVendors(token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          vendorDetails = responseData; // Initialize the vendorDetails map with the parsed JSON data
        });
        print(vendorDetails);
      } else {
        print("Error fetching vendors. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching vendors: $error");
    }
  }
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
            username = vendorInfo['name'];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xFFF2F2F2),
      ),
      drawer: Drawer(

        width: MediaQuery.of(context).size.width * 0.8,
        child: Builder(

          builder: (BuildContext context) {
            String currentRoute = ModalRoute.of(context)?.settings.name ?? '';
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 50,),
                    Image(image: AssetImage('assets/images/rd 1.png'),fit: BoxFit.fitWidth,),
                    SizedBox(height: 50,),
                    Container (
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/dashboard' ? Color(0xff3574f2) : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.dashboard,
                              color:  currentRoute=='/dashboard'? Colors.white : Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                  color:  currentRoute=='/dashboard'? Colors.white : Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container (
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/profile' ? Color(0xff3574f2) : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              color:  currentRoute=='/profile'? Colors.white : Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  color:  currentRoute=='/profile'? Colors.white : Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/vendor' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/vendor');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Manage Team',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/addvendor' ? Color(0xff3574f2) : Colors.transparent,

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addvendor');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.group_add_outlined,
                              color: currentRoute=='/addvendor'?Colors.black:Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Add Vendor',
                              style: TextStyle(
                                  color: currentRoute=='/addvendor'?Colors.black:Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/manageteam' ? Color(0xff3574f2) : Colors.transparent,

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/manageteam');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.groups,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Vendor List',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration: const BoxDecoration(

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/listing');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Product List',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration: const BoxDecoration(

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/request');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.send_rounded,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Send Request',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration: const BoxDecoration(

                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/dailyreport');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.access_alarm_outlined,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Daily Status',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/checkout' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Checkout',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50.0,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed:  () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Color(0xFF737784),
                              size: 30.0,
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                  color: Color(0xFF737784),
                                  fontSize: 18.0,
                                  fontFamily: 'Mazzart',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: SafeArea(

        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(


            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome back!",
                            style: TextStyle(
                                color: Color(0xFF737784),
                                fontSize: 18
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/notification');
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xfff9fafb),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Icon(
                                Icons.notifications_none_outlined
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        username,
                        style: TextStyle(
                            color: Color(0xFF1D3A70),
                            fontSize: 28
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 365,
                    width: 327,
                    child: LineChartSample2(),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vendor List",
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/manageteam');
                        },
                        child: Row(
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                color: Color(0XFF3574F2),
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              (Icons.arrow_right_alt),
                              color: Color(0XFF3574F2),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                      width: 662,
                      height: 85   ,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final vendors = vendorDetails['vendorsList'] as List<dynamic>?;
                        if (vendors != null && index < vendors.length) {
                          final vendor = vendors[index];
                          id = vendor['_id'];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Color(0XFFFFFFFF),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage: const NetworkImage(
                                            "https://upload.wikimedia.org/wikipedia/en/3/34/Jimmy_McGill_BCS_S3.png"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Text(
                                            vendor['name'],
                                            style: TextStyle(
                                              color: Color(0xff1b2559),
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone_outlined,
                                                size: 12,
                                                color: Color(0xffa3aed0),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                vendor['phoneNumber'],
                                                style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffa3aed0),
                                                ),
                                              ),
                                              SizedBox(width: 5,),
                                              Container(
                                                width: 2,
                                                // Adjust the width of the vertical line
                                                height: 12,
                                                // Adjust the height of the vertical line
                                                color: Color(
                                                    0xffa3aed0), // Set the color of the vertical line
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 76,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .mail_outline_rounded,
                                                      size: 12,
                                                      color: Color(0xffa3aed0),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        vendor['email'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Color(
                                                              0xffa3aed0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        },
                        onPageChanged: (index) {
                          // Update the current page index when the page changes
                          setState(() {
                            currentPage = index;
                          });
                        },
                      )
                  ),
                Center(
                  child: DotsIndicator(
                    dotsCount: 4,
                    position: currentPage,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeColor: Color(0xff1d3a70)
                    ),
                  ),
                ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupon",
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/coupon');
                        },
                        child: Row(
                          children: [
                            Text(
                              "View all",
                              style: TextStyle(
                                color: Color(0XFF3574F2),
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              (Icons.arrow_right_alt),
                              color: Color(0XFF3574F2),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
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
                              return SizedBox(
                                width: 351,
                                height: 357.31,
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final coupon = coupons[index];

                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0XFFFFFFFF),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 5.28,
                                            height: 70.09,
                                            decoration: BoxDecoration(
                                              color: Color(0XFF3574F2),
                                              borderRadius: BorderRadius.circular(21.0),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  coupon['couponCode'],
                                                  style: TextStyle(
                                                    color: Color(0xff1b2559),
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  coupon['userName'],
                                                  style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xffa3aed0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            coupon['point'] + " pts",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff737784),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    );
                                  },
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

                  ),

                ],
              ),
            ),
          ),
        ),
      ),


    );
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Color(0xff1d3cab),
    Color(0xff2f35b9)
  ];
  List<dynamic> arr = [1,1,1,1,1,1,1];
  Map<String, dynamic> chartValue = {};
  Future<void> fetchChartData() async {
    try {
      String? token = tkn;
      final response = await chartData(token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List<dynamic> dayDataList = responseData['daydata'];
        arr = dayDataList.map((dayData) => dayData['value']).toList();
        setState(() {
          chartValue = responseData; // Initialize the vendorDetails map with the parsed JSON data
        });
      } else {
        print("Error fetching vendors. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching vendors: $error");
    }
  }
  void getChartValues(List<dynamic> arr) {
    fetchChartData();
    for (int i = 0; i < arr.length; i++) {
      if(arr[i]!=0) {
        arr[i] = (log(arr[i]) / log(10)).ceil();
      }
    }
  }
  bool showAvg = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChartData();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(

      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Center(
              child: Text(
                "Total Points Earned",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "DM Sans",
                  fontSize: 14,
                  color: Color(0xff6b7280),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                "5,215",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: "DM Sans",
                  fontSize: 24,
                  color: Color(0xff1d3a70),
                ),
              ),
            ),
            Row(

            )
          ],
        ),
        Container(
          width: 327,
          height: 365,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey
            )
          ),
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('Sun', style: style);
        break;
      case 5:
        text = const Text('Mon', style: style);
        break;
      case 8:
        text = const Text('Tue', style: style);
        break;
      case 11:
        text = const Text('Wed', style: style);
        break;
      case 14:
        text = const Text('Thr', style: style);
        break;
      case 17:
        text = const Text('Fri', style: style);
        break;
      case 20:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }


  LineChartData mainData() {
    final Map<int, String> indexToDayMap = {
      0: "S",
      1: "M",
      2: "T",
      3: "W",
      4: "T",
      5: "F",
      6: "S",
    };
    List<int> xValues = [2,5,8,11,14,17,20];
    getChartValues(arr);
    List<dynamic> yValues = arr;
    List<FlSpot> spots = List<FlSpot>.generate(xValues.length, (index) {
      double x = xValues[index].toDouble();
      double y = yValues[index].toDouble();
      return FlSpot(x, y);
    });
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,

        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: -0.5,
      maxX: 22,
      minY: -1,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Color(0xff1d3a70),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Color(0xff1d3cab).withOpacity(1.0),
                Color(0xff2f35b9).withOpacity(0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}