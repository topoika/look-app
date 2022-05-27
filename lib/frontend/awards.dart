import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/recharge.dart';

class Award extends StatefulWidget {
  final int coins;
  final String uid;
  final int awardNo;
  final bool checkDate;
  final Timestamp t1;
  const Award(
      {Key? key,
      required this.coins,
      required this.uid,
      required this.awardNo,
      required this.t1,
      required this.checkDate})
      : super(key: key);

  @override
  _AwardState createState() => _AwardState();
}

class _AwardState extends State<Award> {
  bool loading = true;
  var finalDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comparingDates();
  }

  void comparingDates() async {
    try {
      var reslt = await FirebaseFirestore.instance
          .collection('award')
          .doc(widget.uid)
          .get();
      if (reslt.data() != null) {
        late Timestamp time2;
        time2 = reslt.data()!['time'];
        DateTime t2 = time2.toDate();
        if (widget.checkDate == true) {
          late Timestamp time1;
          time1 = widget.t1;
          DateTime t11 = time1.toDate();
          finalDate = t11.difference(t2).inHours;
        }
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: (loading == false)
                ? Column(
                    children: [
                      Text(
                        "\nCoin Store\n",
                        style:
                            TextStyle(fontFamily: 'PopB', fontSize: w * 0.055),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/daimond2.PNG"),
                          Column(
                            children: [
                              Text(
                                '  ${widget.coins}',
                                style: TextStyle(
                                    fontFamily: 'PopB', fontSize: w * 0.05),
                              ),
                              Text(
                                "  my points",
                                style: TextStyle(
                                    fontFamily: 'PopB', fontSize: w * 0.03),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: w * 0.55,
                        padding: const EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, bottom: h * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme().mC,
                        ),
                        child: Text(
                          "        Free Recharge\n          Daily Task",
                          style: TextStyle(
                              fontFamily: 'PopB',
                              fontSize: w * 0.05,
                              color: Colors.black),
                        ),
                      ),
                      (finalDate > 25)
                          ? Row(
                              children: [
                                (widget.awardNo == 0)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 10,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 1,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(10);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 10))
                                    : cont(w, h, 10),
                                (widget.awardNo == 1 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 20,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 2,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(20);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 20))
                                    : cont(w, h, 20),
                                (widget.awardNo == 2 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 30,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 3,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(30);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 30))
                                    : cont(w, h, 30),
                                (widget.awardNo == 3 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 40,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 4,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(40);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 40))
                                    : cont(w, h, 40),
                                (widget.awardNo == 4 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 50,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 5,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(50);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 50))
                                    : cont2(w, h, 50),
                              ],
                            )
                          : Center(
                              child: Text(
                                "\n\nYou have Already Collected the award\n\n",
                                style: TextStyle(
                                    fontFamily: 'PopB', fontSize: w * 0.05),
                              ),
                            ),
                      (finalDate > 25)
                          ? Row(
                              children: [
                                (widget.awardNo == 5 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 70,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 6,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(70);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 70))
                                    : cont2(w, h, 70),
                                (widget.awardNo == 6 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 80,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 7,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(80);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 80))
                                    : cont(w, h, 80),
                                (widget.awardNo == 7 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 90,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 8,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(90);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 90))
                                    : cont(w, h, 90),
                                (widget.awardNo == 8 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 100,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 9,
                                            'time':
                                                FieldValue.serverTimestamp(),
                                          });
                                          snack(100);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 100))
                                    : cont(w, h, 100),
                                (widget.awardNo == 9 && finalDate > 24)
                                    ? InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(widget.uid)
                                              .update({
                                            'points': widget.coins + 150,
                                          });
                                          await FirebaseFirestore.instance
                                              .collection('award')
                                              .doc(widget.uid)
                                              .update({
                                            'awardNumber': 0,
                                          });
                                          snack(150);
                                          Navigator.of(context).pop();
                                        },
                                        child: cont(w, h, 150))
                                    : cont(w, h, 150),
                              ],
                            )
                          : Container(),
                      InkWell(
                        onTap: () async {
                          Get.to(() => Recharge());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme().mC,
                          ),
                          child: Text(
                            "         Point Recharge        ",
                            style: TextStyle(
                                fontFamily: 'PopB',
                                fontSize: w * 0.05,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }

  Widget cont(double w, double h, int number) {
    return Column(
      children: [
        Text(
          '$number',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.all(w * 0.01),
          width: w * 0.179,
          height: h * 0.2,
          child: Image.asset(
            "assets/award.PNG",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget cont2(double w, double h, int number) {
    return Column(
      children: [
        Text(
          '$number',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          color: Colors.black,
          margin: EdgeInsets.all(w * 0.01),
          width: w * 0.179,
          height: h * 0.2,
          child: Image.asset(
            "assets/award.PNG",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  void snack(int p) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text('$p points Collected, visit tomorrow to have more'),
      backgroundColor: (Colors.blueAccent),
      action: SnackBarAction(
        label: 'okay',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
