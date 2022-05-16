import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/variables.dart';
import 'package:look/frontend/homepage.dart';

import 'drinking.dart';

class MaritalStatus extends StatefulWidget {
  const MaritalStatus({Key? key}) : super(key: key);

  @override
  _MaritalStatusState createState() => _MaritalStatusState();
}

class _MaritalStatusState extends State<MaritalStatus> {


  @override
  Widget build(BuildContext context) {


    double w = MediaQuery.of(context).size.width;

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(onPressed: (){
                      Navigator.of(context);
                    }, icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black45,)),
                  ),
                  TextButton(onPressed: (){
                  Get.to(()=>const Drinking());
                  }, child:Text("Skip    ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                      fontFamily:"PopZ",color: Colors.black45),))
                ],
              ),
              Text("Marital Status?\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black),),
              choices("Single",w),
              choices("Single mam",w),
              choices("Single dad",w),
              choices("In a relationship",w),
              choices("Married",w),
              choices("Separated",w),
              choices("Divorce",w),
              choices("Widowed",w),
            ],
          ),
        ),
      ),
    );
  }
  Widget choices(String txt,double w)
  {
    return InkWell(
      onTap: ()
      {
        MARITAL=txt;
        Get.to(()=>const Drinking());
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: w*0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(txt,style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'PopR',fontSize: 15,color: Colors.black45),)),
      ),
    );
  }
}
