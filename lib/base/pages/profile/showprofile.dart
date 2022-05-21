import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/frontend/recharge.dart';
import './../../models/user_model.dart' as userModel;

import '../../../generated/l10n.dart';
import '../../Helper/strings.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final userModel.User _user = currentUser.value;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: getHorizontal(context) * 1,
              height: getVertical(context) * 0.5,
              child: Image.network(
                _user.image ?? noImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.red,
                    size: 20,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: getHorizontal(context) * 0.4),
              child: Text(S.of(context).my_info,
                  style: TextStyle(
                      fontSize: getHorizontal(context) * 0.065,
                      color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              color: Colors.white,
              height: getVertical(context) * 0.9,
              width: getHorizontal(context) * 1,
              margin: EdgeInsets.only(
                  top: getVertical(context) * 0.2,
                  bottom: getVertical(context) * 0.1),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(''),
                        Text(
                          _user.name ?? "",
                          style: TextStyle(
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            //TODO
                            // Get.to(() => EditProfile(
                            //       location: widget.myProfile.data()['location'],
                            //       name: widget.myProfile.data()['name'],
                            //       image: widget.myProfile.data()['image'],
                            //       country: widget.myProfile.data()['country'],
                            //       myuid: widget.myProfile.data()['userid'],
                            //     ));
                          },
                          child: Image.asset(
                            edit,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _user.country ?? "",
                      style: TextStyle(
                          fontSize: getHorizontal(context) * 0.052,
                          color: Colors.black),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Image.asset(
                              daimond,
                              scale: 1,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                _user.points.toString(),
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.055,
                                    color: Colors.white),
                              ),
                              Text(
                                S.of(context).points,
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.055,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => Recharge(
                                    points: int.parse(_user.points.toString()),
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Text(
                                S.of(context).recharge,
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.05,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {},
                        child: cont(callhistory, S.of(context).call_history)),
                    InkWell(
                      onTap: () {},
                      child: cont(publicnotice, S.of(context).public_notice),
                    ),
                    InkWell(
                      onTap: () {},
                      child: cont(inquiry, "1:1 " + S.of(context).inquiry),
                    ),
                    InkWell(
                      onTap: () {},
                      child: cont(invitee, S.of(context).my_invitee),
                    ),
                    InkWell(
                        onTap: () {
                          // Get.to(() => Recharge(
                          //       points: widget.myProfile.data()['points'],
                          //     ));
                        },
                        child: cont(coinstore, S.of(context).coin_store)),
                    InkWell(
                      onTap: () {},
                      child: cont(terms, S.of(context).terms_of_use),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: InkWell(
                          onTap: () => logOut(context),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: getHorizontal(context) * 0.12,
                              ),
                              Text(
                                S.of(context).log_out,
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.055,
                                    color: Colors.black),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: getHorizontal(context) * 0.8,
                margin:
                    EdgeInsets.only(left: 10, top: getVertical(context) * 0.82),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                        // Get.to(() => ChatRooms(
                        //       myUid: widget.myProfile.data()['userid'],
                        //       myName: widget.myProfile.data()['name'],
                        //     ));
                      },
                      icon: Icon(
                        Icons.message,
                        size: getHorizontal(context) * 0.075,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        size: getHorizontal(context) * 0.075,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cont(String txt1, String txt2) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.black54),
        ),
      ),
      margin: const EdgeInsets.only(left: 10.0, top: 10),
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        children: [
          Image.asset(
            txt1,
            scale: 1,
          ),
          Text(
            txt2,
            style: TextStyle(
                fontSize: getHorizontal(context) * 0.055, color: Colors.black),
          )
        ],
      ),
    );
  }
}
