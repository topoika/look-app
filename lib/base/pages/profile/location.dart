import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/pages/utils/titles.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/liveusers.dart';

import '../../../env.dart';
import '../../../generated/l10n.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  final GlobalKey<FormState> _locationForm = GlobalKey();
  TextEditingController locationCntl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black45,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                _locationForm.currentState!.save();
                try {
                  _locationForm.currentState!.save();
                  updateUser(currentUser.value);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LiveUsers()));
                } catch (e) {
                  showSnackBar(
                      context, S.of(context).check_internet_connection, true);
                }
              },
              child: skiptText(context))
        ],
      ),
      body: Form(
        key: _locationForm,
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: getHorizontal(context) * 0.04, vertical: 10),
          children: <Widget>[
            Container(
              color: const Color(0xffeceeef),
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: getHorizontal(context) * 0.006),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: getHorizontal(context) * 0.065,
                      ),
                      Text(
                        S.of(context).lives_in,
                        style:
                            TextStyle(fontSize: getHorizontal(context) * 0.055),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  TextFormField(
                    onSaved: (value) => currentUser.value.location = value,
                    controller: locationCntl,
                    maxLines: 2,
                    minLines: 1,
                    style: TextStyle(
                        fontSize: getHorizontal(context) * 0.04,
                        color: Colors.black),
                    decoration: basicDecoration(
                      context,
                      S.of(context).enter_current_location,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            apiKey: Platform.isAndroid
                                ? GOOGLE_API_KEY
                                : "YOUR IOS API KEY",
                            onPlacePicked: (result) {
                              setState(() {
                                locationCntl.text = result.formattedAddress!;
                                currentUser.value.location =
                                    result.formattedAddress;
                              });
                              currentUser.notifyListeners();
                              print(result.adrAddress);
                              Navigator.of(context).pop();
                            },
                            initialPosition: LatLng(0, 0),
                            useCurrentLocation: true,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: getHorizontal(context),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        S.of(context).get_current_location,
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.05,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Expanded(
              child: TextFormField(
                onSaved: (value) => currentUser.value.job = value,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  fontSize: getHorizontal(context) * 0.038,
                  fontWeight: FontWeight.bold,
                ),
                decoration:
                    basicDecoration(context, S.of(context).input_your_job),
              ),
            ),
            SizedBox(height: getVertical(context) * 0.02),
            TextFormField(
              onSaved: (value) => currentUser.value.describe = value,
              maxLength: 250,
              maxLines: 4,
              minLines: 1,
              decoration: basicDecoration(
                context,
                S.of(context).describe_yourself,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration basicDecoration(BuildContext context, String hint) =>
    InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Colors.black54,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Colors.black87,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Colors.black87,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: Colors.black87,
        ),
      ),
      hintText: "$hint ...",
      hintStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w600,
        fontSize: getHorizontal(context) * 0.037,
      ),
    );
