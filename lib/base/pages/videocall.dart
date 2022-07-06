import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/controllers/videocalls_controller.dart';
import 'package:look/base/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Helper/helper.dart';
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

class _VideoCallsState extends StateMVC<VideoCalls> {
  String activeCountry = "All";
  late VideoCallsController _con;
  _VideoCallsState() : super(VideoCallsController()) {
    _con = controller as VideoCallsController;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _con.globalKey,
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
                        padding: EdgeInsets.all(0),
                        indicatorPadding: EdgeInsets.only(
                            left: getHorizontal(context) * 0.13,
                            right: getHorizontal(context) * 0.03),
                        tabs: [
                          tabBarItem(context, S.of(context).grid, grid),
                          tabBarItem(context, S.of(context).list, list),
                        ],
                      ),
                    ),
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
                              horizontal: getHorizontal(context) * 0.02,
                              vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: activeCountry == "All"
                                ? Colors.red
                                : Theme.of(context).accentColor,
                          ),
                          child: Text(
                            S.of(context).all.toUpperCase(),
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.034,
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
                              setState(() => activeCountry = country.name!);
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
                    listView(),
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
                      isNotEqualTo: currentUser.value.uid,
                    )
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("Users")
                    .where(
                      "uid",
                      isNotEqualTo: currentUser.value.uid,
                    )
                    .where("country", isEqualTo: activeCountry)
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      padding:
                          EdgeInsets.only(bottom: getVertical(context) * 0.09),
                      itemBuilder: (BuildContext context, int index) {
                        var _user = User.fromMap(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>);
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtherUsersDetails(user: _user, random: false),
                            ),
                          ),
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
                                      _user.images!.length > 0
                                          ? _user.images![0]
                                          : noImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, top: 8),
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
                                    margin:
                                        const EdgeInsets.only(right: 5, top: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 5),
                                        const SizedBox(width: 3),
                                        Icon(
                                          Icons.brightness_1_rounded,
                                          color: _user.active == "active"
                                              ? Colors.green
                                              : _user.active == "domant"
                                                  ? Colors.yellow
                                                  : Colors.grey.withOpacity(.8),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black26,
                                            Colors.black54,
                                            Colors.black,
                                            Colors.black,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )),
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 3, top: 15),
                                    child: channelName(_user.name ?? ""),
                                  ),
                                )
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
            children: [bottomNavigation(context, "home")],
          ),
        )
      ],
    );
  }

  Widget listView() {
    return SizedBox(
      width: getHorizontal(context) * 0.98,
      height: getVertical(context) * 0.9,
      child: StreamBuilder(
          stream: activeCountry == "All"
              ? FirebaseFirestore.instance
                  .collection("Users")
                  .where(
                    "uid",
                    isNotEqualTo: currentUser.value.uid,
                  )
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("Users")
                  .where(
                    "uid",
                    isNotEqualTo: currentUser.value.uid,
                  )
                  .where("country", isEqualTo: activeCountry)
                  .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: noDataFoundContainer(context),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var _user = User.fromMap(snapshot.data!.docs[index].data()
                          as Map<String, dynamic>);
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtherUsersDetails(user: _user, random: false),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: getHorizontal(context),
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: double.infinity,
                                width: getHorizontal(context) * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      _user.images!.length > 0
                                          ? _user.images![0]
                                          : noImage,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: getHorizontal(context) * 0.02),
                              SizedBox(
                                width: getHorizontal(context) * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "${_user.name ?? ""} ${_user.age.toString()} ${_user.location!.split(" ")[0].replaceAll(",", "")}, ${_user.country}",
                                      maxLines: 1,
                                      style: mainStyle(Colors.black, 0.032),
                                    ),
                                    Text(
                                      _user.describe ?? "",
                                      maxLines: 1,
                                      style: mainStyle(Colors.black45, 0.026),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    getTimeDifference(_user.dob!)!,
                                    style: mainStyle(Colors.black45, 0.029),
                                  ),
                                  Text(
                                    "5Km",
                                    style: mainStyle(Colors.redAccent, 0.029),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  TextStyle mainStyle(Color color, double size) {
    return TextStyle(
      fontSize: getHorizontal(context) * size,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }
}
