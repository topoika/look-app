import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/agora/join.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/videocall.dart';

import '../../generated/l10n.dart';
import '../Helper/strings.dart';
import '../models/country_model.dart';
import 'utils/titles.dart';

class LiveUsers extends StatefulWidget {
  const LiveUsers({Key? key}) : super(key: key);

  @override
  _LiveUsersState createState() => _LiveUsersState();
}

class _LiveUsersState extends State<LiveUsers> {
  bool recharge = false;
  String countryColors = 'All';

  @override
  Widget build(BuildContext context) {
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
                          fontSize: getHorizontal(context) * 0.033),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const VideoCalls());
                    },
                    child: Container(
                      margin:
                          EdgeInsets.only(left: getHorizontal(context) * 0.027),
                      padding: EdgeInsets.all(getHorizontal(context) * 0.027),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Video Call",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getHorizontal(context) * 0.033),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getHorizontal(context) * 0.2),
                    child: Icon(
                      Icons.notifications,
                      size: getHorizontal(context) * 0.08,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: getHorizontal(context) * 0.55,
                    margin: EdgeInsets.only(
                        left: getHorizontal(context) * 0.03,
                        top: 15,
                        bottom: 10),
                    child: TabBar(
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Row(
                          children: [
                            Image.asset(
                              grid,
                            ),
                            Text(
                              S.of(context).grid,
                              style: TextStyle(
                                  fontSize: getHorizontal(context) * 0.045,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              list,
                            ),
                            Text(
                              S.of(context).list,
                              style: TextStyle(
                                  fontSize: getHorizontal(context) * 0.045,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getHorizontal(context) * 0.24),
                    child: const SizedBox(
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
                width: getHorizontal(context) * 0.9,
                height: 28,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                " All  ",
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.05,
                                    color: Colors.black),
                              ))),
                      SizedBox(
                        width: getHorizontal(context) * 1,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countries.length,
                            itemBuilder: (BuildContext context, int index) {
                              var country = countries[index];
                              return countryItemWidget(context, country);
                            }),
                      )
                    ],
                  ),
                ),
              ),
              const Text("\n"),
              SizedBox(
                width: getHorizontal(context) * 0.9,
                height: getVertical(context) * 0.8,
                child: TabBarView(
                  children: [
                    gridView(),
                    const Center(
                      child: Text("List"),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget gridView() {
    return Stack(
      children: [
        SizedBox(
          width: getHorizontal(context) * 1,
          height: getVertical(context) * 0.9,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(8, (index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      left: 3, right: 5, top: 5, bottom: 5),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: getHorizontal(context) * 0.8,
                        height: getVertical(context) * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            currentUser.value.image ?? noImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 5, top: 8),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            currentUser.value.country ?? "",
                            style: const TextStyle(color: Colors.white),
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: getHorizontal(context) * 0.17,
                          margin: const EdgeInsets.only(right: 5, top: 8),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "438",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              Text("  "),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: channelName("Text Channel"),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: getVertical(context) * 0.48,
              left: getHorizontal(context) * 0.66),
          width: getHorizontal(context) * 0.22,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/box.png",
              fit: BoxFit.cover,
              scale: 10,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin:
                  EdgeInsets.only(left: 10, top: getVertical(context) * 0.63),
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
                      size: getHorizontal(context) * 0.06,
                      color: Colors.white,
                    ),
                    Text(" Go Live",
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'PopB')),
                  ],
                ),
              ),
            ),
            Container(
              width: getHorizontal(context) * 0.5,
              margin:
                  EdgeInsets.only(left: 10, top: getVertical(context) * 0.63),
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
                    onPressed: () {
                      // Get.to(() => Search(
                      //       uid: result.data()['userid'],
                      //       user: result.data()['name'],
                      //     ));
                    },
                    icon: Icon(
                      Icons.search,
                      color: theme().mC,
                      size: getHorizontal(context) * 0.075,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      terms,
                      scale: 1.8,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // if (result.data()['name'] != null) {
                      //   Get.to(() => ChatRooms(
                      //         myUid: result.data()['userid'],
                      //         myName: result.data()['name'],
                      //       ));
                      // }
                    },
                    icon: Icon(
                      Icons.message,
                      color: theme().mC,
                      size: getHorizontal(context) * 0.075,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(
                      Icons.person,
                      color: theme().mC,
                      size: getHorizontal(context) * 0.075,
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

  // Widget listView() {
  //   return SizedBox(
  //     width: getHorizontal(context) * 0.98,
  //     height: getVertical(context) * 0.9,
  //     child: ListView.builder(
  //         itemCount: channelName.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return ListTile(
  //             leading: CircleAvatar(
  //               backgroundImage: NetworkImage(images[index]),
  //             ),
  //             subtitle: Text(
  //               country[index],
  //               style: TextStyle(
  //                   fontFamily: 'PopB',
  //                   fontSize: getHorizontal(context) * 0.03,
  //                   color: Colors.black),
  //             ),
  //             title: Text(
  //               channelName[index],
  //               style: TextStyle(
  //                   fontFamily: 'PopB',
  //                   fontSize: getHorizontal(context) * 0.05,
  //                   color: Colors.black),
  //             ),
  //             trailing: SizedBox(
  //               width: getHorizontal(context) * 0.13,
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     '${view[index]}',
  //                     style: const TextStyle(
  //                         fontFamily: 'PopB', color: Colors.black),
  //                   ),
  //                   const Icon(
  //                     Icons.remove_red_eye,
  //                     color: Colors.black,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             onTap: () {
  //               join(channelName[index]);
  //             },
  //           );
  //         }),
  //   );
  // }

  void connectionChecker() async {
    bool check = await DataConnectionChecker().hasConnection;
    log("CHeck value is " '$check');
    if (check) {
    } else {
      const Dialogg().popUp(context, "No Connection",
          "Please check your internet connection and try again later!", 0);
    }
  }
}
