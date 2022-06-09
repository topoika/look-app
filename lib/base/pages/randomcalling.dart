import 'dart:async';

import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
                              "Searching for a User",
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
                                  "Discard",
                                  style: TextStyle(
                                      fontSize: getHorizontal(context) * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PopR'),
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
                              "Join Channel With ",
                              style: TextStyle(
                                  fontSize: getHorizontal(context) * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'PopR'),
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
                                  "Join",
                                  style: TextStyle(
                                      fontSize: getHorizontal(context) * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'PopR'),
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
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  _con.removeFromRandomCalls(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
