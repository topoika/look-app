import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/profile/education.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  final TextEditingController _userName = TextEditingController();
  late File _image;
  final formKey = GlobalKey<FormState>();
  bool selImage = false;
  int _groupValue = -1;
  String _selectedDate = "";
  final User _user = currentUser.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: getVertical(context) * 0.04,
              horizontal: getHorizontal(context) * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    S.of(context).welcome_to_look,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(height: getVertical(context) * 0.03),
                Center(
                    child: Text(
                  S.of(context).improve_your_profile_to_get_more_attention,
                  textAlign: TextAlign.center,
                  textScaleFactor: getTextScale(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                SizedBox(height: getVertical(context) * 0.03),
                InkWell(
                  onTap: () {
                    chooseFile();
                  },
                  child: (selImage == false)
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          width: getHorizontal(context) * 0.35,
                          height: getVertical(context) * 0.18,
                          decoration: BoxDecoration(
                            color: theme().lightmC,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            size: getHorizontal(context) * 0.26,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(
                          width: getHorizontal(context) * 0.35,
                          height: getVertical(context) * 0.18,
                          child: CircleAvatar(
                            backgroundImage: FileImage(_image),
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 15,
                      left: getHorizontal(context) * 0.13,
                      right: getHorizontal(context) * 0.15,
                      bottom: 15),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    controller: _userName,
                    decoration: InputDecoration(
                      hintText: S.of(context).username,
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                      border: const UnderlineInputBorder(
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      top: 15,
                      left: getHorizontal(context) * 0.13,
                      right: getHorizontal(context) * 0.15,
                      bottom: 15),
                  child: DateTimePicker(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    dateHintText: _selectedDate == ""
                        ? S
                            .of(context)
                            .register_the_correct_birthday_to_enjoy_more_and_more_fun
                        : _selectedDate,
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
                    onSaved: (value) =>
                        currentUser.value.dob = value.toString(),
                  ),
                ),
                SizedBox(height: getVertical(context) * 0.08),
                buttonWidget(context, () {
                  if (selImage == true) {
                    if (formKey.currentState!.validate()) {
                      _user.dob = _selectedDate;
                      _user.name = _userName.text;
                      _user.gender = _groupValue == 0 ? "Female" : "Male";
                      registerUser(currentUser.value).then((value) {
                        setState(() {
                          currentUser.value = value;
                          uploadProfilePicture(_image, value, 1);
                          currentUser.notifyListeners();
                        });
                        Get.to(() => const Education());
                      });
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(getSnackBar("text"));
                  }
                }, S.of(context).next),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future chooseFile() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: 600,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 500);
    if (pickedFile != null) {
      setState(() {
        selImage = true;
        _image = File(pickedFile.path);
      });
    } else {}
  }
}

SnackBar getSnackBar(String text) {
  final snackBar = SnackBar(
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    content: Text(text),
    backgroundColor: (Colors.redAccent),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );
  return snackBar;
}
