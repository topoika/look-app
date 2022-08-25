import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/chat_controller.dart';
import 'package:look/base/models/chat_room_model.dart';
import 'package:look/base/pages/search.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/country_model.dart';
import 'utils/custom_containers.dart';

class ChatRooms extends StatefulWidget {
  const ChatRooms({Key? key}) : super(key: key);

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends StateMVC<ChatRooms> {
  late ChatController _con;
  _ChatRoomsState() : super(ChatController()) {
    _con = controller as ChatController;
  }
  List<String> activeCountry = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          S.of(context).chats,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.045),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(height: 30),
          SizedBox(
            width: getHorizontal(context) * 0.9,
            height: 28,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() => activeCountry = []);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          right: getHorizontal(context) * 0.03,
                          left: getHorizontal(context) * 0.04),
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontal(context) * 0.02,
                          vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: activeCountry.isEmpty
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
                    width:
                        getHorizontal(context) - getHorizontal(context) * 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: countries.length,
                      itemBuilder: (BuildContext context, int index) {
                        var country = countries[index];
                        return countryItemWidget(
                            context,
                            country,
                            () => setState(() =>
                                activeCountry.contains(country.name)
                                    ? activeCountry.remove(country.name!)
                                    : activeCountry.add(country.name!)),
                            activeCountry);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder(
            stream: activeCountry.isEmpty
                ? _con.firebaseFirestore
                    .collection(_con.chatRoomCollection)
                    .where('involes', arrayContains: currentUser.value.uid)
                    .orderBy("lastUpdated", descending: true)
                    .snapshots()
                : _con.firebaseFirestore
                    .collection(_con.chatRoomCollection)
                    .where('involes', arrayContains: currentUser.value.uid)
                    .where("country", whereIn: activeCountry)
                    .orderBy("lastUpdated", descending: true)
                    .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return !snapshot.hasData
                  ? SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var _chatRoom =
                            ChatRoom.fromMap(snapshot.data!.docs[index].data());
                        var _otherUser = _chatRoom.involved!.firstWhere(
                            (value) => value.uid != currentUser.value.uid);
                        return GestureDetector(
                          onTap: (() => Navigator.pushNamed(context, "/Chat",
                              arguments: _chatRoom)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            margin: EdgeInsets.symmetric(
                                horizontal: getHorizontal(context) * 0.04,
                                vertical: 5),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black26),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage(
                                      _otherUser.images!.length > 0
                                          ? _otherUser.images![0]
                                          : noImage),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  width: getHorizontal(context) * 0.02,
                                ),
                                SizedBox(
                                  width: getHorizontal(context) * 0.56,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${_otherUser.name}  ${_otherUser.age}  ${_otherUser.location!.split(" ")[0].replaceAll(",", " ")} ${_otherUser.country}",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize:
                                              getHorizontal(context) * 0.032,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        _chatRoom.lastMessage!.message ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                          fontSize:
                                              getHorizontal(context) * 0.025,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getTimeDifference(
                                          _chatRoom.lastUpdated!)!,
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            getHorizontal(context) * 0.027,
                                      ),
                                    ),
                                    Text(
                                      "${_otherUser.smsRate}P   115Km",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            getHorizontal(context) * 0.026,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Search()));
        },
      ),
    );
  }
}
