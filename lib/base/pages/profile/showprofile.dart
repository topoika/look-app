import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/frontend/recharge.dart';
import '../chatrooms.dart';
import './../../models/user_model.dart' as userModel;
import './../utils/titles.dart';

import '../../../generated/l10n.dart';
import '../../Helper/strings.dart';
import 'editprofile.dart';

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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.055),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                profileText(context, _user.name ?? ""),
                                profileText(context, _user.country ?? ""),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () => Get.to(() => const EditProfile()),
                              child: Image.asset(edit)),
                        ],
                      ),
                      rechageContainer(context),
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
                          onTap: () => Get.to(() => const Recharge(points: 15)),
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              widthFactor: getHorizontal(context),
              child: bottomNavigation(context),
            )
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
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: getHorizontal(context) * 0.05),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(txt1), fit: BoxFit.cover)),
          ),
          profileText(context, txt2)
        ],
      ),
    );
  }
}
