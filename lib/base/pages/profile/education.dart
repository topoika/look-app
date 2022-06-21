import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/generated/l10n.dart';
import '../utils/titles.dart';
import 'marital.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
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
                      color: Colors.black45,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MaritalStatus()));
                      },
                      child: skiptText(context))
                ],
              ),
              Text(
                S.of(context).what_is_your_education,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black45),
              ),
              choices(S.of(context).none),
              choices(S.of(context).high_school),
              choices(S.of(context).college),
              choices(S.of(context).bachelor_degree),
              choices(S.of(context).post_graduate),
              choices(S.of(context).masters),
              choices(S.of(context).phd),
              choices(S.of(context).post_doctorate),
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
          currentUser.value.education = txt;
        });
        currentUser.notifyListeners();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MaritalStatus()));
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        width: getHorizontal(context) * 0.8,
        decoration: BoxDecoration(
          border: Border.all(
              color: currentUser.value.education != null &&
                      currentUser.value.education == txt
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
