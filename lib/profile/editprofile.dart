import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/modifyinterests.dart';

class EditProfile extends StatefulWidget {

  final String name;
  final String image;
  final String country;
final String myuid;
final String location;

  const EditProfile({Key? key,required this.location,required this.name,required this.image,required this.country,required this.myuid}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final TextEditingController _introductionController=TextEditingController();
  final TextEditingController _jobController=TextEditingController();
  final TextEditingController  _locationController=TextEditingController();
  int len=0;
  bool exit=false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    print(widget.myuid);
    _locationController.text=widget.location;
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;

    return  SafeArea(
      child:Scaffold(
        body: SingleChildScrollView(
            child:Column(
              children: [
                Stack(
                  children: [
                        SizedBox(
                          width: w*1,
                          height: h*0.35,
                          child: Image.network(widget.image,fit: BoxFit.cover,),
                        ),
                    Padding(
                      padding:const EdgeInsets.only(left: 5.0,top: 5),
                      child: IconButton(
                          onPressed: (){
                            if(exit==false) {
                              popUp(context);
                            }else
                              {
                                Navigator.of(context).pop();
                              }
                      }, icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.red,size: 25,)),
                    ),

                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: h*0.36),
                      width: w*1,
                      alignment: Alignment.topCenter,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(child: Text(widget.name,style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),)),
                            Center(child: Text(widget.country,style: TextStyle(fontFamily: 'PopB',fontSize: w*0.045,color: Colors.black54),)),
                            Text("   Self-Introduction",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                            Container(
                              width: w*1,
                              height: h*0.2,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: Colors.black54),
                                  top: BorderSide(width: 2.0, color: Colors.black54),
                                ),
                              ),
                              child: TextFormField(
                                maxLength: 500,
                                controller: _introductionController,
                                maxLines: 8,
                                style: TextStyle(color: Colors.black54,fontFamily: "PopB",fontSize: w*0.04),
                                decoration:const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15, top: 10, right: 10),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length<10) {
                                    return 'Type atleast 10+ characters';
                                  }
                                  return null;
                                },

                              ),
                            ),
                            Text("\n   Interests",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                            InkWell(
                              onTap: (){
                                Get.to(()=>const ModifyInterests());
                              },
                              child: Container(
                          width: w * 1,
                          height: h * 0.07,
                          padding:const EdgeInsets.only(top: 7),
                          decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0, color: Colors.black54),
                                top: BorderSide(width: 2.0, color: Colors.black54),
                              ),
                          ),
                                child: Text("   Input your interests",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.05,color: Colors.black54),),
                        ),
                            ),
                        Text("\n   Job title",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                            Container(
                              width: w*1,
                              height: h*0.1,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: Colors.black54),
                                  top: BorderSide(width: 2.0, color: Colors.black54),
                                ),
                              ),
                              child: TextFormField(
                                controller: _jobController,
                                maxLines: 2,
                                style: TextStyle(color: Colors.black54,fontFamily: "PopB",fontSize: w*0.04),
                                decoration:const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  hintText: "Enter your current job",
                                  contentPadding: EdgeInsets.only(left: 15, top: 10, right: 10),
                                ),
                              //  onChanged: _onChanged,
                                validator: (value) {
                                  if (value!.isEmpty || value.length<5) {
                                    return 'Job title cannot be less than 5';
                                  }
                                  return null;
                                },

                              ),
                            ),
                            Text("\n   Lives in",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055,color: Colors.black),),
                            Container(
                              width: w*1,
                              height: h*0.1,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: Colors.black54),
                                  top: BorderSide(width: 2.0, color: Colors.black54),
                                ),
                              ),
                              child: TextFormField(
                                controller: _locationController,
                                maxLines: 2,
                                style: TextStyle(color: Colors.black54,fontFamily: "PopB",fontSize: w*0.04),
                                decoration:const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                  ),
                                  hintText: "Enter your current job",
                                  contentPadding: EdgeInsets.only(left: 15, top: 10, right: 10),
                                ),
                                //  onChanged: _onChanged,
                                validator: (value) {
                                  if (value!.isEmpty || value.length<5) {
                                    return 'Job title cannot be less than 5';
                                  }
                                  return null;
                                },

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                button("Save & Update"),
              ],
            )
        ),
      ),
    );
  }
  Widget button(String txt)
  {
    double w=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: w*0.07,left: w*0.04,right: w*0.04,bottom: 20),
      width: w*0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:theme().mC,
      ),
      child: TextButton(
        onPressed: ()
        async{
          if(formKey.currentState!.validate())
            {
              await FirebaseFirestore.instance.collection("Users").doc(widget.myuid).update({
                'describe':_introductionController.text,
                'interest':ModifyINTERESTS,
                'job':_jobController.text,
                'location': _locationController.text,
              });
              _introductionController.clear();
              _jobController.clear();
              _locationController.clear();
              ModifyINTERESTS=[];
              _locationController.clear();
              Navigator.of(context).pop();
            }
        },
        child: Text(txt,style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'PopR'),),
      ),
    );
  }
  void popUp(BuildContext ctx)
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Save Your data')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : const <Widget>[
              Expanded(
                child: Text(
                  "Your data will be discarded if you press again",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,

                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[

            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  setState(() {
                    exit=true;
                  });
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
