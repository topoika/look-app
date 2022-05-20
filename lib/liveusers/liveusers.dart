import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/agora/host.dart';
import 'package:look/agora/join.dart';
import 'package:look/agora/randomcalling.dart';
import 'package:look/chatting/chatrooms.dart';
import 'package:look/chatting/search.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/frontend/awards.dart';
import 'package:look/liveusers/videocall.dart';
import 'package:look/profile/showprofile.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveUsers extends StatefulWidget {
  const LiveUsers({Key? key}) : super(key: key);

  @override
  _LiveUsersState createState() => _LiveUsersState();
}

class _LiveUsersState extends State<LiveUsers> {
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
  String uiD = FirebaseAuth.instance.currentUser!.uid;
  var channelName = [];
  var images = [];
  var country = [];
  var view = [];
  bool got = false;
  var result;
  bool recharge = false;
  late var awardResult;
  String countryColors = 'All';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getChannels();
  }

  Future<void> getChannels() async {
    currentUserProfile();
    try {
      FirebaseFirestore.instance.collection("channels").get().then(
        (value) {
          for (var result in value.docs) {
            if (result.data()['channelname'] != null &&
                result.data()['image'] != null &&
                result.data()['country'] != null &&
                result.data()['viewers'] != null) {
              String str = result.data()['country'];

              setState(() {
                channelName.add(result.data()['channelname']);
                images.add(result.data()['image']);
                if (str.length >= 12) {
                  str = str.substring(0, str.length - 3);
                }

                country.add(str);
                view.add(result.data()['viewers']);
              });
            }
          }
        },
      );
      setState(() {
        got = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getChannel(String txt) async {
    setState(() {
      countryColors = txt;
    });
    try {
      FirebaseFirestore.instance
          .collection("channels")
          .where('country', isEqualTo: txt)
          .get()
          .then(
        (value) {
          for (var result in value.docs) {
            if (result.data()['channelname'] != null &&
                result.data()['image'] != null &&
                result.data()['country'] != null &&
                result.data()['viewers'] != null) {
              String str = result.data()['country'];

              setState(() {
                channelName.add(result.data()['channelname']);
                images.add(result.data()['image']);
                if (str.length >= 12) {
                  str = str.substring(0, str.length - 3);
                }

                country.add(str);
                view.add(result.data()['viewers']);
              });
            }
          }
        },
      );
      setState(() {
        got = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> currentUserProfile() async {
    result =
        await FirebaseFirestore.instance.collection("Users").doc(uiD).get();
    try {
      awardResult =
          await FirebaseFirestore.instance.collection("award").doc(uiD).get();
      setState(() {
        recharge = true;
      });
    } catch (e) {
      print("E.tpstring");
      print(e.toString());
    }
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
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: theme().mC,
                    ),
                    child: Text(
                      "Live Streaming",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PopM',
                          fontSize: w * 0.033),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => VideoCalls(
                            currentUserDetails: result,
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: w * 0.027),
                      padding: EdgeInsets.all(w * 0.027),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Video Call",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PopM',
                            fontSize: w * 0.033),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.2),
                    child: Icon(
                      Icons.notifications,
                      size: w * 0.08,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: w * 0.55,
                    margin:
                        EdgeInsets.only(left: w * 0.03, top: 15, bottom: 10),
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
                              "Grid",
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
                              "List",
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
                                channelName = [];
                                images = [];
                                country = [];
                                view = [];
                              });
                              getChannels();
                            },
                            icon: Icon(
                              Icons.refresh_outlined,
                              size: w * 0.1,
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
                          onTap: () {
                            setState(() {
                              channelName = [];
                              images = [];
                              country = [];
                              view = [];
                              countryColors = "All";
                            });
                            getChannels();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: (countryColors == "All")
                                    ? Colors.transparent
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                " All  ",
                                style: TextStyle(
                                    fontFamily: "PopB",
                                    fontSize: w * 0.05,
                                    color: Colors.black),
                              ))),
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
                                      channelName = [];
                                      images = [];
                                      country = [];
                                      view = [];
                                    });
                                    getChannel(countries[index]);
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
                    (got == true)
                        ? gridView(w, h)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
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
            children: List.generate(channelName.length, (index) {
              return InkWell(
                onTap: () {
                  join(channelName[index]);
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
                        alignment: Alignment.topRight,
                        child: Container(
                          width: w * 0.17,
                          margin: const EdgeInsets.only(right: 5, top: 8),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${view[index]}',
                                style: const TextStyle(
                                    fontFamily: 'PopB', color: Colors.white),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              const Text("  "),
                            ],
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            channelName[index],
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
        Container(
          margin: EdgeInsets.only(top: h * 0.48, left: w * 0.66),
          width: w * 0.22,
          child: InkWell(
            onTap: () async {
              if (awardResult.data() != null) {
                int val = awardResult.data()['awardNumber'];
                if (val == 0) {
                  if (awardResult.data()['time'] != '') {
                    Get.to(() => Award(
                          coins: result.data()['points'],
                          awardNo: awardResult.data()!['awardNumber'],
                          uid: uiD,
                          t1: awardResult.data()['time'],
                          checkDate: true,
                        ));
                  }
                } else {
                  try {
                    await FirebaseFirestore.instance
                        .collection('use')
                        .doc(uiD)
                        .update({
                      'time': FieldValue.serverTimestamp(),
                    });
                    Get.to(() => Award(
                          coins: result.data()['points'],
                          awardNo: awardResult.data()!['awardNumber'],
                          uid: uiD,
                          t1: awardResult.data()['time'],
                          checkDate: true,
                        ));
                  } catch (e) {
                    print("Error");
                    print(e.toString());
                  }
                }
              }
            },
            child: Image.asset(
              "assets/box.png",
              fit: BoxFit.cover,
              scale: 10,
            ),
          ),
        ),
        Row(
          children: [
            // Container(
            //   margin:  EdgeInsets.only(left: 10,top: h*0.63),
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color:theme().mC, //                   <--- border color
            //       width: 1.0,
            //     ),
            //     borderRadius: const BorderRadius.all(
            //         Radius.circular(15.0) //                 <--- border radius here
            //     ),
            //     color: theme().mC,
            //   ),
            //   child:InkWell(
            //     onTap: ()
            //     {
            //       connectionChecker();
            //     },
            //     child: Row(
            //       children: [
            //         Icon(
            //           Icons.video_call,
            //           size: w*0.06,
            //           color: Colors.white,
            //         ),
            //         Text(" Go Live", style: TextStyle(fontSize: w* 0.04,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white,
            //             fontFamily: 'PopB')),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              width: w * 0.8,
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
                    onPressed: () async {
                      Get.to(() => Search(
                            uid: result.data()['userid'],
                            user: result.data()['name'],
                          ));
                    },
                    icon: Icon(
                      Icons.search,
                      color: theme().mC,
                      size: w * 0.075,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection("randomcalling")
                            .doc(uiD)
                            .set({
                          'name': result.data()['name'],
                          'userid': uiD,
                        });
                        RANDOMCALL = true;
                        Get.to(() => RandomCalling(
                              currentUserName: result.data()['name'],
                              currentUserImage: result.data()['image'],
                              currentUserUid: uiD,
                            ));
                      } catch (e) {
                        const Dialogg().popUp(
                            context,
                            'Unable to Search for Users',
                            'Check your internet connection and try again later',
                            1);
                      }
                    },
                    child: Image.asset(
                      "assets/terms.PNG",
                      scale: 1.8,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (result.data()['name'] != null) {
                        Get.to(() => ChatRooms(
                              myUid: result.data()['userid'],
                              myName: result.data()['name'],
                            ));
                      }
                    },
                    icon: Icon(
                      Icons.message,
                      color: theme().mC,
                      size: w * 0.075,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
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
          itemCount: channelName.length,
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
                channelName[index],
                style: TextStyle(
                    fontFamily: 'PopB',
                    fontSize: w * 0.05,
                    color: Colors.black),
              ),
              trailing: SizedBox(
                width: w * 0.13,
                child: Row(
                  children: [
                    Text(
                      '${view[index]}',
                      style: const TextStyle(
                          fontFamily: 'PopB', color: Colors.black),
                    ),
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              onTap: () {
                join(channelName[index]);
              },
            );
          }),
    );
  }

  void connectionChecker() async {
    bool check = await DataConnectionChecker().hasConnection;
    log("CHeck value is " + '$check');
    if (check) {
      onJoin();
    } else {
      const Dialogg().popUp(context, "No Connection",
          "Please check your internet connection and try again later!", 0);
    }
  }

  Future<void> onJoin() async {
    await [Permission.camera, Permission.microphone].request();
    if (result.data()['name'] != null) {
      log(result.data()['name']);
      Get.to(() => Host(
            uid: uiD,
            isBroadcaster: true,
            channelName: result.data()['name'],
          ));
    }
  }

  Future<void> join(String channel) async {
    var result =
        await FirebaseFirestore.instance.collection("Users").doc(uiD).get();
    if (result.data()!['name'] != null) {
      Get.to(() => Join(
          channelName: channel,
          myName: result.data()!['name'],
          myImage: result.data()!['image']));
    }
  }
}
