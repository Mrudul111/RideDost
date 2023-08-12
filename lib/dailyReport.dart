import 'package:flutter/material.dart';

class dailyReport extends StatefulWidget {
  const dailyReport({super.key});

  @override
  State<dailyReport> createState() => _dailyReportState();
}

class _dailyReportState extends State<dailyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(
          "Daily Status",
          style: TextStyle(
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff1d3a70)),
        ),
        backgroundColor: Color(0xfff2f2f2),
        iconTheme: IconThemeData(color: Color(0xff1d3a70)),
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
            icon: CircleAvatar(
              child: Icon(Icons.qr_code_scanner),
              radius: 25,
            ),
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
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => SizedBox(height: 16.0),
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 300,
                      height: 93,
                      decoration: BoxDecoration(
                          color: Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Data Title',
                                  style: TextStyle(
                                    color: Color(0xff1b2559),
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '21st JUL 2023',
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffa3aed0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: 375,
                                        height: 547,
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Color(0xffdfe2eb),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              width: 235,
                                              height: 200,
                                              child: Image.asset('assets/images/Frame 162397.png',fit: BoxFit.fitWidth,),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                              "Downloaded",
                                              style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22,
                                                color: Color(0xff191d31)
                                              ),
                                            ),
                                            Text(
                                              'Congratulation! your package will be picked up by the \ncourier, please wait a moment.',
                                              style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: Color(0xffa7a9b7)
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: 327,
                                                height: 56,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  border:Border.all(
                                                    color: Color(0xff3574f2),
                                                  )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Go Back",
                                                    style: TextStyle(
                                                        fontFamily: "DM Sans",
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16,
                                                        color: Color(0xff3574f2)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: 66,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Color(0xff3574f2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "Download",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
