import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/chatting/chat.dart';
import 'package:look/chatting/chatrooms.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/firebase/database/database.dart';
import 'package:look/frontend/homepage.dart';
import 'package:look/frontend/recharge.dart';

import 'editprofile.dart';

class MyProfile extends StatefulWidget {

  var myProfile;

  MyProfile({Key? key,required this.myProfile}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: w*1,
              height: h*0.5,
              child: Image.network((widget.myProfile.data()['image']),fit: BoxFit.cover,),
            ),
            Padding(
              padding:const EdgeInsets.only(left: 5.0,top: 5),
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.red,size: 20,)),
            ),
            Padding(
              padding: EdgeInsets.only(left: w*0.4),
              child: Text("\n\nMyinfo",style: TextStyle(fontFamily: 'PopZ',fontSize: w*0.065,color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              color: Colors.white,
              height: h*0.9,
              width: w*1,
              margin:EdgeInsets.only(top: h*0.2,bottom: h*0.1),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      const Text(''),
                        Text("  ${widget.myProfile.data()['name']}",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                    InkWell(
                      onTap: (){
                        Get.to(()=>EditProfile(location:widget.myProfile.data()['location'],name: widget.myProfile.data()['name'],image: widget.myProfile.data()['image'],
                        country: widget.myProfile.data()['country'],myuid: widget.myProfile.data()['userid'],
                        ));
                      },
                      child: Image.asset(
                        "assets/edit.PNG",
                      ),
                    ),
                      ],
                    ),

                    Text("${widget.myProfile.data()['country']}",style: TextStyle(fontFamily: 'PopM',fontSize: w*0.052,color: Colors.black),),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme().mC,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:10,top: 10,bottom: 10),
                            child: Image.asset(
                              'assets/daimond.PNG',
                              scale: 1,
                            ),
                          ),
                          Column(
                            children: [
                              Text('${widget.myProfile.data()['points']}   ',style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.white),),
                           Text("          Points                ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.white),),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(()=>Recharge(points:widget.myProfile.data()['points'] ,));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Text("Recharge",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black),),
                            ),
                          ),
                        ],

                      ),
                    ),
                    const SizedBox(
                    height: 20,
                    ),
                    InkWell(
                        onTap: ()
                        {

                        },
                        child: cont('assets/callhistory.PNG',"      Call History",w)),
                    InkWell(
                      onTap: ()
                      {

                      },
                      child:cont('assets/publicnotice.PNG',"      Public Notice",w),),
                InkWell(
                  onTap: ()
                  {
                    sendMessage('adminmuhammad');
                  },
                  child:cont('assets/inquiry.PNG',"       1:1 Inquiry",w),),
                InkWell(
                  onTap: ()
                  {

                  },
                  child:cont('assets/invitee.PNG',"     My Invitee",w),),
                InkWell(
                  onTap: ()
                  {
                    Get.to(()=>Recharge(points:widget.myProfile.data()['points'] ,));
                  },
                  child: cont('assets/coinstore.PNG',"      Coin Store",w),),
                    InkWell(
                      onTap: ()
                      {

                      },
                      child:cont('assets/terms.PNG',"     Terms of Use",w),),
                    Padding(
                      padding: const EdgeInsets.only(left: 20 ),
                      child: InkWell(
                        onTap: ()
                        async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              Get.to(() => const HomePage());
                            } catch (e) {
                              const Dialogg().popUp(context, 'Log Out Failed', 'Try Again Later',0);
                            }

                        },
                        child:Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: w*0.12,
                              color: theme().mC,
                            ),
                            Text(
                              "     Log out",
                              style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),
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
                width: w*0.8,
                margin: EdgeInsets.only(left: 10,top: h*0.82),
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
                    IconButton(onPressed: (){

                    }, icon:   Icon(Icons.search,color: theme().mC,size: w*0.075,),),
                    InkWell(
                      onTap: (){

                      },child: Image.asset("assets/terms.PNG",scale: 1.8,),
                    ),
                    IconButton(onPressed: (){
                      Get.to(()=> ChatRooms(myUid: widget.myProfile.data()['userid'],myName: widget.myProfile.data()['name'],));
                    }, icon:   Icon(Icons.message,color: theme().mC,size: w*0.075,),),
                    IconButton(onPressed: (){
                    }, icon:   Icon(Icons.person,color: theme().mC,size: w*0.075,),),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cont(String txt1,String txt2,double w)
  {
    return  Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.black54),
        ),
      ),
      margin: const EdgeInsets.only(left:10.0,top: 10),
      padding:const EdgeInsets.only(left:10,bottom:10),
      child: Row(
        children: [
          Image.asset(
            txt1,
            scale: 1,
          ),
          Text(txt2,style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),)
        ],
      ),
    );
  }
  sendMessage(String userName) {

    List<String> users = [widget.myProfile.data()['name'], userName];

    String chatRoomId = getChatRoomId(widget.myProfile.data()['userid'], userName);

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
              uid:widget.myProfile.data()['userid'],
              senderName: userName, myName: widget.myProfile.data()['name'],
            )));
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
