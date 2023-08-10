import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'addvendor.dart';


bool showPage = true;
int selectedContainer = 1;
ValueNotifier<String> activeFilter = ValueNotifier<String>('New Vendor');

class VendorList extends StatefulWidget {
  const VendorList({Key? key}) : super(key: key);

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  GlobalKey _listKey = GlobalKey();
  GlobalKey _otherListKey = GlobalKey();
  bool is1Active = false;
  bool is2Active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff1d3a70),
        ),
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        title: Text(
          "New Vendor",
          style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xff1d3a70)),
        ),
      ),
      body:  SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            is1Active = true;
                            is2Active = false;
                          });
                        },
                        child: Container(
                          height: 31,
                          width: 48,
                          decoration: BoxDecoration(
                            color: is1Active ? Color(0xff2c2c2c) : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              "All",
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
                          });
                        },
                        child: Container(
                          height: 31,
                          width: 97,
                          decoration: BoxDecoration(
                              color:
                                  is2Active ? Color(0xff2c2c2c) : Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              "New Vendor",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is2Active? Colors.white: Color(0xff828282)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(Icons.filter_list_alt),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return filterPopUp(activeFilter: activeFilter,);
                          });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ValueListenableBuilder<String>(
                valueListenable: activeFilter,
                builder: (context,filter,child) {
                  if(filter=="New Vendor"){
                    return SizedBox(
                      height: 348,
                      width: 375,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) => SizedBox(height: 16.0),
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Vendor Name",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "view all",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff008ce4),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.check),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.cancel_rounded)
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
                  }
                  else if(filter=="Approved Vendor"){
                    return SizedBox(
                      height: 348,
                      width: 375,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) => SizedBox(height: 16.0),
                        shrinkWrap: true,
                        itemCount: 4,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return VendorListItem();
                        },
                      ),
                    );
                  }
                  else{
                    return Container();
                  }
                }
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return floatingButtonPopUp();
                          });
                    },
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Color(0xff111322),
                  ))
            ],
          ),
        ),
      )
    );
  }
}

class VendorListItem extends StatefulWidget {
  const VendorListItem({Key? key}) : super(key: key);

  @override
  State<VendorListItem> createState() => _VendorListItemState();
}

class _VendorListItemState extends State<VendorListItem> {
  bool toggleValue = true;
  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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

  }
}

class filterPopUp extends StatefulWidget {
  final ValueNotifier<String> activeFilter;

  const filterPopUp({Key? key, required this.activeFilter}) : super(key: key);

  @override
  State<filterPopUp> createState() => _filterPopUpState();
}

class _filterPopUpState extends State<filterPopUp> {
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  void initState() {
    super.initState();
    // Set the initial filter value based on the activeFilter
    if (widget.activeFilter.value == "New Vendor") {
      setState(() {
        isClicked1 = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: 875,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked1 = true;
                        isClicked2 = false;
                        isClicked3 = false;
                      });
                    },
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked1
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked1
                            ? Icon(Icons.check,
                                color: Color(0xff3574f2), size: 10)
                            : Icon(null)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "New Vendor",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "DM Sans"),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked2 = true;
                        isClicked1 = false;
                        isClicked3 = false;
                      });
                    },
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked2
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked2
                            ? Icon(Icons.check,
                                color: Color(0xff3574f2), size: 10)
                            : Icon(null)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Approved Vendor",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "DM Sans"),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked3 = true;
                        isClicked2 = false;
                        isClicked1 = false;
                      });
                    },
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: isClicked3
                                    ? Color(0xff3574f2)
                                    : Color(0xff524b6b))),
                        child: isClicked3
                            ? Icon(
                                Icons.check,
                                color: Color(0xff3574f2),
                                size: 10,
                              )
                            : Icon(null)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Pending",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "DM Sans"),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                width: 335,
                color: Color(0xffdee1e7),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked1 = false;
                        isClicked2 = false;
                        isClicked3 = false;
                      });
                    },
                    child: Container(
                      width: 75,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff3c3c3c)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        if (isClicked1) {
                          widget.activeFilter.value = "New Vendor";
                        } else if (isClicked2 ) {
                          widget.activeFilter.value = "Approved Vendor";
                        } else if (isClicked3) {
                          widget.activeFilter.value = "Pending";
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff3574F2),
                      ),
                      child: Center(
                        child: Text(
                          "APPLY NOW",
                          style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3c3c3c)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class floatingButtonPopUp extends StatefulWidget {
  const floatingButtonPopUp({Key? key}) : super(key: key);

  @override
  State<floatingButtonPopUp> createState() => _floatingButtonPopUpState();
}

class _floatingButtonPopUpState extends State<floatingButtonPopUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xffeff7ff)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 15)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddVendor()));
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
                        'Add Vendor',
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
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xffeff7ff)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 15)),
                  ),
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
