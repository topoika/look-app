import 'package:flutter/material.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:look/base/pages/call.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/utils/titles.dart';
import 'package:look/base/repositories/calls_repository.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../generated/l10n.dart';
import 'utils/snackbar.dart';

class OtherUsersDetails extends StatefulWidget {
  final User user;
  final bool random;
  const OtherUsersDetails({Key? key, required this.user, required this.random})
      : super(key: key);

  @override
  _OtherUsersDetailsState createState() => _OtherUsersDetailsState(user);
}

class _OtherUsersDetailsState extends StateMVC<OtherUsersDetails> {
  final User _user;
  late CallsController _con;
  _OtherUsersDetailsState(this._user) : super(CallsController()) {
    _con = controller as CallsController;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black12,
                  height: getVertical(context) * 0.6,
                  child: _user.images!.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          itemCount: _user.images!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getHorizontal(context) * 0.01),
                              child: Image.network(
                                _user.images![index],
                                fit: BoxFit.cover,
                                width: getHorizontal(context),
                              ),
                            );
                          })
                      : Image.network(
                          noImage,
                          fit: BoxFit.cover,
                          width: getHorizontal(context),
                        ),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    height: 16,
                    width: getHorizontal(context),
                    child: Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(),
                          itemCount: _user.images!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 15,
                              width: 15,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_user.name ?? ""} ${_user.age.toString()}",
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.058,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          profileText(context, _user.education ?? ""),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          onJoin(_user.uid, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black45,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                                child: Icon(
                                  Icons.video_call_sharp,
                                  color: Colors.white,
                                  size: getHorizontal(context) * 0.05,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Column(
                                children: [
                                  Text(
                                      "${_user.videoRate} ${S.of(context).points}/ ${S.of(context).min_text}",
                                      style: TextStyle(
                                          fontSize:
                                              getHorizontal(context) * 0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  Text(
                                    widget.random
                                        ? S.of(context).accept
                                        : S.of(context).video_call,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: getHorizontal(context) * 0.043,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        directions,
                        height: 30,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "15 ${S.of(context).km_away}",
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.048,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const Spacer(),
                      widget.random
                          ? GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontal(context) * 0.07,
                                    vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.black54)),
                                child: Text(
                                  S.of(context).skip,
                                  style: TextStyle(
                                      fontSize: getHorizontal(context) * 0.048,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ))
                          : SizedBox()
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 5,
                    thickness: 2,
                    color: Colors.black38,
                  ),
                  otherProfileItem(
                      S.of(context).lives_in, _user.location ?? ""),
                  otherProfileItem(S.of(context).status, _user.marital ?? ""),
                  otherProfileItem(
                      S.of(context).personality, _user.personality ?? ""),
                  otherProfileItem(
                      S.of(context).drinking, _user.drinking ?? ""),
                  otherProfileItem(S.of(context).smoking, _user.smoking ?? ""),
                  otherProfileItem(S.of(context).eating, _user.eating ?? ""),
                  otherProfileItem(
                      S.of(context).date_of_birth, _user.dob ?? ""),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 5,
                    thickness: 2,
                    color: Colors.black38,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _user.describe ?? "",
                    style: TextStyle(
                        fontSize: getHorizontal(context) * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  const Divider(
                    height: 5,
                    thickness: 2,
                    color: Colors.black38,
                  ),
                  profileText(context, S.of(context).recieved_gifts),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                        itemCount: 7,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: Text(S.of(context).gift_text),
                          );
                        }),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> onJoin(chennal, BuildContext context) async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    showToast(S.of(context).please_wait + "...");
    _con.createVideoCall(context, _user);
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    await permission.request();
  }

  Widget otherProfileItem(String title, trailing) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0),
      title: profileText(context, title),
      trailing: Text(
        trailing,
        style: TextStyle(
            fontSize: getHorizontal(context) * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.black54),
      ),
    );
  }
}
