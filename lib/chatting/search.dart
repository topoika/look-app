
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connexher/services/database.dart';
import 'package:flutter/material.dart';
import 'package:look/constant/theme.dart';
import 'package:look/firebase/database/database.dart';

import 'chat.dart';

class Search extends StatefulWidget {
  final String uid;
  final String user;
  const Search({Key? key, required this.uid, required this.user}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchEditingController =  TextEditingController();
  late QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;
  var result;
  var username=[];
  var image=[];
  var location=[];

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

     FirebaseFirestore.instance
          .collection('Users').where('name',isEqualTo: searchEditingController.text)
          .snapshots()
          .listen((result) {
        result.docs.forEach((result) {
          setState(() {
                username.add(result.data()['name']);
                image.add(result.data()['image']);
                location.add(result.data()['location']);
          });
        });
      });
      setState(() {
        isLoading = false;
        haveUserSearched=true;
      });
      }
    }


  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: username.length,
            itemBuilder: (context, index) {
              return userTile(
                      username[index],
                      location[index],
                    );
            })
        : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) {
    searchEditingController.clear();
    List<String> users = [widget.user, userName];

    String chatRoomId = getChatRoomId(widget.user, userName);

    Map<String, dynamic> chatRoom = {
      "usersData": users,
      "chatRoomId": chatRoomId,
    };

    DatabaseService().addChatRoom(chatRoom, chatRoomId);


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  uid: widget.uid,
                  senderName: userName, myName: widget.user,
                )));
  }

  Widget userTile(String userName, String userLocation) {
    return ListTile(
      title: Text(userName),
      subtitle: Text(userLocation),
      trailing: TextButton(
        child: const Text('Message'),
        onPressed: () => sendMessage(userName),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    double w=MediaQuery.of(context).size.width;
    //double h=MediaQuery.of(context).size.height;
    TextStyle textstyle= TextStyle(fontSize: w*0.041 ,fontWeight: FontWeight.bold,fontFamily: 'PopR');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: theme().mPurple,
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Search",
          style: TextStyle(
              color: theme().mPurple,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(
            child: CircularProgressIndicator(),
          )
          : Column(
            children: [
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchEditingController,
                        style: textstyle,
                        decoration: InputDecoration(
                            hintText: "search username ...",
                            hintStyle: TextStyle(
                              color: theme().mC,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          initiateSearch();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight),
                                borderRadius: BorderRadius.circular(40)),
                            padding: const EdgeInsets.all(12),
                            child: IconButton(
                              onPressed: (){

                              },
                              icon: Icon(
                                Icons.search,
                                color: theme().lightmC,
                              ),
                            )))
                  ],
                ),
              ),
              userList()
            ],
          ),
    );
  }
}
