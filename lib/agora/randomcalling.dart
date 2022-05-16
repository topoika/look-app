import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:look/agora/liveclass.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/liveusers/liveusers.dart';


class RandomCalling extends StatefulWidget {
  
  final String currentUserImage;
  final String currentUserUid;
  final String currentUserName;
  
  const RandomCalling({Key? key,required this.currentUserName,required this.currentUserImage,required this.currentUserUid}) : super(key: key);

  @override
  _RandomCallingState createState() => _RandomCallingState();
}

class _RandomCallingState extends State<RandomCalling> {

late Timer _timer;
  bool userFound=false;
  List namesFound=[];
 String otherUserName='';
 String otherUserUid='';
String chan='';
  @override
  void initState() {
    super.initState();
    otherUserName='';
    _timer =Timer.periodic(const Duration(seconds: 10), (timer) {
      func();
    });
    func();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onWillPop,
      child:SafeArea(
        child: Scaffold(
          backgroundColor: HexColor('#5EEFC9'),
          body: SingleChildScrollView(
            child: SizedBox(
              width: w*1,
              height: h*1,
              child:(otherUserName=='')?Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('             Searching for a User   ',style: TextStyle(fontSize: w*0.05,fontFamily: 'PopB'),),
                      const SpinKitThreeBounce(
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ],
                  ),
                  Stack(

                    children: [
                      Center(
                        child: SizedBox(
                          width: w*0.35,
                          height: h*0.4,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.currentUserImage),
                          ),
                        ),
                      ),
                   Center(
                     child: SizedBox(
                       width: w*0.4,
                       height: h*0.4,
                       child:  SpinKitSpinningLines(
                        color: HexColor('#FC0A0A'),
                        size: w*0.8,
                  ),
                     ),
                   ),
                    ],
                  ),
              Center(
                child: TextButton(
                  onPressed: ()
                  {
                  deleteUserData();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: h*0.1),
                    width: w*0.5,
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:theme().mC,
                    ),
                    child: Center(child: Text("Discard",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
                        color: Colors.white,fontFamily: 'PopR'),
                    ))
                  ),

                ),
              ),
                ],
              ):Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Row(
                  children: [
                    Text("Join Channel With ",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
                      color: Colors.white,fontFamily: 'PopR'),),
                    Text(' $otherUserName',style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
                        color: Colors.white,fontFamily: 'PopR'),),
                  ],
                ),
                  Center(
                    child: TextButton(
                      onPressed: ()
                      {
                        String channel=getChatRoomId(widget.currentUserName, otherUserName);
                        FirebaseFirestore.instance.collection("randomcalling").doc(widget.currentUserUid).delete();
                        RANDOMCALL=false;

                            Get.to(() => LiveClass(channelName:channel,currentUserUid:widget.currentUserUid,currentUserName:widget.currentUserName));
                        setState(() {
                          otherUserName='';
                        });


                      },
                      child: Container(
                          margin: EdgeInsets.only(top: h*0.1),
                          width: w*0.5,
                          padding:const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:theme().mC,
                          ),
                          child: Center(child: Text("Join",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
                              color: Colors.white,fontFamily: 'PopR'),
                          ))
                      ),

                    ),
                  ),
                  // Center(
                  //   child: TextButton(
                  //     onPressed: ()
                  //     {
                  //       if(!namesFound.contains(otherUserName)) {
                  //         print(namesFound);
                  //         print(otherUserName);
                  //       }
                  //       setState(() {
                  //         otherUserName='';
                  //       });
                  //
                  //       func();
                  //
                  //
                  //     },
                  //     child: Container(
                  //         margin: EdgeInsets.only(top: h*0.1),
                  //         width: w*0.5,
                  //         padding:const EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20),
                  //           color:theme().mC,
                  //         ),
                  //         child: Center(child: Text("Cancel",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
                  //             color: Colors.white,fontFamily: 'PopR'),
                  //         ))
                  //     ),
                  //
                  //   ),
                  // ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  const Text('Are you sure?'),
        content:  const Text('Do you want to exit'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              deleteUserData();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  void func()
  {

    FirebaseFirestore.instance.collection("randomcalling").where('userid',isNotEqualTo: widget.currentUserUid)
        .snapshots().listen((result) {
      result.docs.forEach((result) {
        setState(() {
          if(otherUserName=='')
          {
            otherUserUid=result.data()['user'];
            otherUserName=result.data()['name'];
          }
          userFound=true;
        });
      });
    });

  }
  getChatRoomId(String a, String b) {

    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  void deleteUserData()
  {
    try {
      FirebaseFirestore.instance.collection("randomcalling").doc(widget.currentUserUid).delete();
      RANDOMCALL=false;
     Get.to(()=>const LiveUsers());
    }catch(e)
    {
      const Dialogg().popUp(context, 'No Network Connection', 'Check your internet connection and try again later', 1);
    }
  }
}
