import 'dart:io';

import 'package:flutter/material.dart';
import 'package:look/base/controllers/livestream_controller.dart';
import 'package:look/base/models/live_stream_model.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/models/country_model.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/recharge.dart';

import '../awards.dart';
import '../../Helper/theme.dart';
import '../../../generated/l10n.dart';
import 'titles.dart';

Widget countryItemWidget(BuildContext context, Country country, Function onTap,
    List<String> activeCountry) {
  return GestureDetector(
    onTap: () =>onTap(), 
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: activeCountry.contains(country.name)
            ? Colors.red
            : Theme.of(context).accentColor,
      ),
      margin: EdgeInsets.only(right: getHorizontal(context) * 0.03),
      padding: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.02),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(5),
            child: Image.network(
              "https://flagcdn.com/w160/${country.code!.toLowerCase()}.png",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return SizedBox();
              },
              fit: BoxFit.cover,
            ),
          ),
          Text(
            country.short_name!.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: getHorizontal(context) * 0.03),
          ),
        ],
      ),
    ),
  );
}

Widget rewardsWidget(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Award())),
    child: Container(
      margin: EdgeInsets.only(right: getHorizontal(context) * 0.02, bottom: 5),
      width: 70,
      child: Image.asset(
        box,
        fit: BoxFit.cover,
        scale: 1,
      ),
    ),
  );
}

Widget goLiveButton(BuildContext context, Function ontap) {
  return GestureDetector(
    onTap: () => ontap(),
    child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.06, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: theme().mC,
        borderRadius: const BorderRadius.all(
            Radius.circular(20) //                 <--- border radius here
            ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sensors,
            size: getHorizontal(context) * 0.04,
            color: Colors.white,
          ),
          SizedBox(width: getHorizontal(context) * 0.015),
          Text(
            S.of(context).go_live,
            style: TextStyle(
              fontSize: getHorizontal(context) * 0.026,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bottomNavigation(BuildContext context, String home) {
  return Container(
    margin: EdgeInsets.only(
        left: getHorizontal(context) * 0.06,
        right: getHorizontal(context) * 0.06,
        bottom: home != "home" ? 10 : 35),
    padding: EdgeInsets.symmetric(
        horizontal: getHorizontal(context) * 0.03, vertical: 7),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black12,
      ),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () => home != "home"
              ? Navigator.pushReplacementNamed(context, "/LiveUsers")
              : null,
          child: Image.asset(
            search,
            height: getHorizontal(context) * 0.065,
          ),
        ),
        InkWell(
            onTap: () => Navigator.pushNamed(context, "/RandomCalling"),
            child: Image.asset(
              random,
              height: getHorizontal(context) * 0.065,
            )),
        InkWell(
          onTap: () => Navigator.pushNamed(context, "/ChatRooms"),
          child: Image.asset(
            chats,
            height: getHorizontal(context) * 0.065,
          ),
        ),
        InkWell(
          onTap: home == "home"
              ? () => Navigator.pushNamed(context, "/MyProfile")
              : null,
          child: Image.asset(
            user,
            height: getHorizontal(context) * 0.065,
          ),
        ),
      ],
    ),
  );
}

Widget tabBarItem(BuildContext context, String text, image) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        image,
        height: getHorizontal(context) * 0.075,
      ),
      SizedBox(width: getHorizontal(context) * 0.01),
      Text(
        text,
        style: TextStyle(
          fontSize: getHorizontal(context) * 0.032,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

Widget topBarItem(BuildContext context, bool videocall) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: getHorizontal(context) * 0.02, vertical: 5),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            videocall
                ? Navigator.pushReplacementNamed(context, '/LiveUsers')
                : null;
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                  color: !videocall ? Colors.transparent : Colors.black),
              borderRadius: BorderRadius.circular(30),
              color: !videocall ? theme().mC : Colors.transparent,
            ),
            child: Text(
              S.of(context).live_streaming,
              style: TextStyle(
                color: Colors.black,
                fontSize: getHorizontal(context) * 0.03,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            !videocall
                ? Navigator.pushReplacementNamed(context, '/VideoCalls')
                : null;
          },
          child: Container(
            margin: EdgeInsets.only(left: getHorizontal(context) * 0.027),
            padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.05, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: videocall ? Colors.transparent : Colors.black),
                borderRadius: BorderRadius.circular(30),
                color: videocall ? theme().mC : Colors.transparent),
            child: Text(
              S.of(context).video_call,
              style: TextStyle(
                color: Colors.black,
                fontSize: getHorizontal(context) * 0.03,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: getHorizontal(context) * 0.2),
          child: Icon(
            Icons.notifications,
            size: getHorizontal(context) * 0.08,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

Widget rechageContainer(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 241, 84, 123),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: getHorizontal(context) * 0.034, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            daimond,
            height: getVertical(context) * 0.03,
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              currentUser.value.points.toString(),
              style: TextStyle(
                  fontSize: getHorizontal(context) * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              S.of(context).available_points,
              style: TextStyle(
                  fontSize: getHorizontal(context) * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Recharge())),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: profileText(context, S.of(context).recharge)),
        ),
      ],
    ),
  );
}

Widget noDataFoundContainer(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: Image.asset(
          nodatafound,
          height: 50,
        ),
      ),
      SizedBox(height: getVertical(context) * 0.02),
      Text(
        S.of(context).no_data_found,
        style: TextStyle(color: Colors.red),
      ),
    ],
  );
}

Widget divider(double thickness) {
  return Divider(
    color: Colors.black.withOpacity(.5),
    height: 2,
    thickness: thickness,
  );
}

Widget editProfileImageContainer(
    BuildContext context, String? img, Function ontap) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      width: getHorizontal(context) / 3 - 27,
      height: getVertical(context) * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: img != null ? Colors.transparent : Colors.black26,
      ),
      child: Stack(
        children: [
          img != null
              ? Image.network(
                  img,
                  height: getVertical(context) * 0.18,
                  width: getHorizontal(context) / 3 - 27,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
          GestureDetector(
            onTap: () => ontap(),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(5),
                transform: Matrix4.translationValues(8.0, 8.0, 0.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color(0xFFf62459),
                      Color.fromARGB(255, 214, 37, 81),
                      Theme.of(context).accentColor,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget bottomSheetContainer(BuildContext context) {
  return Container(
      child: Column(
    children: <Widget>[const Text('text')],
  ));
}

Widget addStreamTitleBottomSheet(BuildContext context) {
  TextEditingController _liveTitle = TextEditingController();
  LiveStream _liveStream = LiveStream();
  _liveStream.title = '';
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.04, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enter the title of your liveStream',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: getHorizontal(context) * 0.04,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (val) => _liveStream.title = val,
              controller: _liveTitle,
              decoration: InputDecoration(
                hintText: "your-name livestream",
                labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                contentPadding: const EdgeInsets.all(12),
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            buttonWidget(context, () {
              if (_liveTitle.text.length < 3) {
                Navigator.pop(context);
                showSnackBar(context, "Enter 3+ char for the title", true);
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                _liveStream.title = _liveTitle.text;
                LiveStreamController().createLiveStream(context, _liveStream);
              }
            }, S.of(context).continue_text)
          ],
        ),
      ),
    ),
  );
}

Widget bigEventBtn(BuildContext context) => Center(
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, "/BigEvent"),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: getVertical(context) * 0.1),
              padding: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.16, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                S.of(context).big_event,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: getHorizontal(context) * 0.04),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
              ),
              margin: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.04),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).get_one_point_times_points,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getHorizontal(context) * 0.035,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
