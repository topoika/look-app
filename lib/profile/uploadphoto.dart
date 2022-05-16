import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/education.dart';

import '../base/models/user_model.dart';
import '../base/repositories/user_repository.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  late String _selectedDate = '';
  final TextEditingController _nameController = TextEditingController();
  late File _image;
  final formKey = GlobalKey<FormState>();
  bool selImage = false;
  int _groupValue = -1;
  final User _user = currentUser.value;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      (_selectedDate.isEmpty)
                          ? DATE = "Not Selected"
                          : DATE = _selectedDate;
                      (_nameController.text.isEmpty)
                          ? NAME = EMAIL
                          : NAME = _nameController.text;
                      (_groupValue == 0) ? GENDER = "Female" : GENDER = "Male";
                      Get.to(() => const Education());
                    },
                    child: const Text(
                      "\n\nSkip   ",
                      style: TextStyle(
                          fontFamily: 'PopS',
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
              ),
              Center(
                  child: Text(
                "Welcome to Look!",
                style: TextStyle(
                    fontSize: w * 0.04,
                    fontFamily: 'PopB',
                    fontWeight: FontWeight.bold),
              )),
              Center(
                  child: Text(
                "Improve your profile to get more attention!\n\n",
                style: TextStyle(fontSize: w * 0.04, fontFamily: 'PopM'),
              )),
              InkWell(
                onTap: () {
                  chooseFile();
                },
                child: (selImage == false)
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        width: w * 0.35,
                        height: h * 0.18,
                        decoration: BoxDecoration(
                          color: theme().lightmC,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          size: w * 0.26,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(
                        width: w * 0.35,
                        height: h * 0.18,
                        child: CircleAvatar(
                          backgroundImage: FileImage(_image),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 15, left: w * 0.13, right: w * 0.15, bottom: 15),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 3),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 5) {
                      return "Enter name of atleast 5 characters";
                    }
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: 0,
                      groupValue: _groupValue,
                      title: const Text("Man",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onChanged: (newValue) =>
                          setState(() => _groupValue = newValue as int),
                      activeColor: Colors.red,
                      selected: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: 1,
                      groupValue: _groupValue,
                      title: const Text(
                        "Women",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onChanged: (newValue) =>
                          setState(() => _groupValue = newValue as int),
                      activeColor: Colors.red,
                      selected: false,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 15, left: w * 0.13, right: w * 0.15, bottom: 15),
                child: DateTimePicker(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  dateHintText: "                   Enter Correct DOB  ",
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 8000)),
                  type: DateTimePickerType.date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2020),
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        _selectedDate = value;
                      });
                    }
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _selectedDate = value;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: w * 0.1, left: w * 0.03, right: w * 0.03),
                width: w * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme().mC,
                ),
                child: TextButton(
                  onPressed: () {
                    if (selImage == true) {
                      if (formKey.currentState!.validate()) {
                        _user.dob = _selectedDate;
                        _user.name = _nameController.text;
                        _user.gender = _groupValue == 0 ? "Female" : "Male";
                        PHOTO = _image;
                        registerUser(currentUser.value, _image).then((value) {
                          setState(() {
                            currentUser.value = value;
                            currentUser.notifyListeners();
                          });
                          Get.to(() => const Education());
                        });
                      }
                    } else {
                      final snackBar = SnackBar(
                        margin: const EdgeInsets.all(20),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Select an image to proceed!'),
                        backgroundColor: (Colors.redAccent),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "next",
                    style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'PopR'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future chooseFile() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 600,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 500);
    if (pickedFile != null) {
      setState(() {
        selImage = true;
        _image = File(pickedFile.path);
        PHOTO = _image;
      });
    } else {
      print('No image selected.');
    }
  }
}
