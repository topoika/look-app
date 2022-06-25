import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/profile/showprofile.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/pages/utils/decorations.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../generated/l10n.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

import '../utils/custom_containers.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final User _user = currentUser.value;
  final formKey = GlobalKey<FormState>();
  File? image = null;
  File? image2 = null;
  File? image3 = null;
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle(bool black) {
      return TextStyle(
          fontSize: getHorizontal(context) * 0.04,
          fontWeight: FontWeight.bold,
          color: black ? Colors.black : Colors.black54);
    }

    TextStyle _inputTextStyle() {
      return TextStyle(
          fontSize: getHorizontal(context) * 0.03,
          fontWeight: FontWeight.w700,
          color: Colors.black.withOpacity(.7));
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => chooseFile(1),
                      child: editProfileImageContainer(
                          context, image != null ? image : null, _user.image),
                    ),
                    GestureDetector(
                      onTap: () => chooseFile(2),
                      child: editProfileImageContainer(context,
                          image2 != null ? image2 : null, _user.image2),
                    ),
                    GestureDetector(
                      onTap: () => chooseFile(3),
                      child: editProfileImageContainer(context,
                          image3 != null ? image3 : null, _user.image3),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.02),
                  child:
                      buttonWidget(context, () {}, S.of(context).add_content),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: Text(
                    S.of(context).self_introduction,
                    style: _textStyle(true),
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: TextFormField(
                    maxLength: 500,
                    onSaved: (val) => currentUser.value.describe = val,
                    maxLines: 4,
                    initialValue: currentUser.value.describe ?? "",
                    style: _inputTextStyle(),
                    decoration: inputDecoration(
                      context,
                      S.of(context).describe_yourself,
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return S.of(context).type_atleast_ten_characters;
                      }
                      return null;
                    },
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: Text(
                    S.of(context).interests,
                    style: _textStyle(true),
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/ModifyInterests");
                    },
                    child: currentUser.value.interests != null
                        ? Container(
                            child: Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                children: currentUser.value.interests!
                                    .map((i) => choices1(i))
                                    .toList()),
                          )
                        : Container(
                            width: getHorizontal(context) * 1,
                            height: getVertical(context) * 0.07,
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              S.of(context).input_your_interests,
                              style: TextStyle(
                                  fontSize: getHorizontal(context) * 0.05,
                                  color: Colors.black54),
                            ),
                          ),
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: Text(
                    S.of(context).job_title,
                    style: _textStyle(true),
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: TextFormField(
                    onSaved: (val) => currentUser.value.job = val,
                    initialValue: currentUser.value.job ?? "",
                    style: _inputTextStyle(),
                    decoration: inputDecoration(
                      context,
                      S.of(context).enter_your_current_job,
                    ),
                    validator: (value) {
                      return value!.isEmpty || value.length < 3
                          ? S.of(context).please_enter_a_valid_job
                          : null;
                    },
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: Text(
                    S.of(context).lives_in,
                    style: _textStyle(true),
                  ),
                ),
                divider(1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.05,
                      vertical: getVertical(context) * 0.01),
                  child: TextFormField(
                    onSaved: (val) => currentUser.value.location = val,
                    initialValue: currentUser.value.location ?? "",
                    style: _inputTextStyle(),
                    decoration: inputDecoration(
                      context,
                      S.of(context).enter_current_location,
                    ),
                    validator: (value) {
                      return value!.isEmpty || value.length < 3
                          ? S.of(context).please_enter_a_valid_location
                          : null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.03,
                      vertical: getVertical(context) * 0.02),
                  child: buttonWidget(context, () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      currentUser.notifyListeners();
                      if (image != null) {
                        uploadProfilePicture(image, currentUser.value, 1);
                      } else {
                        updateUser(currentUser.value);
                      }
                      if (image2 != null) {
                        uploadProfilePicture(image2, currentUser.value, 2);
                      } else {
                        updateUser(currentUser.value);
                      }
                      if (image3 != null) {
                        uploadProfilePicture(image3, currentUser.value, 3);
                      } else {
                        updateUser(currentUser.value);
                      }
                      Navigator.pushReplacementNamed(context, "/MyProfile");
                    }
                  },
                      S.of(context).save_text +
                          " & " +
                          S.of(context).continue_text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget choices1(String txt) {
    return Container(
      // width: 150,
      margin: EdgeInsets.all(getHorizontal(context) * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.03, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        txt,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getHorizontal(context) * 0.03,
            color: Colors.black54),
      ),
    );
  }

  Future chooseFile(int option) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      switch (option) {
        case 1:
          setState(() {
            image = File(croppedFile.path);
          });
          break;
        case 2:
          setState(() {
            image2 = File(croppedFile.path);
          });
          break;
        case 3:
          setState(() {
            image3 = File(croppedFile.path);
          });
          break;
        default:
      }
    } else {}
  }
}
