import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:look/base/repositories/user_repository.dart';
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
  VideoCall? videoCall = null;
  @override
  void initState() {
    _con.createRandomCall(context);
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _con.getRandomCall(context).then((value) {
        value.id != null ? setState(() => videoCall = value) : log("Not found");
      });
    });
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
          body: Container(
            height: double.infinity,
            padding: EdgeInsets.only(
                left: getHorizontal(context) * 0.04,
                top: 20,
                right: getHorizontal(context) * 0.04,
                bottom: 80),
            width: getHorizontal(context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 18, 0, 26),
                  Color.fromARGB(255, 41, 2, 58),
                  Color.fromARGB(255, 57, 7, 68),
                  Color.fromARGB(255, 125, 3, 153),
                  Color.fromARGB(255, 134, 3, 163),
                  Color.fromARGB(255, 150, 2, 184),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SizedBox(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: getHorizontal(context),
                  child: GestureDetector(
                    onTap: () => _onWillPop(),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                  ),
                ),
                Text(
                  "Searching for new Friends...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getHorizontal(context) * 0.06,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: videoCall != null
                          ? () => Navigator.pushReplacementNamed(
                              context, "/CallPage",
                              arguments: videoCall)
                          : () => log("hello"),
                      child: Stack(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.all(getHorizontal(context) * 0.24),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(loading),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white.withOpacity(.8),
                                ),
                              ),
                              child: CircleAvatar(
                                radius: getHorizontal(context) * 0.11,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    currentUser.value.image ?? noImage),
                                child: videoCall != null
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: getHorizontal(context) * 0.1,
                                      )
                                    : SizedBox(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "Go meet people around the world",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getHorizontal(context) * 0.05,
                  ),
                ),
              ],
            )),
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
                  _timer.cancel();
                },
                child: Text(S.of(context).yes_text),
              ),
            ],
          ),
        )) ??
        true;
  }
}
