import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/variables.dart';
import 'package:look/base/pages/profile/location.dart';


class ModifyInterests extends StatefulWidget {
  const ModifyInterests({Key? key}) : super(key: key);

  @override
  _ModifyInterestsState createState() => _ModifyInterestsState();
}

class _ModifyInterestsState extends State<ModifyInterests> {


  List myInterests=[];
  @override
  Widget build(BuildContext context) {


    double w = MediaQuery.of(context).size.width;

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:15.0,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(

                  children: [
                    IconButton(
                      onPressed: (){
                        ModifyINTERESTS=myInterests;
                        final snackBar = SnackBar(
                          margin: const EdgeInsets.all(20),
                          behavior: SnackBarBehavior.floating,
                          content: const Text('your choices are saved'),
                          backgroundColor: (Colors.redAccent),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      },
                      icon:const Icon(Icons.arrow_back_ios_outlined,color: Colors.black87,),
                    ),
                    Text("\n              Modify Interests",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                        fontFamily:"PopZ",color: Colors.black87),),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '( ${myInterests.length}/5 )     ',
                    style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: w*0.05),
                  ),
                ),
                Row(

                  children: [
                    choices1("outdoor activity",w),
                    choices1("walk with pets ",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("culture",w),
                    choices1("museum",w),
                    choices1("surfing",w),
                    choices1("camping",w),
                  ],
                ),
                Row(

                  children: [
                    choices1("cup of tea",w),
                    choices1("  car  ",w),
                    choices1(" picnic ",w),
                    choices1(" ESFJ ",w),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choices1("walking with neighberhood",w),
                    choices1("sweet dessert",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("cup of coffee",w),
                    choices1("cat lover",w),
                    choices1("instagram",w),
                  ],
                ),
                Row(
                  children: [
                    choices1(" INFJ ",w),
                    choices1("environmental movement",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("animation",w),
                    choices1("food tour",w),
                    choices1("gardening",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("candid conversation",w),
                    choices1("fashion",w),
                    choices1("gamer",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("football",w),
                    choices1("nature",w),
                    choices1("talk when bored",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("cycling",w),
                    choices1("hiking",w),
                    choices1("startup",w),
                    choices1("consert",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("world traveler",w),
                    choices1("K-pop",w),
                    choices1("brunch",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("author",w),
                    choices1("running",w),
                    choices1("learn new things",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("cooking",w),
                    choices1("mukbung (eating show)",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("sports",w),
                    choices1("craft beer",w),
                    choices1("vegan",w),
                    choices1(" ESTJ ",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("baking",w),
                    choices1("festival",w),
                    choices1("language exchange",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("walk",w),
                    choices1(" DIY ",w),
                    choices1(" ENFJ ",w),
                    choices1("cartoon cafe",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("swimming",w),
                    choices1(" INTJ ",w),
                    choices1("make friend",w),
                  ],
                ),
                Row(
                  children: [
                    choices1("climbing",w),
                    choices1(" ISTP ",w),
                    choices1("PC room",w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget choices1(String txt,double w)
  {
    double h=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: ()
      {
       if(myInterests.length<5)
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
         }
       else
         {
           if(myInterests.contains(txt))
           {
             setState(() {
               myInterests.remove(txt);
             });
           }
         }
      },
      child: Container(
        margin: EdgeInsets.all((txt=="camping")?1:w*0.01),
        padding:EdgeInsets.only(top: 4,bottom: h*0.004,left: (txt=="camping")?0:7,right: (txt=="camping")?0:7),
        decoration: BoxDecoration(
          border: Border.all(color:(myInterests.contains(txt))?Colors.red:Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text("  $txt  ",style:  TextStyle(fontWeight: FontWeight.bold,fontFamily: 'PopB',fontSize: w*0.035,color: Colors.black54),)),
      ),
    );
  }
}
