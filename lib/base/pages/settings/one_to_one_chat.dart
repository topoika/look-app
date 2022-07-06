import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/controllers/chat_controller.dart';
import 'package:look/base/models/message_model.dart';
import 'package:look/base/pages/utils/chat_bubble.dart';
import 'package:look/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../repositories/user_repository.dart';

class AdminInquiry extends StatefulWidget {
  AdminInquiry({Key? key}) : super(key: key);

  @override
  _AdminInquiryState createState() => _AdminInquiryState();
}

class _AdminInquiryState extends StateMVC<AdminInquiry> {
  late ChatController _con;
  _AdminInquiryState() : super(ChatController()) {
    _con = controller as ChatController;
  }
  TextEditingController messageText = TextEditingController();
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
        title: Column(
          children: [
            Text("1:1 ${S.of(context).inquiry}"),
            Text(
              S.of(context).what_can_i_help_you + "?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: getHorizontal(context) * 0.035,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getHorizontal(context) * 0.04,
          vertical: getVertical(context) * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: _con.firebaseFirestore
                      .collection(_con.adminCollection)
                      .doc(currentUser.value.uid)
                      .collection(_con.chatsCollection)
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: Text(
                              S
                                  .of(context)
                                  .ask_any_question_and_admin_will_respond_immediatelly,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = Message.fromMap(
                                  snapshot.data!.docs[index].data());
                              return ChatBubbleWidget(
                                sendByMe: message.sendBy!.uid !=
                                    currentUser.value.uid,
                                message: message,
                              );
                            },
                          );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        fontSize: getHorizontal(context) * 0.038,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.attach_file,
                          color: Colors.black87,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (messageText.text.trim().isNotEmpty) {
                              _con.addAdminMessage(
                                context,
                                messageText.text,
                              );
                              messageText.clear();
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.black87,
                          ),
                        ),
                        hintText: "${S.of(context).type_message} ...",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: getHorizontal(context) * 0.037,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
