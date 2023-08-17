// dashboard_screen.dart



import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/adminApi.dart';

import 'api/jsonAPI.dart';
import 'login.dart';
import 'main.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 0;
  Map<String, dynamic> vendorDetails = {}; // Initialize an empty map
  List<dynamic> coupons = []; // Initialize an empty list for coupons


  void initState() {
    super.initState();
    fetchVendors();
    fetchCoupons();
  }
  Future<void> fetchCoupons() async {
    try {
      String? token = await Login2(phno);
      final response = await getAllCoupons(token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['newCoupons'] != null && responseData['newCoupons'] is List) {
          setState(() {
            coupons = List.from(responseData['newCoupons']);
          });
        } else {
          print("Error fetching coupons: Invalid data format");
        }
      } else {
        print("Error fetching coupons. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching coupons: $error");
    }
  }

  Future<void> fetchVendors() async {
    try {
      String? token = await Login2(phno);
      final response = await getAllVendors(token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          vendorDetails = responseData; // Initialize the vendorDetails map with the parsed JSON data
        });
      } else {
        print("Error fetching vendors. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching vendors: $error");
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
                    Container(
                      height: 50.0,
                      decoration:  BoxDecoration(
                          color: currentRoute == '/manageteam' ? Colors.blue : Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0))),
                      child: TextButton(
                        onPressed: () {

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
                          color: currentRoute == '/vendor' ? Color(0xff3574f2) : Colors.transparent,

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
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                        color: Color(0xFF737784),
                        fontSize: 18
                    ),
                  ),
                  Text(
                    "Mrudul Killedar",
                    style: TextStyle(
                        color: Color(0xFF1D3A70),
                        fontSize: 28
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 365,
                    width: 327,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 20,),
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
                          Navigator.pushNamed(context, '/vendor');
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
                        itemCount: vendorDetails['vendors']?.length ?? 0,
                        itemBuilder: (context, index) {
                          final vendor = vendorDetails['vendors']?[index];
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
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage: const NetworkImage("https://upload.wikimedia.org/wikipedia/en/3/34/Jimmy_McGill_BCS_S3.png"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                width: 2,             // Adjust the width of the vertical line
                                                height: 12,           // Adjust the height of the vertical line
                                                color: Color(0xffa3aed0),  // Set the color of the vertical line
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 76,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.mail_outline_rounded,
                                                      size: 12,
                                                      color: Color(0xffa3aed0),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                        vendor['email'],
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xffa3aed0),
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
                    dotsCount: vendorDetails['vendors']?.length??1,
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
                  SizedBox(height: 10,),
                  SizedBox(
                    width: 351,
                    height: 357.31  ,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => SizedBox(height: 16.0),
                      shrinkWrap: true,
                      itemCount: coupons.length,
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
                                height: 54.09,
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
                    )

                  ),

                ],
              ),
            ),
          ),
        ),
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
            icon: CircleAvatar(child: Icon(Icons.qr_code_scanner), radius: 25,),
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

    );
  }
}
