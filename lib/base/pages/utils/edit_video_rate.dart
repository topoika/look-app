import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/user_controller.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'button.dart';
import 'snackbar.dart';

class EditVideoRate extends StatefulWidget {
  EditVideoRate({Key? key}) : super(key: key);

  @override
  _EditVideoRateState createState() => _EditVideoRateState();
}

class _EditVideoRateState extends StateMVC<EditVideoRate> {
  late UserController _con;
  _EditVideoRateState() : super(UserController()) {
    _con = controller as UserController;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.03),
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.04, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _con.phoneFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  S.of(context).edit_your_video_and_sms_rate,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: getHorizontal(context) * 0.04,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: currentUser.value.videoRate.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (val) =>
                      currentUser.value.videoRate = int.parse(val),
                  decoration: InputDecoration(
                    hintText: S.of(context).video_rate,
                    labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                    contentPadding: const EdgeInsets.all(12),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textAlign: TextAlign.center,
                  initialValue: currentUser.value.smsRate.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (val) =>
                      currentUser.value.smsRate = int.parse(val),
                  decoration: InputDecoration(
                    hintText: S.of(context).sms_rate,
                    labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                    contentPadding: const EdgeInsets.all(12),
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.2))),
                  ),
                ),
                buttonWidget(context, () {
                  if (_con.phoneFormKey.currentState!.validate()) {
                    _con.phoneFormKey.currentState!.save();
                    currentUser.notifyListeners();
                    FocusManager.instance.primaryFocus?.unfocus();
                    _con.updateUserVideoRate(currentUser.value);
                    Navigator.pop(context);
                    showSnackBar(context, "Details updated succesfully", false);
                  } else {
                    // Navigator.pop(context);
                  }
                }, S.of(context).continue_text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
