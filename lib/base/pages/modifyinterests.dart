import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/utils/button.dart';

import '../../generated/l10n.dart';
import '../repositories/user_repository.dart';

class ModifyInterests extends StatefulWidget {
  const ModifyInterests({Key? key}) : super(key: key);

  @override
  _ModifyInterestsState createState() => _ModifyInterestsState();
}

class _ModifyInterestsState extends State<ModifyInterests> {
  @override
  Widget build(BuildContext context) {
    List<String> interstsList = [
      "outdoor activity",
      "walk with pets",
      "culture",
      "museum",
      "surfing",
      "camping",
      "cup of tea",
      "car",
      "picnic",
      "ESFJ",
      "environmental movement",
      "animation",
      "food tour",
      "gardening",
      "candid conversation",
      "fashion",
      "gamer",
      "football",
      "nature",
      "talk when bored",
      "cycling",
      "hiking",
      "startup",
      "consert",
      "world traveler",
      "K-pop",
      "brunch",
      "author",
      "running",
      "learn new things",
      "cooking",
      "mukbung (eating show)",
      "sports",
      "craft beer",
      "vegan",
      "baking",
      "festival",
      "language exchange",
      "walk",
      "DIY",
      "ENFJ",
      "cartoon cafe",
      "swimming",
      "INTJ",
      "make friend",
      "climbing",
      "ISTP",
      "PC room",
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
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
        title: Text(
          S.of(context).modify_interest,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.04,
              color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: interstsList.map((i) => choices1(i)).toList()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.03, vertical: 15),
              child: buttonWidget(context, () {
                final snackBar = SnackBar(
                  margin: const EdgeInsets.all(20),
                  behavior: SnackBarBehavior.floating,
                  content: const Text('your choices are saved'),
                  backgroundColor: (Colors.greenAccent),
                  onVisible: () {
                    setState(() {});
                  },
                  dismissDirection: DismissDirection.endToStart,
                  action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {},
                  ),
                );
                currentUser.notifyListeners();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
                setState(() {});
              }, S.of(context).continue_text),
            )
          ],
        ),
      ),
    );
  }

  Widget choices1(String txt) {
    return InkWell(
      onTap: () {
        currentUser.value.interests = currentUser.value.interests ?? [];
        if (currentUser.value.interests!.contains(txt)) {
          setState(() {
            currentUser.value.interests!.remove(txt);
            currentUser.notifyListeners();
          });
        } else {
          setState(() {
            currentUser.value.interests!.add(txt);
            currentUser.notifyListeners();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.all(getHorizontal(context) * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.03, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
              color: (currentUser.value.interests != null &&
                      currentUser.value.interests!.contains(txt))
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          txt,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.03,
              color: Colors.black54),
        ),
      ),
    );
  }
}
