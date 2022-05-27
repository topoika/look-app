import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/models/country_model.dart';
import 'package:look/base/pages/liveusers.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/recharge.dart';

import '../awards.dart';
import '../chatrooms.dart';
import '../search.dart';
import '../../../constant/theme.dart';
import '../../../generated/l10n.dart';
import '../profile/showprofile.dart';
import '../videocall.dart';
import 'titles.dart';

Widget countryItemWidget(BuildContext context, Country country) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).accentColor,
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
            fit: BoxFit.cover,
          ),
        ),
        Text(
          country.short_name!.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );
}

Widget rewardsWidget(BuildContext context) {
  return GestureDetector(
    onTap: ()=> Get.to(()=>Award()),
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
    onTap: () => ontap,
    child: Container(
      margin: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.06, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
            Radius.circular(20) //                 <--- border radius here
            ),
        color: theme().mC,
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
              fontSize: getHorizontal(context) * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bottomNavigation(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.06),
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
        IconButton(
          onPressed: () {
            Get.to(() => const Search());
          },
          icon: Icon(
            Icons.search,
            color: theme().mC,
            size: getHorizontal(context) * 0.075,
          ),
        ),
        InkWell(
            onTap: () {},
            child: Icon(
              Icons.radar_rounded,
              color: theme().mC,
              size: getHorizontal(context) * 0.075,
            )),
        IconButton(
          onPressed: () {
            Get.to(() => const ChatRooms());
          },
          icon: Icon(
            Icons.message,
            color: theme().mC,
            size: getHorizontal(context) * 0.075,
          ),
        ),
        IconButton(
          onPressed: () => Get.to(() => const MyProfile()),
          icon: Icon(
            Icons.person,
            color: theme().mC,
            size: getHorizontal(context) * 0.075,
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
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: getHorizontal(context) * 0.045,
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
            videocall ? Get.to(() => const LiveUsers()) : null;
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
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            !videocall ? Get.to(() => const VideoCalls()) : null;
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
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
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
                  fontSize: getHorizontal(context) * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Available Points",
              style: TextStyle(
                  fontSize: getHorizontal(context) * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Get.to(() => const Recharge()),
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
