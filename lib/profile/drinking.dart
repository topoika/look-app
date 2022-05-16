import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/personality.dart';

class Drinking extends StatefulWidget {
  const Drinking({Key? key}) : super(key: key);

  @override
  _DrinkingState createState() => _DrinkingState();
}

class _DrinkingState extends State<Drinking> {

bool drink1=false;
bool drink2=false;
bool drink3=false;
bool smoke1=false;
bool smoke2=false;
bool smoke3=false;
bool eat1=false;
bool eat2=false;


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
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black45,),
                  ),
                  TextButton(onPressed: (){
                    (drink1==true)?DRINKING='Non-Drinker':(drink2==true)?DRINKING='Social Drinker':(drink3==true)?DRINKING='Heavy Drinker':SMOKING="Not Selected";
                    (smoke1==true)?SMOKING='Non-Smoker':(smoke2==true)?SMOKING='Light Smoker':(smoke3==true)?SMOKING='Heavy Smoker':SMOKING="Not Selected";
                    (eat1==true)? EATING='Vegan':(eat2==true)?EATING='Vegetarian':EATING='Not Selected';
                    Get.to(()=>const Personality());

                  }, child:Text("Skip    ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                      fontFamily:"PopZ",color: Colors.black45),))
                ],
              ),
              Text("Drinking",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black54),),
              TextButton(
                  onPressed: (){
                    setState(() {
                      drink1=!drink1;
                      drink2=false;
                      drink3=false;
                    });
                  },
                  child:choices("Non-drinker",w,(drink1)?Colors.red:Colors.black45)),
              TextButton(
                  onPressed: (){
                    setState(() {
                      drink1=false;
                      drink2=!drink2;
                      drink3=false;
                    });
                  },child: choices("Social drinker",w,(drink2)?Colors.red:Colors.black45)),
              TextButton(
                  onPressed: (){
                    setState(() {
                      drink1=false;
                      drink2=false;
                      drink3=!drink3;
                    });
                  },child: choices("Heavy drinker",w,(drink3)?Colors.red:Colors.black45)),
              Text("\nSmoking",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black54),),
              TextButton(
                  onPressed: (){
                    setState(() {
                      smoke1=!smoke1;
                      smoke2=false;
                      smoke3=false;
                    });
                  },child: choices("Non-Smoker",w,(smoke1)?Colors.red:Colors.black45)),
            TextButton(
                onPressed: (){
                  setState(() {
                    smoke1=false;
                    smoke2=!smoke2;
                    smoke3=false;
                  });
                },child: choices("Lighter Smoker",w,(smoke2)?Colors.red:Colors.black45)),
            TextButton(
                onPressed: (){
                  setState(() {
                    smoke1=false;
                    smoke2=false;
                    smoke3=!smoke3;
                  });
                },child: choices("Heavy Smoker",w,(smoke3)?Colors.red:Colors.black45)),
              Text("\nEating",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                  fontFamily:"PopZ",color: Colors.black54),),
            TextButton(
                onPressed: (){
                  setState(() {
                    eat1=!eat1;
                    eat2=false;

                  });
                },child: choices("Vegan",w,(eat1)?Colors.red:Colors.black45)),
            TextButton(
                onPressed: (){
                  setState(() {
                    eat1=false;
                    eat2=!eat2;
                  });
                },child: choices("Vegetrian",w,(eat2)?Colors.red:Colors.black45)),
            ],
          ),
        ),
      ),
    );
  }
  Widget choices(String txt,double w,Color clr)
  {
    return Container(
      padding: const EdgeInsets.all(10),
      width: w*0.8,
      decoration: BoxDecoration(
        border: Border.all(color: clr),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: Text(txt,style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'PopR',fontSize: 15,color: Colors.black45),)),
    );
  }
}
