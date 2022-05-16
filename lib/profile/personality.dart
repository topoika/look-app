import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/location.dart';


class Personality extends StatefulWidget {
  const Personality({Key? key}) : super(key: key);

  @override
  _PersonalityState createState() => _PersonalityState();
}

class _PersonalityState extends State<Personality> {

  String myPersonality="Not Selected";
  List myInterests=[];
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
                    child: IconButton(
                      onPressed: (){
                        Navigator.of(context);
                      },
                      icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.black45,),
                    ),
                  ),
                  TextButton(onPressed: (){
                    INTERESTS=myInterests;
                    PERSONALITY=myPersonality;
                    Get.to(()=>const GetUserLocation());
                  }, child:Text("Skip    ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                      fontFamily:"PopZ",color: Colors.black45),))
                ],
              ),
              Text("Personality\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black45),),
              choices("Funny",w),
              choices("Romantic",w),
              choices("Open-minded",w),
              Text("\nInterests\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black45),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Dancing",w),
                  choices1("Hiking",w),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Singing",w),
                  choices1("Reading",w),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Fishing",w),
                  choices1("Travel",w),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Fitness",w),
                  choices1("Photography",w),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Music",w),
                  choices1("Movie",w),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Camping",w),
                  choices1("Sports",w),
                ],
              ),
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
       setState(() {
         myPersonality=txt;
       });
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: w*0.8,
        decoration: BoxDecoration(
          border: Border.all(color:(myPersonality.contains(txt))?Colors.red:Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(txt,style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'PopR',fontSize: 15,color: Colors.black45),)),
      ),
    );
  }
  Widget choices1(String txt,double w)
  {
    return InkWell(
      onTap: ()
      {
        if(myInterests.contains(txt))
        {
          setState(() {
            myInterests.remove(txt);
          });
        }
        else {
          setState(() {
            myInterests.add(txt);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(7),
        width: w*0.4,
        decoration: BoxDecoration(
          border: Border.all(color:(myInterests.contains(txt))?Colors.red:Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(txt,style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'PopR',fontSize: 15,color: Colors.black45),)),
      ),
    );
  }
}
