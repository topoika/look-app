import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/agora/host.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:look/frontend/otherusersdetails.dart';
import 'package:look/base/pages/profile/showprofile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'liveusers.dart';

class VideoCalls extends StatefulWidget {
  var currentUserDetails;

  VideoCalls({Key? key, required this.currentUserDetails}) : super(key: key);

  @override
  _VideoCallsState createState() => _VideoCallsState();
}

class _VideoCallsState extends State<VideoCalls> {
  List countries = [
    "Argentina",
    "Australia",
    "Belgium",
    "Brazil",
    "Finland",
    "France",
    "Germany",
    "India",
    "North Korea",
    "Pakistan",
    "Turkey",
    "South Korea",
    "United Kingdom",
    "United States"
  ];

  bool spin = false;
  var name = [];
  var images = [];
  var country = [];
  var uids = [];
  String countryColors = 'All';

  @override
  void initState() {
    super.initState();
    setState(() {
      dbChangeListen();
    });
  }

  void dbChangeListen() {
    FirebaseFirestore.instance
        .collection('CurrentlyActiveUsers')
        .where('userid',
            isNotEqualTo: widget.currentUserDetails.data()['userid'])
        .snapshots()
        .listen((result) {
      result.docs.forEach((result) {
        setState(() {
          images.add(result.data()['image']);
          name.add(result.data()['name']);
          uids.add(result.data()['userid']);
          country.add(result.data()['country']);
        });
      });
    });
  }

  void getByCountry(String countryName) {
    setState(() {
      countryColors = countryName;
    });
    FirebaseFirestore.instance
        .collection('CurrentlyActiveUsers')
        .where('country', isEqualTo: countryName)
        .snapshots()
        .listen((result) {
      result.docs.forEach((result) {
        setState(() {
          images.add(result.data()['image']);
          name.add(result.data()['name']);
          uids.add(result.data()['userid']);
          country.add(result.data()['country']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const LiveUsers());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Live Streaming",
                        style:
                            TextStyle(color: Colors.black, fontFamily: 'PopM'),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: w * 0.2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: theme().mC,
                    ),
                    child: Text(
                      "  Video Call ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PopM',
                          fontSize: w * 0.033),
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    size: w * 0.1,
                    color: Colors.black,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: w * 0.55,
                    margin:
                        const EdgeInsets.only(left: 20, top: 15, bottom: 10),
                    child: TabBar(
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/grid.PNG',
                            ),
                            Text(
                              " Grid",
                              style: TextStyle(
                                  fontFamily: "PopB",
                                  fontSize: w * 0.045,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/list.PNG',
                            ),
                            Text(
                              "  List",
                              style: TextStyle(
                                  fontFamily: "PopB",
                                  fontSize: w * 0.045,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.24),
                    child: (spin == false)
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                name = [];
                                images = [];
                                country = [];
                                uids = [];
                                countryColors = "All";
                              });
                              refresh();
                            },
                            icon: Icon(
                              Icons.refresh_outlined,
                              size: w * 0.09,
                              color: Colors.black,
                            ))
                        : const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: Colors.black,
                            ),
                          ),
                  )
                ],
              ),
              SizedBox(
                width: w * 0.9,
                height: 28,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Text(
                            "All   ",
                            style: TextStyle(
                                fontFamily: "PopB",
                                fontSize: w * 0.05,
                                color: Colors.black),
                          )),
                      SizedBox(
                        width: w * 1,
                        height: 28,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5),
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: (countryColors == countries[index])
                                      ? Colors.transparent
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      name = [];
                                      images = [];
                                      country = [];
                                      uids = [];
                                    });
                                    getByCountry(countries[index]);
                                  },
                                  child: Text(
                                    '${countries[index]}',
                                    style: TextStyle(
                                        fontFamily: "PopB",
                                        fontSize: w * 0.034,
                                        color:
                                            (countryColors == countries[index])
                                                ? Colors.black
                                                : Colors.white),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              const Text("\n"),
              SizedBox(
                width: w * 0.9,
                height: h * 0.8,
                child: TabBarView(
                  children: [
                    gridView(w, h),
                    listView(w, h),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void refresh() {
    setState(() {
      spin = true;
    });
    Timer(
        const Duration(seconds: 2),
        () => setState(() {
              spin = false;
            }));
  }

  Widget gridView(double w, double h) {
    return Stack(
      children: [
        SizedBox(
          width: w * 1,
          height: h * 0.9,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(name.length, (index) {
              return InkWell(
                onTap: () {
                  Get.to(() => OtherUsersDetails(otherUserUid: uids[index]));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      left: 3, right: 5, top: 5, bottom: 5),
                  child: Stack(
                    children: [
                      SizedBox(
                          width: w * 0.8,
                          height: h * 0.8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ))),
                      Container(
                          margin: const EdgeInsets.only(left: 5, top: 8),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            country[index],
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'PopB'),
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            name[index],
                            style: TextStyle(
                                fontFamily: 'PopB',
                                fontSize: w * 0.05,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: h * 0.63),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme().mC, //                   <--- border color
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(
                        15.0) //                 <--- border radius here
                    ),
                color: theme().mC,
              ),
              child: InkWell(
                onTap: () {
                  connectionChecker();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.video_call,
                      size: w * 0.06,
                      color: Colors.white,
                    ),
                    Text(" Go Live",
                        style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'PopB')),
                  ],
                ),
              ),
            ),
            Container(
              width: w * 0.54,
              margin: EdgeInsets.only(left: 10, top: h * 0.63),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.black12,
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: theme().mC,
                      size: w * 0.075,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      "assets/terms.PNG",
                      scale: 1.8,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: theme().mC,
                      size: w * 0.075,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => MyProfile());
                    },
                    icon: Icon(
                      Icons.person,
                      color: theme().mC,
                      size: w * 0.075,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget listView(double w, double h) {
    return SizedBox(
      width: w * 0.98,
      height: h * 0.9,
      child: ListView.builder(
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(images[index]),
              ),
              subtitle: Text(
                country[index],
                style: TextStyle(
                    fontFamily: 'PopB',
                    fontSize: w * 0.03,
                    color: Colors.black),
              ),
              title: Text(
                name[index],
                style: TextStyle(
                    fontFamily: 'PopB',
                    fontSize: w * 0.05,
                    color: Colors.black),
              ),
              onTap: () {
                Get.to(() => OtherUsersDetails(otherUserUid: uids[index]));
              },
            );
          }),
    );
  }

  void connectionChecker() async {
    bool check = await DataConnectionChecker().hasConnection;
    print("CHeck value is " + '$check');
    if (check) {
      onJoin();
    } else {
      Dialogg().popUp(context, "No Connection",
          "Please check your internet connection and try again later!", 0);
    }
  }

  Future<void> onJoin() async {
    await [Permission.camera, Permission.microphone].request();
    if (widget.currentUserDetails.data()['name'] != null) {
      Get.to(() => Host(
            uid: widget.currentUserDetails.data()['userid'],
            isBroadcaster: true,
            channelName: widget.currentUserDetails.data()['name'],
          ));
    }
  }
}
