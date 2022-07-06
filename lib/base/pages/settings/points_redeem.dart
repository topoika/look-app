import 'package:flutter/material.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/utils/button.dart';

import '../../../generated/l10n.dart';
import '../../Helper/dimension.dart';
import '../../repositories/user_repository.dart';

class PointRedeem extends StatefulWidget {
  PointRedeem({Key? key}) : super(key: key);

  @override
  State<PointRedeem> createState() => _PointRedeemState();
}

class _PointRedeemState extends State<PointRedeem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: Text(""),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.04),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    S.of(context).redeem_points,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getHorizontal(context) * 0.07,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: S.of(context).my_points,
                      style: TextStyle(
                          fontSize: getHorizontal(context) * 0.04,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: "    " +
                              currentUser.value.points.toString() +
                              "P",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: getHorizontal(context) * 0.04),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getVertical(context) * 0.05),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: getHorizontal(context) * 0.038,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration:
                      decoration(S.of(context).point_to_be_refund, "3000P"),
                ),
                SizedBox(height: getVertical(context) * 0.02),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: getHorizontal(context) * 0.038,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: decoration(S.of(context).account_text, null),
                ),
                SizedBox(height: getVertical(context) * 0.02),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: getHorizontal(context) * 0.038,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: decoration(S.of(context).depositor_text, null),
                ),
                SizedBox(height: getVertical(context) * 0.02),
                text(S.of(context).notice_text),
                text(S.of(context).the_minimum_redeem_point_is + " 2500p "),
                text(S.of(context).we_deduct +
                    " 500$currency " +
                    S.of(context).deposit_fee_and +
                    " 3.3% " +
                    S.of(context).vat_text),
                text("2500P = 4335$currency"),
                SizedBox(height: getVertical(context) * 0.06),
                buttonWidget(context, () {}, S.of(context).confirm_text)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String txt) => Text(
        txt,
        style: TextStyle(
            fontSize: getHorizontal(context) * 0.035,
            color: Colors.black54,
            fontWeight: FontWeight.bold),
      );

  InputDecoration decoration(String hint, String? suffix) => InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: Colors.black87,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: Colors.black87,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: Colors.black87,
          ),
        ),
        suffix: Text(
          suffix ?? "",
          style: TextStyle(
              fontSize: getHorizontal(context) * 0.035,
              color: Colors.red[700],
              fontWeight: FontWeight.w700),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: Colors.black87,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.w800,
          fontSize: getHorizontal(context) * 0.037,
        ),
      );
}
