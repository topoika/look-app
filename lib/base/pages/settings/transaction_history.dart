import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';
import 'my_invitees.dart';

class TransactionHistory extends StatefulWidget {
  TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
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
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => Table(
                border: TableBorder.all(
                    color: Colors
                        .transparent), // Allows to add a border decoration around your table
                children: [
                  TableRow(
                    children: [
                      tableItem(context, "2022-05-01"),
                      tableItem(context, "david wiil"),
                      tableItem(context, "00:5:20"),
                      tableItem(context, "1200"),
                    ],
                  ),
                ],
              ),
            ),
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
                    tableItem(context, "120000"),
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
