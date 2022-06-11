import 'dart:async';

import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

class RandomCalling extends StatefulWidget {
  const RandomCalling({
    Key? key,
  }) : super(key: key);

  @override
  _RandomCallingState createState() => _RandomCallingState();
}

class _RandomCallingState extends StateMVC<RandomCalling> {
  late CallsController _con;
  _RandomCallingState() : super(CallsController()) {
    _con = controller as CallsController;
  }
  late Timer _timer;
  bool userFound = false;
  String otherUserName = 'davie';
  @override
  void initState() {
    super.initState();
    otherUserName = '';
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          body: SingleChildScrollView(
            child: SizedBox(
              width: getHorizontal(context) * 1,
              height: getVertical(context) * 1,
              child: (otherUserName == '')
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).searching_for_user,
                              style: TextStyle(
                                fontSize: getHorizontal(context) * 0.05,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: getHorizontal(context) * 0.35,
                                height: getVertical(context) * 0.4,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      currentUser.value.image ?? noImage),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              _con.removeFromRandomCalls(context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: getVertical(context) * 0.1),
                                width: getHorizontal(context) * 0.5,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: theme().mC,
                                ),
                                child: Center(
                                    child: Text(
                                  S.of(context).discard,
                                  style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ))),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).make_video_call_with,
                              style: TextStyle(
                                fontSize: getHorizontal(context) * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' $otherUserName',
                              style: TextStyle(
                                fontSize: getHorizontal(context) * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              //TODO ==> Make a route to the calls page and create a new channel
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: getVertical(context) * 0.1),
                              width: getHorizontal(context) * 0.5,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: theme().mC,
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).join,
                                  style: TextStyle(
                                    fontSize: getHorizontal(context) * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).are_you_sure + "?"),
            content: Text(S.of(context).do_you_want_to_exit),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(S.of(context).no_text),
              ),
              TextButton(
                onPressed: () {
                  _con.removeFromRandomCalls(context);
                },
                child: Text(S.of(context).yes_text),
              ),
            ],
          ),
        )) ??
        false;
  }
}
