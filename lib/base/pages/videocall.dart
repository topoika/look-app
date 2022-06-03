import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/models/user_model.dart';

import '../Helper/strings.dart';
import '../../generated/l10n.dart';
import '../models/country_model.dart';
import '../repositories/user_repository.dart';
import 'otherusersdetails.dart';
import 'utils/custom_containers.dart';
import 'utils/titles.dart';

class VideoCalls extends StatefulWidget {
  const VideoCalls({Key? key}) : super(key: key);

  @override
  _VideoCallsState createState() => _VideoCallsState();
}

class _VideoCallsState extends State<VideoCalls> {
  String activeCountry = "All";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              topBarItem(context, true),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getHorizontal(context) * 0.06,
                    vertical: getVertical(context) * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getHorizontal(context) * 0.55,
                      child: TabBar(
                        indicatorColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          tabBarItem(context, S.of(context).grid, grid),
                          tabBarItem(context, S.of(context).list, list),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: 28,
                        width: 28,
                        child: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 28,
                        )),
                  ],
                ),
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
                          margin: EdgeInsets.only(
                              right: getHorizontal(context) * 0.03),
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontal(context) * 0.02),
                          child: Text(
                            "All".toUpperCase(),
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.03,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getHorizontal(context),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: countries.length,
                          itemBuilder: (BuildContext context, int index) {
                            var country = countries[index];
                            return countryItemWidget(context, country, () {
                              setState(() {});
                            }, activeCountry);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: getHorizontal(context) * 0.9,
                height: getVertical(context) * 0.8,
                child: TabBarView(
                  children: [
                    gridView(),
                    Center(
                      child: Text(S.of(context).list),
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
          height: getVertical(context) * 0.95,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where(
                  "uid",
                  isNotEqualTo: currentUser.value.uid,
                )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var _user = User.fromMap(snapshot.data!.docs[index].data()
                        as Map<String, dynamic>);
                    return InkWell(
                      onTap: () => Get.to(() => OtherUsersDetails(user: _user)),
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
                              height: getVertical(context) * 0.9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  _user.image ?? noImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, top: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                _user.country!.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: getHorizontal(context) * 0.03,
                                    color: Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 5, top: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 3),
                                    Icon(
                                      Icons.brightness_1_rounded,
                                      color: index == 3
                                          ? Colors.amber
                                          : index == 5
                                              ? Colors.black
                                              : Colors.green,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 5),
                                child: channelName(_user.name),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 5, bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 1, 6, 36),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      "👏  0",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          widthFactor: getHorizontal(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [bottomNavigation(context)],
          ),
        )
      ],
    );
  }

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

  // void d() async {
  //   bool check = await DataConnectionChecker().hasConnection;
  //   if (check) {
  //   } else {
  //     const Dialogg().popUp(context, "No Connection",
  //         "Please check your internet connection and try again later!", 0);
  //   }
  // }
}
