import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:token/api/jsonAPI.dart';
import 'package:token/productlisting.dart';
import 'package:token/profilePage.dart';
import 'dashboard.dart';
import 'editListing.dart';

class listingPage extends StatefulWidget {
  const listingPage({super.key});

  @override
  State<listingPage> createState() => _listingPageState();
}

class _listingPageState extends State<listingPage> {
  int currentPage = 0;
  int totalpages = 2;
  List<dynamic> product = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchProducts(currentPage);
    super.initState();
  }
  Future<List<Map<String, dynamic>>> fetchProducts(int page) async {
    print("page in fetchCoupon $page");
    try {
      String? token = tkn;
      tkn = token;
      final response = await getProduct(page,id,token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['product'] != null && responseData['product'] is List) {
          final List<Map<String, dynamic>> fetchedCoupons =
          List.from(responseData['product']);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Product Listing',
          style: TextStyle(
            fontFamily: "DM Sans",
            fontWeight: FontWeight.w700,
            color: Color(0xff1d3a70)
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
            icon: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> profilePage()));
              },
              child: Container(
                width: 24,
                height: 24,
                child: Icon(Icons.person_outline_outlined),
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: SizedBox(
                    width: 323,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: totalpages,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page + 1;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            return FutureBuilder<List<Map<String, dynamic>>?>(
                              future: fetchProducts(currentPage),
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
                                  product = snapshot.data ?? [];
                                  return Center(
                                    child: GridView.builder(
                                      itemCount: product.length,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        final products = product[index];
                                        String url = 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXBwbGUlMjBsYXB0b3B8ZW58MHx8MHx8fDA%3D&w=1000&q=80';
                                        String description = 'Lores ispum';
                                        String productid = products['_id'];

                                        // Check if 'productimage' field is not empty in the 'products' object
                                        if (products['productimage'] != null && products['productimage'] != '') {
                                          url = products['productimage'];
                                        }

                                        // Check if 'description' field is not empty in the 'products' object
                                        if (products['description'] != null && products['description'] != '') {
                                          description = products['description'];
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(34),
                                                        topRight: Radius.circular(34))),
                                                builder: (context) {
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
                                                                    MaterialPageRoute(builder: (context) => editProductListing(id: products['_id'],name:products['name'],price:products['price'],description: products['description'],rating: products['rating'],url: products['productimage'])));
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
                                                                    'Edit Product',
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
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all(Color(0xffeff7ff)),
                                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8.0))),
                                                                padding: MaterialStateProperty.all(
                                                                    const EdgeInsets.symmetric(horizontal: 15)),
                                                              ),
                                                              onPressed: () {
                                                                deleteProduct(tkn!, products['_id']);
                                                                Navigator.pop(context);
                                                                setState(() {

                                                                });
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.delete,
                                                                    color: Color(0xff3574f2),
                                                                    size: 27,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'Delete Product',
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
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 126,
                                                    width: 154,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                      image: DecorationImage(
                                                        image: NetworkImage('$url'),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 131,
                                                  width: 154,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          products['name'] ?? 'Default Name', // Provide a default name if 'name' is missing
                                                          style: TextStyle(
                                                            fontFamily: "SF Pro Display",
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xff150b3d),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(
                                                          description,
                                                          style: TextStyle(
                                                            fontFamily: "SF Pro Display",
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w300,
                                                            color: Color(0xff150b3d),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text(
                                                          "Price",
                                                          style: TextStyle(
                                                            fontFamily: "SF Pro Display",
                                                            fontSize: 8,
                                                            fontWeight: FontWeight.w300,
                                                            color: Color(0xff150b3d),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(
                                                          products['price'] ?? '1000', // Provide a default rating if 'rating' is missing
                                                          style: TextStyle(
                                                            fontFamily: "SF Pro Display",
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xff3574f2),
                                                          ),
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
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns in the grid
                                        mainAxisSpacing: 20.0, // Spacing between rows
                                        crossAxisSpacing: 20.0, // Spacing between columns
                                        childAspectRatio: 0.5,
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
                          }),

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
