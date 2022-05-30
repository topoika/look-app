import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/recharge.dart';
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
              padding: EdgeInsets.only(
                  left: getHorizontal(context) * 0.4,
                  top: getVertical(context) * 0.07),
              child: Text(S.of(context).my_info,
                  style: TextStyle(
                      fontSize: getHorizontal(context) * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              color: Colors.white,
              margin: EdgeInsets.only(top: getVertical(context) * 0.2),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.055),
                  child: Column(
                    children: [
                      Row(
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
                              child: Image.asset(
                                edit,
                                height: 30,
                              )),
                        ],
                      ),
                      rechageContainer(context),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 2.0, color: Colors.black54),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).points_setting,
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.055,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Image.asset(
                              daimond,
                              height: getVertical(context) * 0.024,
                            ),
                            SizedBox(width: getHorizontal(context) * 0.013),
                            Text("10p/Msg  50p/Min",
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(width: getHorizontal(context) * 0.02),
                            GestureDetector(
                                //TODO
                                // onTap: () => Get.to(() => const EditProfile()),
                                child: Image.asset(
                              edit,
                              height: 30,
                            )),
                          ],
                        ),
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
                        onTap: () {},
                        child: cont(invitee, S.of(context).transaction_history),
                      ),
                      InkWell(
                        onTap: () {},
                        child: cont(invitee, S.of(context).transaction_history),
                      ),
                      InkWell(
                        onTap: () {},
                        child: cont(invitee, S.of(context).transaction_history),
                      ),
                      InkWell(
                          onTap: () => Get.to(() => const Recharge()),
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
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(bottom: 5),
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
