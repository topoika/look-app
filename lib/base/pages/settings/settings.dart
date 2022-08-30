import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/settings_controller.dart';
import 'package:look/base/pages/utils/warning_dailog.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../env.dart';
import '../../models/language_model.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends StateMVC<SettingsPage> {
  late SettingController _con;
  _SettingsPageState() : super(SettingController()) {
    _con = controller as SettingController;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: Text(S.of(context).settings_text),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
              horizontal: getHorizontal(context) * 0.04, vertical: 10),
          children: [
            Text(
              S.of(context).social_discovery_range_setting,
              style: Theme.of(context).textTheme.headline6,
            ),
            spacing(getVertical(context) * 0.015),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.03,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: getHorizontal(context) * 0.08,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: getHorizontal(context) * 0.6,
                        child: Text(
                          currentUser.value.location ??
                              S.of(context).my_current_location,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.black45,
                                    fontSize: getHorizontal(context) * 0.04,
                                  ),
                        ),
                      ),
                      spacing(getVertical(context) * 0.009),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? GOOGLE_API_KEY
                                      : "YOUR IOS API KEY",
                                  onPlacePicked: (result) {
                                    setState(() {
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
                          });
                          _con.updateUser(context, currentUser.value);
                          currentUser.notifyListeners();
                        },
                        child: Text(
                          S.of(context).new_loction_addition,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.blueAccent,
                                    fontSize: getHorizontal(context) * 0.042,
                                  ),
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.blueAccent,
                    size: getHorizontal(context) * 0.08,
                  ),
                ],
              ),
            ),
            spacing(getVertical(context) * 0.01),
            Text(
              S.of(context).change_your_location_and_meet_other_local_people,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black45,
                    fontSize: getHorizontal(context) * 0.04,
                  ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: getVertical(context) * 0.015),
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.03,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S.of(context).global_mode,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black45,
                          fontSize: getHorizontal(context) * 0.045,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Switch(
                      activeColor: Colors.red,
                      value: currentUser.value.globalMode!,
                      onChanged: (value) {
                        setState(() => currentUser.value.globalMode = value);
                        _con.updateUser(context, currentUser.value);
                        currentUser.notifyListeners();
                      })
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: getVertical(context) * 0.015),
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.03,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    S.of(context).video_call,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black45,
                          fontSize: getHorizontal(context) * 0.045,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  Switch(
                      activeColor: Colors.red,
                      value: currentUser.value.videoCallsAvailable!,
                      onChanged: (value) {
                        value == true
                            ? showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: WarningDialog()))
                            : null;
                        setState(() =>
                            currentUser.value.videoCallsAvailable = value);
                        _con.updateUser(context, currentUser.value);
                        currentUser.notifyListeners();
                      })
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: getVertical(context) * 0.015),
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getHorizontal(context) * 0.03, vertical: 8),
                    child: Text(
                      S.of(context).language_text,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.black45,
                            fontSize: getHorizontal(context) * 0.045,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: languages.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var lang = languages[index];
                        return InkWell(
                          onTap: () {
                            setting.value.mobileLanguage.value =
                                Locale(lang.code ?? "en");
                            _con.updateSettins();
                            setting.notifyListeners();
                          },
                          child: Column(
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.black38,
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getHorizontal(context) * 0.055,
                                    vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      lang.name ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            color: Colors.black54,
                                            fontSize:
                                                getHorizontal(context) * 0.035,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    lang.code ==
                                            setting.value.mobileLanguage.value
                                                .languageCode
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size:
                                                getHorizontal(context) * 0.045,
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: getVertical(context) * 0.015),
              padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.03,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).max_distance_of_partners,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black45,
                              fontSize: getHorizontal(context) * 0.045,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      Text(
                        "${setting.value.distance.toString()}Km",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                              fontSize: getHorizontal(context) * 0.045,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  spacing(getVertical(context) * 0.013),
                  Slider(
                      value: setting.value.distance!.toDouble(),
                      activeColor: Colors.red,
                      max: 100,
                      onChanged: (value) {
                        setState(() => setting.value.distance = value.toInt());
                        _con.updateSettins();
                        setting.notifyListeners();
                      }),
                  spacing(getVertical(context) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).age_range_of_partners,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black45,
                              fontSize: getHorizontal(context) * 0.045,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      Text(
                        "${setting.value.startAge.toString()} ~ ${setting.value.endAge.toString()}",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black,
                              fontSize: getHorizontal(context) * 0.045,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  spacing(getVertical(context) * 0.013),
                  RangeSlider(
                    values: RangeValues(setting.value.startAge!.toDouble(),
                        setting.value.endAge!.toDouble()),
                    activeColor: Colors.red,
                    max: 60,
                    min: 18,
                    onChanged: (RangeValues values) {
                      setState(() {
                        setting.value.startAge = values.start.toInt();
                        setting.value.endAge = values.end.toInt();
                      });
                      _con.updateSettins();
                      setting.notifyListeners();
                    },
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/BlockList"),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: getVertical(context) * 0.015),
                padding: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.03,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: Colors.black87,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      S.of(context).block_list,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.black45,
                            fontSize: getHorizontal(context) * 0.045,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: getVertical(context) * 0.015),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: getHorizontal(context) * 0.03,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  width: 1,
                  color: Colors.black87,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    S.of(context).push_notifications,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black45,
                          fontSize: getHorizontal(context) * 0.045,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  spacing(getVertical(context) * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).new_match,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black45,
                              fontSize: getHorizontal(context) * 0.035,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(
                        height: getVertical(context) * 0.02,
                        child: Switch(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.red,
                          value: setting.value.newMatch!,
                          onChanged: (value) {
                            setState(() => setting.value.newMatch = value);
                            _con.updateSettins();
                            setting.notifyListeners();
                          },
                        ),
                      )
                    ],
                  ),
                  spacing(getVertical(context) * 0.022),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        S.of(context).message_text,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.black45,
                              fontSize: getHorizontal(context) * 0.035,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(
                        height: getVertical(context) * 0.02,
                        child: Switch(
                            activeColor: Colors.red,
                            value: setting.value.messages!,
                            onChanged: (value) {
                              setState(() => setting.value.messages = value);
                              _con.updateSettins();
                              setting.notifyListeners();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget spacing(double height) => SizedBox(
      height: height,
    );
