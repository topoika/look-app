import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/controllers/user_controller.dart';
import 'package:look/base/models/user_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../generated/l10n.dart';
import '../../repositories/user_repository.dart';

class MyInvitee extends StatefulWidget {
  MyInvitee({Key? key}) : super(key: key);

  @override
  _MyInviteeState createState() => _MyInviteeState();
}

class _MyInviteeState extends StateMVC<MyInvitee> {
  late UserController _con;
  _MyInviteeState() : super(UserController()) {
    _con = controller as UserController;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: Text(S.of(context).my_invitee),
        actions: [
          GestureDetector(
            onTap: () => share(),
            child: Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
          SizedBox(width: getHorizontal(context) * 0.04),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.04, vertical: 10),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(
                  children: [
                    tableItem(context, S.of(context).created_text),
                    tableItem(context, S.of(context).full_name),
                    tableItem(context, S.of(context).gender_text),
                    tableItem(context, S.of(context).age_text),
                    tableItem(context, S.of(context).location_text),
                  ],
                ),
              ],
            ),
            StreamBuilder(
                stream: _con.firebaseFirestore
                    .collection(_con.userCollection)
                    .where('invitee', isEqualTo: currentUser.value.uid)
                    .orderBy("joined", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return !snapshot.hasData
                      ? SizedBox()
                      : ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var user =
                                User.fromMap(snapshot.data!.docs[index].data());
                            return Table(
                              border: TableBorder.all(
                                  color: Colors
                                      .transparent), // Allows to add a border decoration around your table
                              children: [
                                TableRow(
                                  children: [
                                    tableItem(
                                        context,
                                        getDateFormatedFromString(
                                            user.joined!, "date")!),
                                    tableItem(
                                        context, user.name!.toLowerCase()),
                                    tableItem(context, user.gender!),
                                    tableItem(context, user.age!.toString()),
                                    tableItem(context,
                                        "${user.location!.split(" ")[0].replaceAll(",", "")} ${user.country}"),
                                  ],
                                ),
                              ],
                            );
                          });
                }),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share invitation code',
        text: 'Share your link to earn more invitee and points',
        linkUrl: "DHLKSIJJISDJ",
        chooserTitle: 'Example Chooser Title');
  }
}

Widget tableItem(BuildContext context, String text) => Padding(
      padding: EdgeInsets.symmetric(vertical: getVertical(context) * 0.009),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black54,
            fontSize: getHorizontal(context) * 0.026),
      ),
    );
