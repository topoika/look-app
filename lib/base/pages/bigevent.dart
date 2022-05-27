import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/bankaccountdeposit.dart';

import '../Helper/dimension.dart';

class BigEvent extends StatefulWidget {
  const BigEvent({Key? key}) : super(key: key);

  @override
  _BigEventState createState() => _BigEventState();
}

class _BigEventState extends State<BigEvent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Point Recharge',
                    style: TextStyle(
                        fontSize: getHorizontal(context) * 0.065,
                        fontFamily: 'PopB'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Points   \n',
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.06,
                            fontFamily: 'PopZ',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentUser.value.points.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'PopZ',
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.06),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(450),
                      box(900),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$4.9'),
                      bottomText('\$9.1'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(1800),
                      box(4050),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$14.1'),
                      bottomText('\$25.8'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(13500),
                      box(30000),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$74.1'),
                      bottomText('\$150'),
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

  Widget box(int txt) {
    return InkWell(
      onTap: () {
        Get.to(() => BankAccountDeposit(bigEventPoints: txt));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 20),
        width: getHorizontal(context) * 0.24,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        child: Center(
            child: Text(
          '${txt}P',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.06),
        )),
      ),
    );
  }

  Widget bottomText(String txt) {
    return SizedBox(
      width: getHorizontal(context) * 0.2,
      child: Text(
        '  $txt',
        style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: getHorizontal(context) * 0.06),
      ),
    );
  }
}
