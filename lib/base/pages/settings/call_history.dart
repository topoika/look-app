import 'package:flutter/material.dart';

class CallsHistory extends StatefulWidget {
  CallsHistory({Key? key}) : super(key: key);

  @override
  State<CallsHistory> createState() => _CallsHistoryState();
}

class _CallsHistoryState extends State<CallsHistory> {
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
        title: Text("Call History"),
      ),
      body: Container(),
    );
  }
}
