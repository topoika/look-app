// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:look/base/pages/utils/snackbar.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';
import '../../controllers/livestream_controller.dart';
import '../../models/live_stream_model.dart';
import 'button.dart';

class AddTitleBottomSheet extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AddTitleBottomSheet({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  _AddTitleBottomSheetState createState() => _AddTitleBottomSheetState();
}

class _AddTitleBottomSheetState extends StateMVC<AddTitleBottomSheet> {
  late LiveStreamController _con;
  _AddTitleBottomSheetState() : super(LiveStreamController()) {
    _con = controller as LiveStreamController;
  }
  LiveStream _liveStream = LiveStream();
  TextEditingController _liveTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.03),
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.04, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Enter the title of your liveStream',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: getHorizontal(context) * 0.04,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (val) => _liveStream.title = val,
                controller: _liveTitle,
                decoration: InputDecoration(
                  hintText: "your-name livestream",
                  labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
                  contentPadding: const EdgeInsets.all(12),
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                ),
              ),
              buttonWidget(context, () {
                if (_liveTitle.text.length < 3) {
                  Navigator.pop(context);
                  showSnackBar(context, "Enter 3+ char for the title", true);
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _liveStream.title = _liveTitle.text;
                  _con.createLiveStream(context, _liveStream);
                }
              }, S.of(context).continue_text)
            ],
          ),
        ),
      ),
    );
  }
}
