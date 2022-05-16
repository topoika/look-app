import 'package:flutter/material.dart';
import 'package:look/constant/theme.dart';

class Otp extends StatefulWidget {
  final String phoneNumber;

  const Otp({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final focus = FocusNode();
  bool  otpCheck=false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle textstyle = TextStyle(
        fontSize: w * 0.08,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'PopR');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: w * 0.15, bottom: w * 0.2),
              child: Image.asset(
                'assets/look8.png',
                scale: 5,
              ),
            ),
            Text(
              "Enter your Code\n",
              style: TextStyle(
                  fontSize: w * 0.07, color: Colors.black, fontFamily: 'PopZ'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.quick_contacts_dialer,
                  color: Colors.black,
                  size: w * 0.08,
                ),
                Text(
                  "  ${widget.phoneNumber}",
                  style: textstyle,
                ),
              ],
            ),
            Container(
              width: w * 0.8,
              margin: EdgeInsets.only(top: h * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 90,
                    width: 70,
                    child:  TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => FocusScope.of(context).nextFocus(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.blue),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none, counterText: ''),
                      textAlign: TextAlign.center,

                    ),
                    decoration: BoxDecoration(
                        color: theme().lightmC,
                        border: Border.all(color: Colors.white24, width: 3)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 90,
                    width: 70,
                    child:  TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => FocusScope.of(context).nextFocus(),

                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.blue),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none, counterText: ''),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        color: theme().lightmC,
                        border: Border.all(color: Colors.white24, width: 3)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 90,
                    width: 70,
                    child: TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => FocusScope.of(context).nextFocus(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.blue),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none, counterText: ''),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        color: theme().lightmC,
                        border: Border.all(color: Colors.white24, width: 3)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 90,
                    width: 70,
                    child:  TextFormField(
                      obscuringCharacter: '*',
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => FocusScope.of(context).nextFocus(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.blue),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none, counterText: ''),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        color: theme().lightmC,
                        border: Border.all(color: Colors.white24, width: 3)),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\n\nI didn\'t get the Code?",
                  style: TextStyle(
                      fontSize: w * 0.07, color: Colors.black, fontFamily: 'PopZ'),
                ),
                TextButton(onPressed: (){

                }, child:const Text("\n\n\n\n\nResend\n",style:  TextStyle(color: Colors.blue),)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: w*0.23,left: w*0.03,right: w*0.03),
              width: w*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:theme().mC,
              ),
              child: TextButton(
                onPressed: ()
                {
              //    Get.to(const UploadPhoto());
                },
                child: Text("Continue",style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'PopR'),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget otpBoxBuilder() {
    return Container(
      alignment: Alignment.center,
      height: 90,
      width: 70,
      child: const TextField(
        textInputAction: TextInputAction.next,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23, color: Colors.blue),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(border: InputBorder.none, counterText: ''),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
          color: theme().lightmC,
          border: Border.all(color: Colors.white24, width: 3)),
    );
  }
}
