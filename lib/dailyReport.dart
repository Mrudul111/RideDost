import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'api/jsonAPI.dart';

class dailyReport extends StatefulWidget {
  const dailyReport({super.key});

  @override
  State<dailyReport> createState() => _dailyReportState();
}

class _dailyReportState extends State<dailyReport> {
  int currentPage = 1; // Start from page 1
  int totalPages = 1; // Start with 1 page initially
  List<Map<String, dynamic>> reports = [];
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    if (isLoading) {
      // Avoid making multiple requests simultaneously
      return;
    }

    try {
      setState(() {
        isLoading = true;
        isError = false;
      });

      final newReports = await fetchReports(currentPage);
      setState(() {
        reports.addAll(newReports);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true;
      });

      // Handle error as needed, e.g., display an error message
      print("Error loading reports: $error");
    }
  }

  Future<List<Map<String, dynamic>>> fetchReports(int page) async {
    try {
      String? token = tkn;
      final response = await getReports(page, token!);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['csv'] != null && responseData['csv'] is List) {
          final List<Map<String, dynamic>> fetchedReports =
              List.from(responseData['csv']);
          totalPages = responseData['totalPages'];
          print(responseData);
          return fetchedReports;
        }
      }

      throw Exception('Error fetching reports');
    } catch (error) {
      print("Error fetching reports: $error");
      throw error;
    }
  }

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
            color: Color(0xff1d3a70),
          ),
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
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: 351,
                    height: 357.31,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: totalPages,
                      onPageChanged: (int page) {
                        if (page + 1 == totalPages && !isLoading) {
                          // Load more data when reaching the last page
                          currentPage++;
                          loadReports();
                        }
                        print("current page $page");
                      },
                      itemBuilder: (context, pageIndex) {
                        return isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : isError
                                ? Center(
                                    child: Text("Error fetching data"),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: reports.length,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final report = reports[index];
                                      return Container(
                                        width: 300,
                                        height: 93,
                                        decoration: BoxDecoration(
                                          color: Color(0XFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'csv',
                                                    style: TextStyle(
                                                      color: Color(0xff1b2559),
                                                      fontFamily: 'DM Sans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    report['createdAt'],
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xffa3aed0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 100,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await FlutterDownloader.enqueue(
                                                      url: report['csvfileurl'],
                                                      savedDir:
                                                          '/storage/emulated/0/Download',
                                                      showNotification: true,
                                                      openFileFromNotification:
                                                          true,
                                                    saveInPublicStorage: true,
                                                  );
                                                  showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          width: 375,
                                                          height: 547,
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 60,
                                                                height: 6,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xffdfe2eb),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                width: 235,
                                                                height: 200,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/Frame 162397.png',
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                "Downloaded",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "DM Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        22,
                                                                    color: Color(
                                                                        0xff191d31)),
                                                              ),
                                                              Text(
                                                                'Congratulation! your package will be picked up by the \ncourier, please wait a moment.',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "DM Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        0xffa7a9b7)),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 327,
                                                                  height: 56,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              30),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xff3574f2),
                                                                          )),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Go Back",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "DM Sans",
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Color(0xff3574f2)),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Download",
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontFamily:
                                                            'SF Pro Display',
                                                        fontWeight:
                                                            FontWeight.w800,
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
                                  );
                      },
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
