import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/variables.dart';
import 'package:look/generated/l10n.dart';
import 'marital.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
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
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black45,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        EDUCATION = "Not Selected";
                        Get.to(() => const MaritalStatus());
                      },
                      child: Text(
                        "Skip    ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.05,
                            fontFamily: "PopZ",
                            color: Colors.black45),
                      ))
                ],
              ),
              Text(
                "What is Your Education?\n",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.05,
                    fontFamily: "PopZ",
                    color: Colors.black45),
              ),
              choices("None", w),
              choices("High School", w),
              choices("College", w),
              choices("Bachelor Degree", w),
              choices("Post Graduate", w),
              choices("Master", w),
              choices("Phd/Doctorate", w),
              choices("Post Doctorate", w),
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
          currentUser.value.education = txt;
        });
        currentUser.notifyListeners();
        Get.to(() => const MaritalStatus());
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: w * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.education != null &&
                      currentUser.value.education == txt
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black45),
        )),
      ),
    );
  }
}
