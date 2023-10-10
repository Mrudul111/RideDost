import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:token/addvendor.dart';
import 'package:token/checkout.dart';
import 'package:token/createAccount.dart';
import 'package:token/dailyReport.dart';
import 'package:token/listing.dart';
import 'package:token/manageVendor.dart';
import 'package:token/profilePage.dart';
import 'package:token/request.dart';
import 'package:token/vendor.dart';
import 'package:token/vendorlist.dart';

import 'coupon.dart';
import 'dashboard.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'login.dart';
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> activeFilter = ValueNotifier<String>('New Vendor');
     FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? DashboardScreen() : homePage(),
      routes: {
        '/home': (context) => homePage(),
        '/dashboard': (context) => DashboardScreen(),
        '/login':(context) => loginPage(),
        '/vendor':(context) => VendorList(activeFilter: activeFilter,),
        '/addvendor':(context)=>AddVendor(),
        '/coupon':(context)=>Coupon(),
        '/request':(context)=> RequestPage(),
        '/dailyreport':(context)=> dailyReport(),
        '/createaccount':(context)=>newAccount(),
        '/profile':(context)=>profilePage(),
        '/listing':(context)=>listingPage(),
        '/checkout':(context)=>checkoutPage(),
        '/manageteam':(context)=>manageVendor()
      },
    );
  }
}

