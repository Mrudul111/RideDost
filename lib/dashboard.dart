// dashboard_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Color(0xFFFDFDFD),
      ),
      drawer: Drawer(

        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(

              children: [
                SizedBox(height: 50,),
                Image(image: AssetImage('assets/images/rd 1.png'),fit: BoxFit.fitWidth,),
                SizedBox(height: 50,),
                Container(
                  height: 50.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.dashboard,
                          color:  Color(0xFF737784),
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              color:  Color(0xFF737784),
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
                      mainAxisAlignment: MainAxisAlignment.center,

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
                  decoration: const BoxDecoration(

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0))),
                  child: TextButton(
                    onPressed: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.group_add_outlined,
                          color: Color(0xFF737784),
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Add Vendor',
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
                      mainAxisAlignment: MainAxisAlignment.center,

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
                      mainAxisAlignment: MainAxisAlignment.center,

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

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

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

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.thumb_up_off_alt_outlined,
                          color: Color(0xFF737784),
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Approve Request',
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
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.handshake,
                          color: Color(0xFF737784),
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Payment Settle',
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
                      mainAxisAlignment: MainAxisAlignment.center,

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
                  SizedBox(
                    width: 323,
                    height: 76  ,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 16.0),
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          'Paid to Monica',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '15th March, 2021',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        Column(

                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 10,),
                                            Icon(
                                              Icons.north_east,
                                              size: 20,
                                              color: Color(0xFF3574F2),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                              "-96.84 pts",
                                              style: TextStyle(
                                                color: Color(0xFF1D3A70),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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

  Future<void> logoutUser(BuildContext context) async {
    // Remove user data from shared preferences on logout
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');

    // Navigate back to LoginPage
    Navigator.pushReplacementNamed(context, '/');
  }
}
