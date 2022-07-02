import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/settings/settings.dart';
import 'package:look/generated/l10n.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.05, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.redAccent),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).you_are_availble_online_video_call_now_waiting,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: getHorizontal(context) * 0.04,
                  color: Colors.white,
                ),
          ),
          spacing(getVertical(context) * 0.024),
          Text(
            "${S.of(context).note_text} : ${S.of(context).not_allowed_to_upload_any_ponographic}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: getHorizontal(context) * 0.037,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
