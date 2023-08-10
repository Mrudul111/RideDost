import 'package:flutter/material.dart';

import 'Global/colors.dart';
import 'main.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}


class _RequestPageState extends State<RequestPage> {
  bool is1Active = false;
  bool is2Active = false;
  bool is3Active = false;
  String status = "STATUS";
  Color dynamicFontColor(String status) {
    if (status == "STATUS") {
      return FCColors.brightRed; // Replace with the desired color for Status1
    } else if (status == "PENDING") {
      return Colors.blue; // Replace with the desired color for Status2
    } else if (status == "REQUESTED") {
      return Color(0xfff2a715); // Replace with the desired color for Status3
    } else {
      return Color(0xff157bf2); // Default color if none of the above conditions match
    }
  }
  @override
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
            fontSize: 20,
            fontFamily: "SF Pro Display",
            color: Color(0xff1d3a70)
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 30,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            is1Active = true;
                            is2Active = false;
                            is3Active = false;

                          });
                        },
                        child: Container(
                          height: 31,
                          width: 122,
                          decoration: BoxDecoration(
                            color: is1Active ? Color(0xff2c2c2c) : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              "Send Request",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is1Active? Colors.white:Color(0xff828282)
                              ),
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
                            is3Active = false;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: 72,
                          decoration: BoxDecoration(
                              color:
                              is2Active ? Color(0xff2c2c2c) : Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              "Approve",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is2Active? Colors.white: Color(0xff828282)
                              ),
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
                            is2Active = false;
                            is3Active = true;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: 149,
                          decoration: BoxDecoration(
                              color:
                              is3Active ? Color(0xff2c2c2c) : Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              "Payment Settlement",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is3Active? Colors.white: Color(0xff828282)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 335,
                      height: 449,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(height: 10.0),
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 335,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage:  NetworkImage("https://static.wikia.nocookie.net/breakingbad/images/8/8e/BCS_S6_Portrait_Jimmy.jpg/revision/latest/scale-to-width-down/350?cb=20220802210840"),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Vendor Name',
                                                style: TextStyle(
                                                  color: HexColor.fromHex("#150A33"),
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "vendor id",
                                                style: TextStyle(
                                                  fontFamily: "DM Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff524b6b)
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: HexColor.fromHex("#FF5757").withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          '$status',
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
                                SizedBox(height: 30,),
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
                                              color: Color(0xff737784)
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                color: Color(0xff737784),
                                                size: 9,
                                              ),
                                              Text(
                                                "21st JUN 2022",
                                                style: TextStyle(
                                                    fontFamily: "DM Sans",
                                                    fontSize: 9.21,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff737784)
                                                ),
                                              )
                                            ],
                                          )
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
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
