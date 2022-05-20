import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/constant/variables.dart';
import 'package:look/generated/l10n.dart';

import 'drinking.dart';
import '../../repositories/user_repository.dart';

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
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.black45,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentUser.value.marital = "";
                      });
                      currentUser.notifyListeners();
                      Get.to(() => const Drinking());
                    },
                    child: Text(
                      S.of(context).skip,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.05,
                          color: Colors.black45),
                    ),
                  )
                ],
              ),
              Text(
                S.of(context).martitual_status,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.05,
                    color: Colors.black),
              ),
              SizedBox(height: getHorizontal(context) * 0.03),
              choices(S.of(context).single, w),
              choices(S.of(context).single_mom, w),
              choices(S.of(context).single_dad, w),
              choices(S.of(context).in_a_relationship, w),
              choices(S.of(context).married, w),
              choices(S.of(context).separated, w),
              choices(S.of(context).devorced, w),
              choices(S.of(context).widowed, w),
            ],
          ),
        ),
      ),
    );
  }

  Widget choices(String txt, double w) {
    return InkWell(
      onTap: () {
        setState(() {
          currentUser.value.marital = txt;
        });
        currentUser.notifyListeners();
        Get.to(() => const Drinking());
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: w * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.marital != null &&
                      currentUser.value.marital == txt
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'PopR',
              fontSize: 15,
              color: Colors.black45),
        )),
      ),
    );
  }
}
