import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/pages/utils/add_title_bottom_sheet.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../Helper/strings.dart';
import '../models/country_model.dart';
import '../models/live_stream_model.dart';
import 'liveclass.dart';
import 'utils/titles.dart';

class LiveUsers extends StatefulWidget {
  const LiveUsers({Key? key}) : super(key: key);

  @override
  _LiveUsersState createState() => _LiveUsersState();
}

class _LiveUsersState extends StateMVC<LiveUsers> {
  late LiveStreamController _con;

  _LiveUsersState() : super(LiveStreamController()) {
    _con = controller as LiveStreamController;
  }
  bool recharge = false;
  String activeCountry = "All";

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _con.globalKey,
          resizeToAvoidBottomInset: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: getHorizontal(context) * 0.5,
                        child: TabBar(
                          padding: EdgeInsets.all(0),
                          indicatorColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
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
                const SizedBox(height: 5),
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
                    .collection("liveStreams")
                    .where(
                      'hostId',
                      isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("liveStreams")
                    .where(
                      'hostId',
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
                        var liveStream = LiveStream.fromMap(
                            snapshot.data!.docs[index].data());
                        var _user = liveStream.host;
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveClass(
                                isHost: false,
                                isInvited: false,
                                liveStream: liveStream,
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                                      _user!.images!.length > 0
                                          ? _user.images![0]
                                          : noImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Text(
                                              (_user.country ?? " ")
                                                  .toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      getHorizontal(context) *
                                                          0.03,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                              SizedBox(width: 3),
                                              Text(
                                                liveStream.viewers.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: double.infinity,
                                    height: getVertical(context) * 0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black54,
                                          Colors.black87,
                                          Colors.black,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, bottom: 5, right: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: channelName(
                                                liveStream.title ?? "")),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            "👏  ${liveStream.reactions.toString()}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child:
                                // ),
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
              bottomNavigation(context, "home")
            ],
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
                  .collection("liveStreams")
                  .where(
                    'hostId',
                    isNotEqualTo: FirebaseAuth.instance.currentUser!.uid,
                  )
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("liveStreams")
                  .where(
                    'hostId',
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
                : ListView.builder(
                    itemCount: snapshot
                        .data!.docs.length, // snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var liveStream =
                          LiveStream.fromMap(snapshot.data!.docs[index].data());
                      var _user = liveStream.host;
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LiveClass(
                              isHost: false,
                              isInvited: false,
                              liveStream: liveStream,
                            ),
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
                                      _user!.images!.length > 0
                                          ? _user.images![0]
                                          : noImage,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: getHorizontal(context) * 0.03),
                              SizedBox(
                                width: getHorizontal(context) * 0.62,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "${liveStream.title ?? ""} ${_user.age.toString()} ${_user.location}",
                                      maxLines: 1,
                                      style: mainStyle(Colors.black, 0.031),
                                    ),
                                    Text(
                                      "Hi? I am free today, I want to meet a good guy!!",
                                      maxLines: 1,
                                      style: mainStyle(Colors.black45, 0.028),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "1hr",
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

  void connectionChecker() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context) {
          return AddTitleBottomSheet(scaffoldKey: _con.globalKey);
        });
    // _con.createLiveStream(context);
  }
}
