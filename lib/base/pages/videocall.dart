import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import '../Helper/strings.dart';
import '../../generated/l10n.dart';
import '../models/country_model.dart';
import 'liveusers.dart';

class VideoCalls extends StatefulWidget {
  const VideoCalls({Key? key}) : super(key: key);

  @override
  _VideoCallsState createState() => _VideoCallsState();
}

class _VideoCallsState extends State<VideoCalls> {
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
                      child: Text(
                        S.of(context).live_streaming,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: getHorizontal(context) * 0.2),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: theme().mC,
                    ),
                    child: Text(
                      S.of(context).video_call,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getHorizontal(context) * 0.033),
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    size: getHorizontal(context) * 0.1,
                    color: Colors.black,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: getHorizontal(context) * 0.55,
                    margin:
                        const EdgeInsets.only(left: 20, top: 15, bottom: 10),
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
                          child: Text(
                            "All   ",
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.05,
                                color: Colors.black),
                          )),
                      SizedBox(
                        width: getHorizontal(context) * 1,
                        height: 28,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countries.length,
                            itemBuilder: (BuildContext context, int index) {
                              var country = countries[index];
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5),
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    country.name ?? "",
                                    style: TextStyle(
                                        fontSize:
                                            getHorizontal(context) * 0.034,
                                        color: Colors.white),
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
                width: getHorizontal(context) * 0.9,
                height: getVertical(context) * 0.8,
                child: const TabBarView(
                  children: [
                    Center(
                      child: Text('Grid'),
                    ),
                    Center(
                      child: Text('List'),
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

  // Widget gridView() {
  //   return Stack(
  //     children: [
  //       SizedBox(
  //         width: getHorizontal(context) * 1,
  //         height: getVertical(context) * 0.9,
  //         child: GridView.count(
  //           crossAxisCount: 2,
  //           children: List.generate(name.length, (index) {
  //             return InkWell(
  //               onTap: () {
  //                 Get.to(() => OtherUsersDetails(otherUserUid: uids[index]));
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 margin: const EdgeInsets.only(
  //                     left: 3, right: 5, top: 5, bottom: 5),
  //                 child: Stack(
  //                   children: [
  //                     SizedBox(
  //                         width: getHorizontal(context) * 0.8,
  //                         height: getVertical(context) * 0.8,
  //                         child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(8),
  //                             child: Image.network(
  //                               images[index],
  //                               fit: BoxFit.cover,
  //                             ))),
  //                     Container(
  //                         margin: const EdgeInsets.only(left: 5, top: 8),
  //                         decoration: BoxDecoration(
  //                           color: Colors.amber,
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         child: Text(
  //                           country[index],
  //                           style: const TextStyle(
  //                               color: Colors.white, fontFamily: 'PopB'),
  //                         )),
  //                     Align(
  //                         alignment: Alignment.bottomLeft,
  //                         child: Text(
  //                           name[index],
  //                           style: TextStyle(
  //                               fontFamily: 'PopB',
  //                               fontSize: getHorizontal(context) * 0.05,
  //                               color: Colors.white),
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }),
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           Container(
  //             margin:
  //                 EdgeInsets.only(left: 10, top: getVertical(context) * 0.63),
  //             padding: const EdgeInsets.all(10),
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: theme().mC, //                   <--- border color
  //                 width: 1.0,
  //               ),
  //               borderRadius: const BorderRadius.all(Radius.circular(
  //                       15.0) //                 <--- border radius here
  //                   ),
  //               color: theme().mC,
  //             ),
  //             child: InkWell(
  //               onTap: () {
  //                 connectionChecker();
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.video_call,
  //                     size: getHorizontal(context) * 0.06,
  //                     color: Colors.white,
  //                   ),
  //                   Text(" Go Live",
  //                       style: TextStyle(
  //                           fontSize: getHorizontal(context) * 0.04,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.white,
  //                           fontFamily: 'PopB')),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: getHorizontal(context) * 0.54,
  //             margin:
  //                 EdgeInsets.only(left: 10, top: getVertical(context) * 0.63),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(40),
  //               border: Border.all(
  //                 color: Colors.black12,
  //               ),
  //               color: Colors.white,
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.search,
  //                     color: theme().mC,
  //                     size: getHorizontal(context) * 0.075,
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {},
  //                   child: Image.asset(
  //                     "assets/terms.PNG",
  //                     scale: 1.8,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.message,
  //                     color: theme().mC,
  //                     size: getHorizontal(context) * 0.075,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     Get.to(() => const MyProfile());
  //                   },
  //                   icon: Icon(
  //                     Icons.person,
  //                     color: theme().mC,
  //                     size: getHorizontal(context) * 0.075,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget listView() {
  //   return SizedBox(
  //     width: getHorizontal(context) * 0.98,
  //     height: getVertical(context) * 0.9,
  //     child: ListView.builder(
  //         itemCount: name.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return ListTile(
  //             leading: CircleAvatar(
  //               backgroundImage: NetworkImage(images[index]),
  //             ),
  //             subtitle: Text(
  //               country[index],
  //               style: TextStyle(
  //                   fontSize: getHorizontal(context) * 0.03,
  //                   color: Colors.black),
  //             ),
  //             title: Text(
  //               name[index],
  //               style: TextStyle(
  //                   fontFamily: 'PopB',
  //                   fontSize: getHorizontal(context) * 0.05,
  //                   color: Colors.black),
  //             ),
  //             onTap: () {
  //               Get.to(() => OtherUsersDetails(otherUserUid: uids[index]));
  //             },
  //           );
  //         }),
  //   );
  // }

  void connectionChecker() async {
    bool check = await DataConnectionChecker().hasConnection;
    if (check) {
    } else {
      const Dialogg().popUp(context, "No Connection",
          "Please check your internet connection and try again later!", 0);
    }
  }
}
