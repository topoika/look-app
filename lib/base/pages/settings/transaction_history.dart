import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/helper.dart';
import 'package:look/base/controllers/payement_controller.dart';
import 'package:look/base/models/transaction.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';
import '../../repositories/user_repository.dart';
import 'my_invitees.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends StateMVC<TransactionHistory> {
  late PaymentController _con;
  _TransactionHistoryState() : super(PaymentController()) {
    _con = controller as PaymentController;
  }
  int totalPoints = 0;
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
        title: Text(S.of(context).transaction_history),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.04, vertical: 10),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: 1,
                  color: Colors.black54,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
              margin: EdgeInsets.symmetric(vertical: 13),
              child: Column(
                children: <Widget>[
                  Table(
                    border: TableBorder.all(
                        color: Colors
                            .transparent), // Allows to add a border decoration around your table
                    children: [
                      TableRow(
                        children: [
                          tableItem(context, "recharge or earning"),
                          tableItem(context, "using or redeem"),
                          tableItem(context, "balance"),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black87,
                    thickness: 1,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors
                            .transparent), // Allows to add a border decoration around your table
                    children: [
                      TableRow(
                        children: [
                          Text(
                            "2560",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                fontSize: getHorizontal(context) * 0.029),
                          ),
                          Text(
                            "2200",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                fontSize: getHorizontal(context) * 0.029),
                          ),
                          Text(
                            "340",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                fontSize: getHorizontal(context) * 0.029),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Table(
              border: TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                TableRow(
                  children: [
                    tableItem(context, "created"),
                    tableItem(context, "name"),
                    tableItem(context, "time"),
                    tableItem(context, "point"),
                  ],
                ),
              ],
            ),
            StreamBuilder(
                stream: _con.firebaseFirestore
                    .collection(_con.transCollection)
                    .where('doneBy', isEqualTo: currentUser.value.uid)
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
                            var trans = Transactions.fromMap(
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
                                            trans.created!, "date")!),
                                    tableItem(context, trans.name!),
                                    tableItem(context,
                                        getTimeDifference(trans.created!)!),
                                    tableItem(context, trans.points.toString()),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                }),
            Divider(
              color: Colors.black87,
              thickness: 1,
              height: 15,
            ),
            Table(
              border: TableBorder.all(
                  color: Colors
                      .transparent), // Allows to add a border decoration around your table
              children: [
                TableRow(
                  children: [
                    tableItem(context, ""),
                    tableItem(context, ""),
                    tableItem(context, ""),
                    tableItem(context, "4000"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
