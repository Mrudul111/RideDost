import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:token/manageVendor.dart';

import 'api/jsonAPI.dart';
import 'dashboard.dart';

class vendorList extends StatefulWidget {
  const vendorList({super.key});

  @override
  State<vendorList> createState() => _vendorListState();
}

class _vendorListState extends State<vendorList> {
  bool toggleValue = true;
  int totalpages = 1;
  int currentPage = 0;
  List<dynamic> suspendedVendors = [];

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
  Future<List<Map<String, dynamic>>> fetchSuspended(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;
      final response = await suspendVendor(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['vendorsList'] != null && responseData['vendorsList'] is List) {
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
  @override
  void initState() {
    // TODO: implement initState
    fetchSuspended(currentPage);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor List'),
      ),
      body: SafeArea(
        child: Container(
          child: SizedBox(
            height: 348,
            width: 375,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: totalpages, // Number of pages
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page+1;
                });
                print("current page $page");
              },
              itemBuilder: (context, pageIndex) {
                return FutureBuilder<List<Map<String, dynamic>>?>(
                  future: fetchSuspended(currentPage),
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
                      vendors = snapshot.data ?? [];
                      return SizedBox(
                        width: 351,
                        height: 357.31,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.0),
                          shrinkWrap: true,
                          itemCount: 4,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
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
            ),
          )
        ),
      ),
    );
  }
}
