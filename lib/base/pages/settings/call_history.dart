import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/controllers/calls_controller.dart';
import 'package:look/base/models/videocall.dart';
import 'package:look/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Helper/dimension.dart';
import '../../Helper/helper.dart';
import '../../repositories/user_repository.dart';
import 'my_invitees.dart';

class CallsHistory extends StatefulWidget {
  CallsHistory({Key? key}) : super(key: key);

  @override
  _CallsHistoryState createState() => _CallsHistoryState();
}

class _CallsHistoryState extends StateMVC<CallsHistory> {
  late CallsController _con;
  _CallsHistoryState() : super(CallsController()) {
    _con = controller as CallsController;
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
        title: Text(S.of(context).call_history),
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
                    tableItem(context, S.of(context).age_text),
                    tableItem(context, S.of(context).city_text),
                    tableItem(context, S.of(context).time_text),
                  ],
                ),
              ],
            ),
            StreamBuilder(
                stream: _con.firestore
                    .collection(_con.callsCollection)
                    .where('id', isEqualTo: currentUser.value.uid)
                    .orderBy("time", descending: true)
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
                            var call = VideoCall.fromMap(
                                snapshot.data!.docs[index].data());
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
                                            call.time!, "date")!),
                                    tableItem(
                                        context, call.name!.toLowerCase()),
                                    tableItem(context,
                                        call.reciever!.age!.toString()),
                                    tableItem(context,
                                        "${call.reciever!.location!.split(" ")[0].replaceAll(",", "")}"),
                                    tableItem(context,
                                        "${call.hours ?? "00"} :${call.minutes ?? "00"}:${call.seconds ?? "00"}")
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
}
