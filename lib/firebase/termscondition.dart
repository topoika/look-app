import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/countrymobilenumber.dart';
import 'package:look/profile/uploadphoto.dart';


class TermsAndCondition extends StatefulWidget {

  final bool val;

  const TermsAndCondition({Key? key,required this.val}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {

  bool checkedValue=false;
  late String uid;
  void initState() {
     uid=FirebaseAuth.instance.currentUser!.uid;

  }

  @override
  Widget build(BuildContext context) {


    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle textstyle = TextStyle(
        fontSize: w * 0.04,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontFamily: 'PopB');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: w * 0.15, bottom: w * 0.1),
              child: Image.asset(
                'assets/look8.png',
                scale: 5,
              ),
            ),
            Center(child: Text("To Use Link Me, You Should Read\n and AgreeTo Terms and Conditions",
              style: TextStyle(fontSize: w*0.04,fontFamily: 'PopM'),)),
            Container(
              width: w*0.7,
              padding: EdgeInsets.only(top: h*0.1),
              child: InkWell(
                onTap: ()
                {
                  popUp(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/terms.PNG',
                    ),
                    Text("  Terms Of Use",style: textstyle,)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:w*0.04,top: h*0.04),
                  child: Image.asset(
                    'assets/location.PNG',
                  ),
                ),
                Text("\n  Location Based\n  Service Terms",style: textstyle,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w*0.165,top: h*0.04),
                  child: Image.asset(
                    'assets/personal.PNG',
                  ),
                ),
                Text("  Personal Information\n  Handling Methods",style: textstyle,)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: h*0.1,left: w*0.07),
              child: Row(
                children: [
                  Checkbox(
                    value: checkedValue,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = !checkedValue;
                      });
                    },
                  ),
                 Text('\n  I agree with above personal\n  handling information',style: TextStyle(fontFamily:'PopB',fontSize:w*0.05,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            (!checkedValue)? Container(
              margin: EdgeInsets.only(top: w*0.05,left: w*0.03,right: w*0.03),
              padding:const EdgeInsets.all(10),
              width: w*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:theme().lightmC,
              ),
              child:  Center(child: Text("next",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white60,fontFamily: 'PopR'),)),

            ): Container(
              margin: EdgeInsets.only(top: w*0.05,left: w*0.03,right: w*0.03),
              width: w*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:theme().mC,
              ),
              child: TextButton(
                onPressed: ()
                {
                  UID=uid;
                  (widget.val==true)? Get.to(const CountryPhone()):Get.to(()=>const UploadPhoto());
                },
                child: Text("next",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'PopR'),),
              ),
            )
          ],
        ),
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
        title: const Center(child: Text('Terms and Conditions')),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : const <Widget>[
            Expanded(
              child: Text(
                "These are the terms and Conditions or our app",
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
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}
}
