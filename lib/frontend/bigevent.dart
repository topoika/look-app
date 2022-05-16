import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/frontend/bankaccountdeposit.dart';

class BigEvent extends StatefulWidget {

  final int points;

  const BigEvent({Key? key,required this.points}) : super(key: key);

  @override
  _BigEventState createState() => _BigEventState();
}

class _BigEventState extends State<BigEvent> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_ios)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Point Recharge',style: TextStyle(fontSize: w*0.065,fontFamily: 'PopB'),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('My Points   \n',style: TextStyle(fontSize: w*0.06,fontFamily: 'PopZ',fontWeight:FontWeight.bold),),
                      Text('${widget.points}p\n',style: TextStyle(color:Colors.red,fontFamily: 'PopZ',fontWeight:FontWeight.bold,fontSize: w*0.06),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(w,450),
                      box(w,900),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText(w,'\$4.9'),
                      bottomText(w,'\$9.1'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(w,1800),
                      box(w,4050),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText(w,'\$14.1'),
                      bottomText(w,'\$25.8'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(w,13500),
                      box(w,30000),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText(w,'\$74.1'),
                      bottomText(w,'\$150'),
                    ],
                  ),
                  // Center(
                  //   child: InkWell(
                  //     onTap: (){
                  //
                  //     },child: Container(
                  //     margin: EdgeInsets.only(top: h*0.16),
                  //     padding: const EdgeInsets.all(10),
                  //     width: w*0.5,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //           color: Colors.red,
                  //           width: 3
                  //       ),
                  //       borderRadius: BorderRadius.circular(40),
                  //     ),
                  //     child: InkWell(
                  //
                  //         child: Text("   Big Event   ",textAlign: TextAlign.center,style: TextStyle(color:Colors.red,fontWeight:FontWeight.bold,fontSize: w*0.05),)),
                  //   ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget box(double w,int txt)
  {
    return InkWell(
      onTap: (){
        Get.to(()=>BankAccountDeposit(points: widget.points, bigEventPoints: txt));
      },child: Container(
      margin: const EdgeInsets.only(bottom: 5,top: 20),
      width: w*0.24,
      height: MediaQuery.of(context).size.height*0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,

        ),
      ),
      child: Center(child: Text('${txt}P',style: TextStyle(color:Colors.black87,fontWeight:FontWeight.bold,fontSize: w*0.06),))
      ,
    ),
    );
  }
  Widget bottomText(double w,String txt)
  {
    return SizedBox(
      width: w*0.2,
      child: Text('  $txt',style: TextStyle(color:Colors.black54,fontWeight:FontWeight.bold,fontSize: w*0.06),)
      ,
    );
  }
}
