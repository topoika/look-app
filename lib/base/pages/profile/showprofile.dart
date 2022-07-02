import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:look/base/pages/utils/edit_video_rate.dart';
import 'package:look/base/repositories/user_repository.dart';
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
              height: getVertical(context) * 0.34,
              child: Image.network(
                _user.image ?? noImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: getHorizontal(context) * 0.4,
                  top: getVertical(context) * 0.1),
              child: Text(S.of(context).my_info,
                  style: TextStyle(
                      fontSize: getHorizontal(context) * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              color: Colors.white,
              margin: EdgeInsets.only(top: getVertical(context) * 0.3),
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
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()),
                                  ),
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
                                    fontSize: getHorizontal(context) * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Image.asset(
                              daimond,
                              height: getVertical(context) * 0.024,
                            ),
                            SizedBox(width: getHorizontal(context) * 0.013),
                            Text(
                                "${_user.smsRate}/Msg ${_user.videoRate} ${S.of(context).points}/${S.of(context).min_text}",
                                // "10p/Msg  50p/Min",
                                style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.031,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(width: getHorizontal(context) * 0.02),
                            GestureDetector(
                                onTap: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return EditVideoRate();
                                    }),
                                child: Image.asset(
                                  edit,
                                  height: 30,
                                )),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, "/CallsHistory"),
                          child: cont(callhistory, S.of(context).call_history)),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, "/PublicNotice"),
                        child: cont(publicnotice, S.of(context).public_notice),
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, "/AdminInquiry"),
                        child: cont(inquiry, "1:1 " + S.of(context).inquiry),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, "/MyInvitee"),
                        child: cont(invitee, S.of(context).my_invitee),
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, "/SettingsPage"),
                        child: cont(settings, S.of(context).settings_text),
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, "/TransactionHistory"),
                        child: cont(
                            transhistory, S.of(context).transaction_history),
                      ),
                      InkWell(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, "/Recharge"),
                          child: cont(coinstore, S.of(context).coin_store)),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, "/TermsAndCondition",
                            arguments: true),
                        child: cont(terms, S.of(context).terms_of_use),
                      ),
                      InkWell(
                        onTap: () => logOut(context),
                        child: cont(terms, S.of(context).log_out),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              widthFactor: getHorizontal(context),
              child: bottomNavigation(context, "profile"),
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
            padding: EdgeInsets.all(getHorizontal(context) * 0.01),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 185, 185),
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(txt1),
          ),
          profileText(context, txt2)
        ],
      ),
    );
  }
}
