import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/pages/utils/titles.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/liveusers.dart';

import '../../../generated/l10n.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  final GlobalKey<FormState> _locationForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _locationForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                        _locationForm.currentState!.save();
                        try {
                          _locationForm.currentState!.save();
                          updateUser(currentUser.value);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LiveUsers()));
                        } catch (e) {
                          showSnackBar(context,
                              S.of(context).check_internet_connection, true);
                        }
                      },
                      child: skiptText(context))
                ],
              ),
              Container(
                width: getHorizontal(context) * 0.9,
                height: getVertical(context) * 0.38,
                color: const Color(0xffeceeef),
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: getHorizontal(context) * 0.1,
                          ),
                          Text(
                            S.of(context).lives_in,
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.055),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextFormField(
                        onSaved: (value) => currentUser.value.location = value,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.05,
                            color: Colors.black54),
                        decoration: InputDecoration(
                          hintText: S.of(context).enter_current_location,
                          hintStyle: TextStyle(
                              fontSize: getHorizontal(context) * 0.04,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          margin:
                              EdgeInsets.only(top: getVertical(context) * 0.06),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: theme().mC,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            S.of(context).get_current_location,
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.05,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getHorizontal(context) * 0.1,
                    right: getHorizontal(context) * 0.1,
                    top: getVertical(context) * 0.1,
                    bottom: getVertical(context) * 0.06),
                child: TextFormField(
                  onSaved: (value) => currentUser.value.job = value,
                  decoration: InputDecoration(
                    hintText: S.of(context).input_your_job,
                    hintStyle: TextStyle(
                        fontSize: getHorizontal(context) * 0.05,
                        color: Colors.black12),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: getHorizontal(context) * 0.1,
                    right: getHorizontal(context) * 0.1),
                child: TextFormField(
                  onSaved: (value) => currentUser.value.describe = value,
                  maxLength: 250,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: S.of(context).describe_yourself,
                    hintStyle: TextStyle(
                        fontSize: getHorizontal(context) * 0.05,
                        color: Colors.black12),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
