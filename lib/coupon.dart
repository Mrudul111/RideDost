import 'package:flutter/material.dart';

class Coupon extends StatefulWidget {
  const Coupon({Key? key}) : super(key: key);

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  bool is1Active = false;
  bool is2Active = false;
  String day = "Today";
  int selectedContainer = 0;
  void showPopupMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(331.06, 387.43, 0, 0), // Adjust the position as needed
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
      backgroundColor: Color(0xfff9fbff),
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
                  width: 375,
                  height: 200,
                  color: Color(0xff1d3a70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        "Total Points",
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff5dbef5)
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "RD 12,256.00",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(width: 5,),
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
                      SizedBox(height: 10,),
                      Text(
                        "Linda Marsh . LIN-120RD",
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff9da8be)
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
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
                            color: is1Active || selectedContainer==0 ? Color(0xff334d8f) : Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0xff334d8f),
                            )
                          ),
                          child: Center(
                            child: Text(
                              "Rewards",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is1Active || selectedContainer==0? Colors.white:Color(0xff334d8f)
                              ),
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
                              color:
                              is2Active || selectedContainer!=0 ? Color(0xff334d8f) : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xff334d8f),
                              )
                          ),

                          child: Center(
                            child: Text(
                              "Transactions",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is2Active? Colors.white: Color(0xff334d8f)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 100),
                    child: selectedContainer == 0 ? Container(
                      key: ValueKey<int>(selectedContainer),
                      width: 325,
                      height: 315,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          mainAxisSpacing: 10.0, // Spacing between rows
                          crossAxisSpacing: 10.0, // Spacing between columns
                        ),
                        itemCount: 10, // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Apple Store",
                                  style: TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "30U2-95Q5-3V84 • Linda Marsh",
                                  style: TextStyle(
                                    fontFamily: "DM Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8,
                                    color: Color(0xff737784),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  width: 132.5,
                                  height: 1,
                                  color: Color(0xff737784),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  "Flat Rs 300 OFF on All Orders",
                                  style: TextStyle(
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11,
                                    color: Color(0xff150b3d),

                                  ),
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Generated",
                                          style: TextStyle(
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 8,
                                            color: Color(0xff150b3d),

                                          ),
                                        ),
                                        Text(
                                          "11 JUN 2023",
                                          style: TextStyle(
                                            fontFamily: "SF Pro Display",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Color(0xff3574F2),

                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xff3574f2)
                                      ),
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

                              ],
                            )
                          );
                        },
                      ),


                    ) : Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Transactions History",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '$day',
                                    style: TextStyle(
                                      color: Color(0xff969696),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      return showPopupMenu(context);
                                    },
                                    child: Container(
                                      width: 14.09,
                                      height: 14.09,
                                      child: Image.asset('assets/images/dropdown.png',fit: BoxFit.fitHeight ,),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          ListView.separated(
                            key: ValueKey<int>(selectedContainer),
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => SizedBox(height: 16.0),
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 321.34,
                                height: 56.96,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 56.17,
                                          height: 56.17,
                                          decoration: BoxDecoration(
                                            color: Color(0xfff3ebd9),
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          child: Center(
                                            child: Image.asset('assets/images/icon.png'),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Gym",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.85,
                                                fontFamily: "DM Sans",
                                              ),
                                            ),
                                            Text(
                                              "Payment",
                                              style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontSize: 10.3,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff5a5b78)
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    Text(
                                      "-40.99",
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
                          ),
                        ],
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
