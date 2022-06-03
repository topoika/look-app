import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/custom_containers.dart';

import '../../generated/l10n.dart';
import '../Helper/strings.dart';
import '../models/country_model.dart';
import '../models/user_model.dart' as userModel;
import 'liveclass.dart';
import 'utils/titles.dart';

class LiveUsers extends StatefulWidget {
  const LiveUsers({Key? key}) : super(key: key);

  @override
  _LiveUsersState createState() => _LiveUsersState();
}

class _LiveUsersState extends State<LiveUsers> {
  bool recharge = false;
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
              topBarItem(context, false),
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
                        onTap: () {
                          setState(() {
                            activeCountry = "All";
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: getHorizontal(context) * 0.03),
                          padding: EdgeInsets.symmetric(
                              horizontal: getHorizontal(context) * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: activeCountry == "All"
                                ? Colors.red
                                : Theme.of(context).accentColor,
                          ),
                          child: Text(
                            S.of(context).all.toUpperCase(),
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.05,
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
                              setState(() {
                                activeCountry = country.name!;
                              });
                            }, activeCountry);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
            stream: activeCountry == "All"
                ? FirebaseFirestore.instance
                    .collection("Users")
                    .where(
                      "uid",
                      isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("Users")
                    .where(
                      "uid",
                      isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .where("country", isEqualTo: activeCountry)
                    .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: noDataFoundContainer(context),
                    )
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _user = userModel.User.fromMap(
                            snapshot.data!.docs[index].data());
                        return InkWell(
                          onTap: () => Get.to(() => const LiveClass()),
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
                                  margin:
                                      const EdgeInsets.only(left: 5, top: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    (_user.country ?? " ").toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 5),
                                    child: channelName("Alan Walker Mix"),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 5, bottom: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 1, 6, 36),
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
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: rewardsWidget(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: goLiveButton(context, connectionChecker),
              ),
              bottomNavigation(context)
            ],
          ),
        )
      ],
    );
  }

  // Widget listView() {
  //   return SizedBox(
  //     width: getHorizontal(context) * 0.98,
  //     height: getVertical(context) * 0.9,
  //     child: StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection("Users")
  //           .where(
  //             "uid",
  //             isNotEqualTo: currentUser.value.uid,
  //           )
  //           .snapshots(),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<cf.QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return const Center(
  //             child: Text(
  //               "No data found",
  //               style: TextStyle(color: Colors.red),
  //             ),
  //           );
  //         }
  //         return ListView(
  //           children: snapshot.data!.docs.map((document) {
  //             return ListView.builder(
  //                 itemCount: snapshot.data!.docs.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   var _user = User.fromMap(snapshot.data!.docs[index].data()
  //                       as Map<String, dynamic>);
  //                   return ListTile(
  //                     leading: CircleAvatar(
  //                       backgroundImage: NetworkImage(
  //                         _user.image ?? noImage,
  //                       ),
  //                     ),
  //                     subtitle: Text(
  //                       _user.country!.toUpperCase(),
  //                       style: TextStyle(
  //                           fontSize: getHorizontal(context) * 0.03,
  //                           color: Colors.black),
  //                     ),
  //                     title: Text(
  //                       _user.name ?? "",
  //                       style: TextStyle(
  //                           fontSize: getHorizontal(context) * 0.05,
  //                           color: Colors.black),
  //                     ),
  //                     trailing: SizedBox(
  //                       width: getHorizontal(context) * 0.13,
  //                       child: Row(
  //                         children: const [
  //                           Text(
  //                             "0",
  //                             style: TextStyle(color: Colors.black),
  //                           ),
  //                           Icon(
  //                             Icons.remove_red_eye,
  //                             color: Colors.black,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     onTap: () {},
  //                   );
  //                 });
  //           }).toList(),
  //         );
  //       },
  //     ),
  //   );
  // }

  void connectionChecker() async {
    // bool check = await DataConnectionChecker().hasConnection;
    // log("CHeck value is " '$check');
    // if (check) {
    //   // Scaffold.of(context).showBottomSheet(
    //   //   (context) => Builder(
    //   //     builder: (BuildContext context) {
    //   //       return BottomSheet(
    //   //           builder: (BuildContext context) {
    //   //             return Container(
    //   //               height: 500,
    //   //               color: Colors.black,
    //   //               child: Text("Please enter the title of your live stream"),
    //   //             );
    //   //           });
    //   //     },
    //   //   ),
    //   // );
    // } else {
    //   const Dialogg().popUp(context, "No Connection",
    //       "Please check your internet connection and try again later!", 0);
    // }
  }
}
