import 'package:flutter/material.dart';
import 'package:look/base/pages/utils/titles.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/profile/location.dart';

import '../../../generated/l10n.dart';
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GetUserLocation()));
                      },
                      child: Text(
                        S.of(context).skip,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.05,
                            color: Colors.black45),
                      ))
                ],
              ),
              title(context, S.of(context).personality),
              choices(S.of(context).funny),
              choices(S.of(context).romantic),
              choices(S.of(context).open_minded),
              title(context, S.of(context).interests),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).dancing),
                  choices1(S.of(context).hiking),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).singing),
                  choices1(S.of(context).reading),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).fishing),
                  choices1(S.of(context).travel),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).fitness),
                  choices1(S.of(context).photography),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).music),
                  choices1(S.of(context).movie),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choices1(S.of(context).camping),
                  choices1(S.of(context).sports),
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
      onTap: () {
        setState(() => currentUser.value.personality = txt);
        currentUser.notifyListeners();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: getHorizontal(context) * 0.82,
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
        currentUser.notifyListeners();
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
