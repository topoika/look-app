import 'package:flutter/material.dart';
import 'package:look/generated/l10n.dart';

import '../../Helper/dimension.dart';

class PublicNotice extends StatefulWidget {
  PublicNotice({Key? key}) : super(key: key);

  @override
  State<PublicNotice> createState() => _PublicNoticeState();
}

class _PublicNoticeState extends State<PublicNotice> {
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
        title: Text(S.of(context).public_notice),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          itemCount: 8,
          physics: ScrollPhysics(),
          itemBuilder: (context, index) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  thickness: 1.2,
                  color: Colors.black54,
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.04),
                  child: Text(
                    "2021.05.0$index",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black54,
                          fontSize: getHorizontal(context) * 0.045,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.04),
                  child: Text(
                    "Public notice for today is really cool and you gonna love it",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black54,
                          fontSize: getHorizontal(context) * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontal(context) * 0.04, vertical: 10),
                  color: Colors.red.withOpacity(.4),
                  child: Text(
                      'Public notice for today is really cool and you gonna love it Public notice for today is really cool and you gonna love it Public notice for today is really cool and you gonna love it'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
