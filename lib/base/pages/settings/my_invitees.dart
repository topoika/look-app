import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../generated/l10n.dart';

class MyInvitee extends StatefulWidget {
  MyInvitee({Key? key}) : super(key: key);

  @override
  State<MyInvitee> createState() => _MyInviteeState();
}

class _MyInviteeState extends State<MyInvitee> {
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
                    tableItem(context, "created"),
                    tableItem(context, "full name"),
                    tableItem(context, "gender"),
                    tableItem(context, "age"),
                    tableItem(context, "location"),
                  ],
                ),
              ],
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => Table(
                border: TableBorder.all(
                    color: Colors
                        .transparent), // Allows to add a border decoration around your table
                children: [
                  TableRow(
                    children: [
                      tableItem(context, "2022-05-01"),
                      tableItem(context, "david wiil"),
                      tableItem(context, "male"),
                      tableItem(context, "22"),
                      tableItem(context, "Nairobi kenya"),
                    ],
                  ),
                ],
              ),
            ),
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
            fontSize: getHorizontal(context) * 0.028),
      ),
    );
