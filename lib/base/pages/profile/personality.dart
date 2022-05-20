import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/profile/location.dart';

import '../../Helper/dimension.dart';

class Personality extends StatefulWidget {
  const Personality({Key? key}) : super(key: key);

  @override
  _PersonalityState createState() => _PersonalityState();
}

class _PersonalityState extends State<Personality> {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const GetUserLocation());
                      },
                      child: Text(
                        "Skip    ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.05,
                            fontFamily: "PopZ",
                            color: Colors.black45),
                      ))
                ],
              ),
              Text(
                "Personality\n",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    fontFamily: "PopZ",
                    color: Colors.black45),
              ),
              choices("Funny"),
              choices("Romantic"),
              choices("Open-minded"),
              Text(
                "\nInterests\n",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    fontFamily: "PopZ",
                    color: Colors.black45),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Dancing"),
                  choices1("Hiking"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Singing"),
                  choices1("Reading"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Fishing"),
                  choices1("Travel"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Fitness"),
                  choices1("Photography"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Music"),
                  choices1("Movie"),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1("Camping"),
                  choices1("Sports"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget choices(String txt) {
    return InkWell(
      onTap: () => setState(() => currentUser.value.personality = txt),
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: getHorizontal(context) * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.personality != null &&
                      currentUser.value.personality == txt
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black45),
        )),
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
          });
        } else {
          setState(() {
            currentUser.value.interests!.add(txt);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(7),
        width: getHorizontal(context) * 0.4,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.interests != null &&
                      currentUser.value.interests!.contains(txt)
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black45),
        )),
      ),
    );
  }
}
