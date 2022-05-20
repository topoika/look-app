import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/profile/personality.dart';

import '../../../generated/l10n.dart';

class Drinking extends StatefulWidget {
  const Drinking({Key? key}) : super(key: key);

  @override
  _DrinkingState createState() => _DrinkingState();
}

class _DrinkingState extends State<Drinking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const Personality());
                    },
                    child: Text(
                      S.of(context).skip,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getHorizontal(context) * 0.05,
                          color: Colors.black45),
                    ),
                  )
                ],
              ),
              Text(
                "Drinking",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () => setUserSmoking("Non Drinker", 1),
                  child: choices(
                      "Non Drinker",
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking == "Non Drinker"
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () => setUserSmoking("Social Drinker", 1),
                  child: choices(
                      "Social Drinker",
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking == "Social Drinker"
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () => setUserSmoking("Heavy Drinker", 1),
                  child: choices(
                      "Heavy Drinker",
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking == "Heavy Drinker"
                          ? Colors.red
                          : Colors.black45)),
              Text(
                "\nSmoking",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    fontFamily: "PopZ",
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () => setUserSmoking("Non Smoker", 2),
                  child: choices(
                      "Non Smoker",
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking == "Non Smoker"
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () => setUserSmoking("Lighter Smoker", 2),
                  child: choices(
                      "Lighter Smoker",
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking == "Lighter Smoker"
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () => setUserSmoking("Heavy Smoker", 2),
                  child: choices(
                      "Heavy Smoker",
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking == "Heavy Smoker"
                          ? Colors.red
                          : Colors.black45)),
              Text(
                "\nEating",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () {
                    setUserSmoking("Vegan", 3);
                  },
                  child: choices(
                      "Vegan",
                      currentUser.value.eating != null &&
                              currentUser.value.eating == "Vegan"
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () {
                    setUserSmoking("Vegetrian", 3);
                  },
                  child: choices(
                      "Vegetrian",
                      currentUser.value.eating != null &&
                              currentUser.value.eating == "Vegetrian"
                          ? Colors.red
                          : Colors.black45)),
            ],
          ),
        ),
      ),
    );
  }

  void setUserSmoking(String txt, int section) {
    setState(() {
      switch (section) {
        case 1:
          currentUser.value.drinking = txt;
          break;
        case 2:
          currentUser.value.smoking = txt;
          break;
        case 3:
          currentUser.value.eating = txt;
          break;
        default:
      }
    });
    currentUser.notifyListeners();
  }

  Widget choices(String txt, Color clr) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: getHorizontal(context) * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: clr),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black45),
        ),
      ),
    );
  }
}
