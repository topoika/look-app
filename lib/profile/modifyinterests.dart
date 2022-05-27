import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';

import 'package:look/constant/variables.dart';

class ModifyInterests extends StatefulWidget {
  const ModifyInterests({Key? key}) : super(key: key);

  @override
  _ModifyInterestsState createState() => _ModifyInterestsState();
}

class _ModifyInterestsState extends State<ModifyInterests> {
  List myInterests = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ModifyINTERESTS = myInterests;
                        final snackBar = SnackBar(
                          margin: const EdgeInsets.all(20),
                          behavior: SnackBarBehavior.floating,
                          content: const Text('your choices are saved'),
                          backgroundColor: (Colors.redAccent),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "\n              Modify Interests",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getHorizontal(context) * 0.05,
                          fontFamily: "PopZ",
                          color: Colors.black87),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '( ${myInterests.length}/5 )     ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: getHorizontal(context) * 0.05),
                  ),
                ),
                Row(
                  children: [
                    choices1("outdoor activity"),
                    choices1("walk with pets "),
                  ],
                ),
                Row(
                  children: [
                    choices1("culture"),
                    choices1("museum"),
                    choices1("surfing"),
                    choices1("camping"),
                  ],
                ),
                Row(
                  children: [
                    choices1("cup of tea"),
                    choices1("  car  "),
                    choices1(" picnic "),
                    choices1(" ESFJ "),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choices1("walking with neighberhood"),
                    choices1("sweet dessert"),
                  ],
                ),
                Row(
                  children: [
                    choices1("cup of coffee"),
                    choices1("cat lover"),
                    choices1("instagram"),
                  ],
                ),
                Row(
                  children: [
                    choices1(" INFJ "),
                    choices1("environmental movement"),
                  ],
                ),
                Row(
                  children: [
                    choices1("animation"),
                    choices1("food tour"),
                    choices1("gardening"),
                  ],
                ),
                Row(
                  children: [
                    choices1("candid conversation"),
                    choices1("fashion"),
                    choices1("gamer"),
                  ],
                ),
                Row(
                  children: [
                    choices1("football"),
                    choices1("nature"),
                    choices1("talk when bored"),
                  ],
                ),
                Row(
                  children: [
                    choices1("cycling"),
                    choices1("hiking"),
                    choices1("startup"),
                    choices1("consert"),
                  ],
                ),
                Row(
                  children: [
                    choices1("world traveler"),
                    choices1("K-pop"),
                    choices1("brunch"),
                  ],
                ),
                Row(
                  children: [
                    choices1("author"),
                    choices1("running"),
                    choices1("learn new things"),
                  ],
                ),
                Row(
                  children: [
                    choices1("cooking"),
                    choices1("mukbung (eating show)"),
                  ],
                ),
                Row(
                  children: [
                    choices1("sports"),
                    choices1("craft beer"),
                    choices1("vegan"),
                    choices1(" ESTJ "),
                  ],
                ),
                Row(
                  children: [
                    choices1("baking"),
                    choices1("festival"),
                    choices1("language exchange"),
                  ],
                ),
                Row(
                  children: [
                    choices1("walk"),
                    choices1(" DIY "),
                    choices1(" ENFJ "),
                    choices1("cartoon cafe"),
                  ],
                ),
                Row(
                  children: [
                    choices1("swimming"),
                    choices1(" INTJ "),
                    choices1("make friend"),
                  ],
                ),
                Row(
                  children: [
                    choices1("climbing"),
                    choices1(" ISTP "),
                    choices1("PC room"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget choices1(String txt) {
    double h = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (myInterests.length < 5) {
          if (myInterests.contains(txt)) {
            setState(() {
              myInterests.remove(txt);
            });
          } else {
            setState(() {
              myInterests.add(txt);
            });
          }
        } else {
          if (myInterests.contains(txt)) {
            setState(() {
              myInterests.remove(txt);
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(
            (txt == "camping") ? 1 : getHorizontal(context) * 0.01),
        padding: EdgeInsets.only(
            top: 4,
            bottom: h * 0.004,
            left: (txt == "camping") ? 0 : 7,
            right: (txt == "camping") ? 0 : 7),
        decoration: BoxDecoration(
          border: Border.all(
              color: (myInterests.contains(txt)) ? Colors.red : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          "  $txt  ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.035,
              color: Colors.black54),
        )),
      ),
    );
  }
}
