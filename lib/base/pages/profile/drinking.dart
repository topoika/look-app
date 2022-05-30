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
                S.of(context).drinking,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () => setUserSmoking(S.of(context).non_drinker, 1),
                  child: choices(
                      S.of(context).non_drinker,
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking ==
                                  S.of(context).non_drinker
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () =>
                      setUserSmoking(S.of(context).social_drinker, 1),
                  child: choices(
                      S.of(context).social_drinker,
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking ==
                                  S.of(context).social_drinker
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () =>
                      setUserSmoking(S.of(context).heavy_drinker, 1),
                  child: choices(
                      S.of(context).heavy_drinker,
                      currentUser.value.drinking != null &&
                              currentUser.value.drinking ==
                                  S.of(context).heavy_drinker
                          ? Colors.red
                          : Colors.black45)),
              Text(
                S.of(context).smoking,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () => setUserSmoking(S.of(context).non_smoker, 2),
                  child: choices(
                      S.of(context).non_smoker,
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking ==
                                  S.of(context).non_smoker
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () =>
                      setUserSmoking(S.of(context).lighter_smoker, 2),
                  child: choices(
                      S.of(context).lighter_smoker,
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking ==
                                  S.of(context).lighter_smoker
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () =>
                      setUserSmoking(S.of(context).heavy_smoker, 2),
                  child: choices(
                      S.of(context).heavy_smoker,
                      currentUser.value.smoking != null &&
                              currentUser.value.smoking ==
                                  S.of(context).heavy_smoker
                          ? Colors.red
                          : Colors.black45)),
              Text(
                S.of(context).eating,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black54),
              ),
              TextButton(
                  onPressed: () {
                    setUserSmoking(S.of(context).vegan, 3);
                  },
                  child: choices(
                      S.of(context).vegan,
                      currentUser.value.eating != null &&
                              currentUser.value.eating == S.of(context).vegan
                          ? Colors.red
                          : Colors.black45)),
              TextButton(
                  onPressed: () {
                    setUserSmoking(S.of(context).vegeterian, 3);
                  },
                  child: choices(
                      S.of(context).vegeterian,
                      currentUser.value.eating != null &&
                              currentUser.value.eating ==
                                  S.of(context).vegeterian
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
