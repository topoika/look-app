import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/modifyinterests.dart';

import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final User _user = currentUser.value;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: getHorizontal(context) * 1,
                  height: getVertical(context) * 0.35,
                  child: Image.network(
                    _user.image ?? noImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.red,
                        size: 25,
                      )),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: getVertical(context) * 0.36),
                  width: getHorizontal(context) * 1,
                  alignment: Alignment.topCenter,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          _user.name ?? "",
                          style: TextStyle(
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        )),
                        Center(
                            child: Text(
                          _user.country ?? "",
                          style: TextStyle(
                              fontSize: getHorizontal(context) * 0.045,
                              color: Colors.black54),
                        )),
                        Text(
                          "   Self-Introduction",
                          style: TextStyle(
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        ),
                        Container(
                          width: getHorizontal(context) * 1,
                          height: getVertical(context) * 0.2,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black54),
                              top:
                                  BorderSide(width: 2.0, color: Colors.black54),
                            ),
                          ),
                          child: TextFormField(
                            maxLength: 500,
                            controller: _introductionController,
                            maxLines: 8,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: getHorizontal(context) * 0.04),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 10, right: 10),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 10) {
                                return 'Type atleast 10+ characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          "\n   Interests",
                          style: TextStyle(
                              fontFamily: 'PopB',
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const ModifyInterests());
                          },
                          child: Container(
                            width: getHorizontal(context) * 1,
                            height: getVertical(context) * 0.07,
                            padding: const EdgeInsets.only(top: 7),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 2.0, color: Colors.black54),
                                top: BorderSide(
                                    width: 2.0, color: Colors.black54),
                              ),
                            ),
                            child: Text(
                              "   Input your interests",
                              style: TextStyle(
                                  fontFamily: 'PopB',
                                  fontSize: getHorizontal(context) * 0.05,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                        Text(
                          "\n   Job title",
                          style: TextStyle(
                              fontFamily: 'PopB',
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        ),
                        Container(
                          width: getHorizontal(context) * 1,
                          height: getVertical(context) * 0.1,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black54),
                              top:
                                  BorderSide(width: 2.0, color: Colors.black54),
                            ),
                          ),
                          child: TextFormField(
                            controller: _jobController,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "PopB",
                                fontSize: getHorizontal(context) * 0.04),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              hintText: "Enter your current job",
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 10, right: 10),
                            ),
                            //  onChanged: _onChanged,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Job title cannot be less than 5';
                              }
                              return null;
                            },
                          ),
                        ),
                        Text(
                          "\n   Lives in",
                          style: TextStyle(
                              fontFamily: 'PopB',
                              fontSize: getHorizontal(context) * 0.055,
                              color: Colors.black),
                        ),
                        Container(
                          width: getHorizontal(context) * 1,
                          height: getVertical(context) * 0.1,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 2.0, color: Colors.black54),
                              top:
                                  BorderSide(width: 2.0, color: Colors.black54),
                            ),
                          ),
                          child: TextFormField(
                            controller: _locationController,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "PopB",
                                fontSize: getHorizontal(context) * 0.04),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              hintText: "Enter your current job",
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 10, right: 10),
                            ),
                            //  onChanged: _onChanged,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Job title cannot be less than 5';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            button("Save & Update"),
          ],
        )),
      ),
    );
  }

  Widget button(String txt) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          top: getHorizontal(context) * 0.07,
          left: getHorizontal(context) * 0.04,
          right: getHorizontal(context) * 0.04,
          bottom: 20),
      width: getHorizontal(context) * 0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme().mC,
      ),
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            //TODO
            //update current user

            Navigator.of(context).pop();
          }
        },
        child: Text(
          txt,
          style: TextStyle(
            fontSize: getHorizontal(context) * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
