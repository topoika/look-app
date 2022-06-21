import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/generated/l10n.dart';

import 'drinking.dart';
import '../../repositories/user_repository.dart';

class MaritalStatus extends StatefulWidget {
  const MaritalStatus({Key? key}) : super(key: key);

  @override
  _MaritalStatusState createState() => _MaritalStatusState();
}

class _MaritalStatusState extends State<MaritalStatus> {
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.black45,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentUser.value.marital = "";
                      });
                      currentUser.notifyListeners();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Drinking()));
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
                S.of(context).martitual_status,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black),
              ),
              SizedBox(height: getHorizontal(context) * 0.03),
              choices(S.of(context).single),
              choices(S.of(context).single_mom),
              choices(S.of(context).single_dad),
              choices(S.of(context).in_a_relationship),
              choices(S.of(context).married),
              choices(S.of(context).separated),
              choices(S.of(context).devorced),
              choices(S.of(context).widowed),
            ],
          ),
        ),
      ),
    );
  }

  Widget choices(String txt) {
    return InkWell(
      onTap: () {
        setState(() {
          currentUser.value.marital = txt;
        });
        currentUser.notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Drinking()));
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: getHorizontal(context) * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.marital != null &&
                      currentUser.value.marital == txt
                  ? Colors.red
                  : Colors.black45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          txt,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'PopR',
              fontSize: 15,
              color: Colors.black45),
        )),
      ),
    );
  }
}
