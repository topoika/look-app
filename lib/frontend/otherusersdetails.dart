import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/agora/call.dart';
import 'package:permission_handler/permission_handler.dart';

class OtherUsersDetails extends StatefulWidget {

  final String otherUserUid;

  const OtherUsersDetails({Key? key,required this.otherUserUid}) : super(key: key);

  @override
  _OtherUsersDetailsState createState() => _OtherUsersDetailsState();
}

class _OtherUsersDetailsState extends State<OtherUsersDetails> {


  var result;
  bool got=false;
  late String location;

  @override
  void initState() {
    dbChangeListen();
    super.initState();


  }
 Future<void> dbChangeListen() async{
    try
        {
         result= await FirebaseFirestore.instance.collection('Users').doc(widget.otherUserUid).get();
          if(result.data()!['location']!='')
            {
              location=result.data()!['location'];
              setState(() {
                got=true;
              });
            }
        }catch(e)
    {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;

    return  SafeArea(
      child:Scaffold(
        body: SingleChildScrollView(
          child:(got==true)? Column(
            children: [
              Stack(
                children: [

                  SizedBox(
                    width: w*1,
                    height: h*0.5,
                    child: Image.network((result.data()['image']),fit: BoxFit.cover,),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(left: 5.0,top: 5),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.red,size: 20,)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("${result.data()['name']}",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                      Text("     ${result.data()['education']}",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.045,color: Colors.black54),),
                    ],
                  ),
                  InkWell(
                    onTap: ()
                    {
                      onJoin(result.data()['name']);
                    },
                    child: Container(
                      margin:const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.video_call,color: Colors.red,),
                          Text(' Accept',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10,bottom: 10),
                  width: w*0.9,
                  height: 4,
                  color: Colors.black87,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Lives in   ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                          width: w*0.7,
                          height: 80,
                          child: Text(" $location",style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),))),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Status   ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Container(
                    alignment: Alignment.topRight,
                      width: w*0.7,
                      height: 40,
                      child: Text(result.data()['marital'],style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Personality   ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Container(
                      alignment: Alignment.topRight,
                      width: w*0.6,
                      height: 40,
                      child:Text(result.data()['personality'] as String,style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Drinking  ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Container(
                      alignment: Alignment.topRight,
                      width: w*0.7,
                      height: 40,
                      child: Text(result.data()['drinking'],style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Smoking  ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Container(
                      alignment: Alignment.topRight,
                      width: w*0.7,
                      height: 40,
                      child:Text(result.data()['smoking'],style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("   Eating ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black45),),
                  Container(
                      alignment: Alignment.topRight,
                      width: w*0.7,
                      height: 40,
                      child:Text(result.data()['eating'],style: TextStyle(fontFamily: 'PopM',fontSize: w*0.045),)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("    D.O.B  ",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.04,color: Colors.black45),),
                  Container(
                      alignment: Alignment.topRight,
                      width: w*0.7,
                      height: 40,
                      child:Text(result.data()['DOB'],style: TextStyle(fontFamily: 'PopM',fontSize: w*0.04),)),
                ],
              ),
              Text("${result.data()['describe']} \n\n\n\n",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.06,color: Colors.black45),)
            ],
          ):const Center(
            child: CircularProgressIndicator(),
          )
        ),
      ),
    );
  }
  Future<void> onJoin(chennal) async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: chennal,
        ),
      ),
    );
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    await permission.request();
  }
}
